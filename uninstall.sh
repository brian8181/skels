#!/bin/bash

# File Name:  ./uninstall.sh
# Build Date: Fri, Dec 19, 2025 12:52:59 AM
# Version:    0.0.1

FILE='uninstall.sh'
VERSION='0.0.1'
FILE_DATE='Fri, Dec 19, 2025 12:52:59 AM'

FMT_FG_RED='\e[31m'
FMT_FG_GREEN='\e[32m'
FMT_RESET='\e[0m'
PRINT_RED_DEBUG=${FMT_FG_RED}DEBUG${FMT_RESET}
PRINT_GREEN_INFO=${FMT_FG_GREEN}INFO${FMT_RESET}
DATE=$(date "+%H:%M:%S:%s")

DEBUG_MSG="$PRINT_RED_DEBUG: "
INFO_MSG="$PRINT_GREEN_INFO: "
VERBOSE=1
DEBUG=1

if [ -n $VERBOSE ]
then
	echo ${VERBOSE:+"File - $FILE"}.
	echo ${VERBOSE:+"Version - $VERSION"}.
	echo ${VERBOSE:+"Date - $FILE_DATE"}.
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

PRINT_INFO "$FILE -> Running ... @ $DATE"
PRINT_INFO "remove existing project templates ..."

source .cskconfig

# uninstall
rm -rf "${ROOT}/.config/csk"
rm "${ROOT}/bin/csk.sh"
rm "${ROOT}/bin/ccsk.sh"
rm "${ROOT}/bin/csk"
rm "${ROOT}/bin/ccsk"

PRINT_INFO "Finished uninstalling."
PRINT_INFO "$FILE -> Exiting.   @ $DATE"
