#!/usr/bin/env bash

# @file: ccsk (ccsk.sh)
# @date: Sat, Sep 20, 2025  9:24:24 PM
# @version:    0.0.1
# @info: create class skeleton

FILE='ccsk.sh'
VERSION='0.0.1'
FILE_DATE='Tue, Dec 30, 2025  4:45:03 AM'

FMT_FG_RED='\e[31m'
FMT_FG_GREEN='\e[32m'
FMT_RESET='\e[0m'
PRINT_RED_DEBUG=${FMT_FG_RED}DEBUG${FMT_RESET}
PRINT_GREEN_INFO=${FMT_FG_GREEN}INFO${FMT_RESET}
DATE=$(date "+%H:%M:%S:%s")

DEBUG_MSG="$PRINT_RED_DEBUG: "
INFO_MSG="$PRINT_GREEN_INFO: "
VERBOSE=1
DEBUG=
CONFIG_FILE=

if [ -n $VERBOSE ]
then
	echo ${VERBOSE:+"File - $FILE"}
	echo ${VERBOSE:+"Version - $VERSION"}
	echo ${VERBOSE:+"Date - $FILE_DATE"}
fi

function PRINT_DEBUG
{
    MSG=${DEBUG_MSG}$1
    echo -e ${DEBUG:+"$MSG"}
}
function PRINT_INFO
{
    MSG=${INFO_MSG}$1
    echo -e ${VERBOSE:+"$MSG"}
}

function print_help()
{
	echo "Usage:"
	echo "ccsk -[vhtc] PROJECT_NAME [BASE_CLASS_NAME]"
	echo "-h, display this help message"
	echo "-v, display version"
	echo "-t, include cppunit test"
	echo "-c, create cmake project"
	date
}

CMAKE=
CPPUNIT=
CTOR=FALSE
DTOR=TRUE
CCTOR=TRUE
OVERLOAD_EQUAL=FALSE
IMP_DEFAULTS=FALSE

OPTSTRING="vcdeqmhi"
while getopts ${OPTSTRING} opt; do
    case ${opt} in
        v)
            INFO
            echo -e "${FMT_FG_GREEN}${VERSION}${FMT_FG_RED} ${DEBUG:-debug}${FMT_RESET}"
            exit 0
            ;;
        h)
            print_help
			exit 0;
            ;;
        c)
            CCTOR="TRUE"
            PRINT_DEBUG CCTOR=$CCTOR
            ;;
        d)
            DTOR="TRUE"
            PRINT_DEBUG DTOR=$DTOR
            ;;
        e)
            CTOR=TRUE
            PRINT_DEBUG CTOR=$CTOR
            ;;
        m)
            IMP_DEFAULTS=TRUE
            PRINT_DEBUG IMP_DEFAULTS=$IMP_DEFAULTS
            ;;
        q)
            OVERLOAD_EQUAL=TRUE
            PRINT_DEBUG OVERLOAD_EQUAL=$OVERLOAD_EQUAL
            ;;
        :)
            echo "Option -${OPTARG} requires an argument."
            exit 1
            ;;
        ?)
            echo "Invalid option: -${OPTARG}."
            exit 1
            ;;
    esac
done
shift $(($OPTIND-1))

NAME=$1
BASE_NAME=$2

php "$HOME/.config/csk/class.hpp.php" "${NAME}" "${BASE_NAME}" "${DTOR}" "${CCTOR}" "${DCTOR}" "${IMP_DEFAULTS}" "${OVERLOAD_EQUAL}" "0.0.1" | tee "${NAME}.hpp"
php "$HOME/.config/csk/class.cpp.php" "${NAME}" "${BASE_NAME}" "${DTOR}" "${CCTOR}" "${DCTOR}" "${IMP_DEFAULTS}" "${OVERLOAD_EQUAL}" "0.0.1" | tee "${NAME}.cpp"
