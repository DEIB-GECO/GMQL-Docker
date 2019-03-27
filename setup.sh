#!/bin/bash

spark_url="https://archive.apache.org/dist/spark/spark-2.2.0/spark-2.2.0-bin-hadoop2.7.tgz"
gmql_docker_name="gmql"


get_latest_release() {
	echo "Downloading latest GMQL-WEB relase"
	latest_release_url=$(curl --silent "https://api.github.com/repos/$1/releases/latest" | \
	grep '"browser_download_url"' | \
	awk -F": " '{print $2}' | sed 's/"//g')

	echo "Latest release URL: ${latest_release_url}"
	wget -q $latest_release_url

	file_name=$(echo $latest_release_url | awk -F"/" '{print $NF}')
	echo "File name is $file_name"

	unzip -qq $file_name
	gmql_web_dir=$(echo "$file_name" | rev | cut -f 2- -d '.' | rev)
	rm $file_name
}

get_spark() {
	echo "Downloading Spark"
	wget -q $spark_url

	spark_file=$(echo $spark_url | awk -F"/" '{print $NF}')
	tar xfs $spark_file
	spark_dir=$(echo "$spark_file" | rev | cut -f 2- -d '.'| rev)
	rm $spark_file
}


set_configurations() {
	# substituting values in configuration files
	echo "Setting the configurations"
	# application.conf
	echo "---- application.conf ----"
	sed -i 's/databasePath = .*/databasePath = \/app\/gmql_repository/' ${gmql_web_dir}/conf/application.conf
	cat ${gmql_web_dir}/conf/application.conf

	# executor.xml
	echo "---- executor.xml ----"
	sed -i "s/<property name=\"SPARK_HOME\">.*<\/property>/<property name=\"SPARK_HOME\">\/app\/${spark_dir}\/<\/property>/g" ${gmql_web_dir}/conf/gmql_conf/executor.xml
	cat ${gmql_web_dir}/conf/gmql_conf/executor.xml

	# repository.xml
	echo "---- repository.xml ----"
	sed -i "s/<property name=\"GMQL_LOCAL_HOME\">.*<\/property>/<property name=\"GMQL_LOCAL_HOME\">\/app\/gmql_repository\/<\/property>/g" ${gmql_web_dir}/conf/gmql_conf/repository.xml
	sed -i "s/<property name=\"GMQL_REPO_TYPE\">.*<\/property>/<property name=\"GMQL_REPO_TYPE\">LOCAL<\/property>/g" ${gmql_web_dir}/conf/gmql_conf/repository.xml
	cat ${gmql_web_dir}/conf/gmql_conf/repository.xml
}


docker_login() {
	echo "Logging in into DockerHub"
	docker login --username=$DOCKERHUB_USERNAME --password=$DOCKERHUB_PASSWORD
}


build_docker() {
	echo "Building GMQL docker"
	docker build . -t $DOCKERHUB_USERNAME/$gmql_docker_name \
				--build-arg gmql_dir=./${gmql_web_dir}/ \
				--build-arg spark_dir=./${spark_dir}/
}


push_docker() {
	echo "Pushing docker image to DockerHub"
	docker push $DOCKERHUB_USERNAME/$gmql_docker_name
}


get_latest_release "DEIB-GECO/GMQL-WEB"
get_spark
set_configurations
docker_login
build_docker
push_docker
