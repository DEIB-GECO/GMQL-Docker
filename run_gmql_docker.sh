#!/bin/bash
#
# This is a rather minimal example Argbash potential
# Example taken from http://argbash.readthedocs.io/en/stable/example.html
#
# ARG_OPTIONAL_SINGLE([conf-repository],[r],[path to custom repository.xml])
# ARG_OPTIONAL_SINGLE([conf-executor],[e],[path to custom executor.xml])
# ARG_OPTIONAL_SINGLE([gmql_repository],[g],[path to custom repository location])
# ARG_POSITIONAL_SINGLE([port],[port],[11110])
# ARG_HELP([Start the execution of a GMQL instance])
# ARGBASH_GO()
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.6.1 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info
# Generated online by https://argbash.io/generate

# When called, the process ends.
# Args:
# 	$1: The exit message (print to stderr)
# 	$2: The exit code (default is 1)
# if env var _PRINT_HELP is set to 'yes', the usage is print to stderr (prior to )
# Example:
# 	test -f "$_arg_infile" || _PRINT_HELP=yes die "Can't continue, have to supply file as an argument, got '$_arg_infile'" 4
die()
{
	local _ret=$2
	test -n "$_ret" || _ret=1
	test "$_PRINT_HELP" = yes && print_help >&2
	echo "$1" >&2
	exit ${_ret}
}

# Function that evaluates whether a value passed to it begins by a character
# that is a short option of an argument the script knows about.
# This is required in order to support getopts-like short options grouping.
begins_with_short_option()
{
	local first_option all_short_options
	all_short_options='regh'
	first_option="${1:0:1}"
	test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}



# THE DEFAULTS INITIALIZATION - POSITIONALS
# The positional args array has to be reset before the parsing, because it may already be defined
# - for example if this script is sourced by an argbash-powered script.
_positionals=()
_arg_port="11110"
# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_conf_repository=
_arg_conf_executor=
_arg_gmql_repository=

# Function that prints general usage of the script.
# This is useful if users asks for it, or if there is an argument parsing error (unexpected / spurious arguments)
# and it makes sense to remind the user how the script is supposed to be called.
print_help ()
{
	printf '%s\n' "Start the execution of a GMQL instance"
	printf 'Usage: %s [-r|--conf-repository <arg>] [-e|--conf-executor <arg>] [-g|--gmql_repository <arg>] [-h|--help] [<port>]\n' "$0"
	printf '\t%s\n' "<port>: port (default: '11110')"
	printf '\t%s\n' "-r,--conf-repository: path to custom repository.xml (no default)"
	printf '\t%s\n' "-e,--conf-executor: path to custom executor.xml (no default)"
	printf '\t%s\n' "-g,--gmql_repository: path to custom repository location (no default)"
	printf '\t%s\n' "-h,--help: Prints help"
}

# The parsing of the command-line
parse_commandline ()
{
	while test $# -gt 0
	do
		_key="$1"
		case "$_key" in
			# We support whitespace as a delimiter between option argument and its value.
			# Therefore, we expect the --conf-repository or -r value.
			# so we watch for --conf-repository and -r.
			# Since we know that we got the long or short option,
			# we just reach out for the next argument to get the value.
			-r|--conf-repository)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_conf_repository="$2"
				shift
				;;
			# We support the = as a delimiter between option argument and its value.
			# Therefore, we expect --conf-repository=value, so we watch for --conf-repository=*
			# For whatever we get, we strip '--conf-repository=' using the ${var##--conf-repository=} notation
			# to get the argument value
			--conf-repository=*)
				_arg_conf_repository="${_key##--conf-repository=}"
				;;
			# We support getopts-style short arguments grouping,
			# so as -r accepts value, we allow it to be appended to it, so we watch for -r*
			# and we strip the leading -r from the argument string using the ${var##-r} notation.
			-r*)
				_arg_conf_repository="${_key##-r}"
				;;
			# See the comment of option '--conf-repository' to see what's going on here - principle is the same.
			-e|--conf-executor)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_conf_executor="$2"
				shift
				;;
			# See the comment of option '--conf-repository=' to see what's going on here - principle is the same.
			--conf-executor=*)
				_arg_conf_executor="${_key##--conf-executor=}"
				;;
			# See the comment of option '-r' to see what's going on here - principle is the same.
			-e*)
				_arg_conf_executor="${_key##-e}"
				;;
			# See the comment of option '--conf-repository' to see what's going on here - principle is the same.
			-g|--gmql_repository)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_gmql_repository="$2"
				shift
				;;
			# See the comment of option '--conf-repository=' to see what's going on here - principle is the same.
			--gmql_repository=*)
				_arg_gmql_repository="${_key##--gmql_repository=}"
				;;
			# See the comment of option '-r' to see what's going on here - principle is the same.
			-g*)
				_arg_gmql_repository="${_key##-g}"
				;;
			# The help argurment doesn't accept a value,
			# we expect the --help or -h, so we watch for them.
			-h|--help)
				print_help
				exit 0
				;;
			# We support getopts-style short arguments clustering,
			# so as -h doesn't accept value, other short options may be appended to it, so we watch for -h*.
			# After stripping the leading -h from the argument, we have to make sure
			# that the first character that follows coresponds to a short option.
			-h*)
				print_help
				exit 0
				;;
			*)
				_positionals+=("$1")
				;;
		esac
		shift
	done
}


# Check that we receive expected amount positional arguments.
# Return 0 if everything is OK, 1 if we have too little arguments
# and 2 if we have too much arguments
handle_passed_args_count ()
{
	test ${#_positionals[@]} -le 1 || _PRINT_HELP=yes die "FATAL ERROR: There were spurious positional arguments --- we expect between 0 and 1, but got ${#_positionals[@]} (the last one was: '${_positionals[*]: -1}')." 1
}

# Take arguments that we have received, and save them in variables of given names.
# The 'eval' command is needed as the name of target variable is saved into another variable.
assign_positional_args ()
{
	# We have an array of variables to which we want to save positional args values.
	# This array is able to hold array elements as targets.
	_positional_names=('_arg_port' )

	for (( ii = 0; ii < ${#_positionals[@]}; ii++))
	do
		eval "${_positional_names[ii]}=\${_positionals[ii]}" || die "Error during argument parsing, possibly an Argbash bug." 1
	done
}

# Now call all the functions defined above that are needed to get the job done
parse_commandline "$@"
handle_passed_args_count
assign_positional_args

# OTHER STUFF GENERATED BY Argbash

### END OF CODE GENERATED BY Argbash (sortof) ### ])
# [ <-- needed because of Argbash


docker run -d --rm -p ${_arg_port}:8000 \
    --name gmql_${_arg_port} \
    ${_arg_gmql_repository:+ -v "$_arg_gmql_repository:/app/gmql_repository/"} \
    ${_arg_repository_config:+ -v "$_arg_repository_config:/app/gmql_web/conf/gmql_conf/repository.xml"} \
    ${_arg_executor_config:+ -v "$_arg_executor_config:/app/gmql_web/conf/gmql_conf/executor.xml"} \
    gecopolimi/gmql

# ] <-- needed because of Argbash
