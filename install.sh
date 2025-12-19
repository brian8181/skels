#!/bin/bash

# File Name:  ./install.sh
# Build Date: Fri, Dec 19, 2025 12:52:59 AM
# Version:    0.0.1

FILE='./install.sh'
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

PRINT_INFO "$FILE -> Running ... @ $DATE"

DIR=$(dirname "$0")
NAME=$(basename "$0")

if [[ "$DIR" != "." && "NAME" != "install.sh" ]]; then
    PRINT_DEBUG "Error: must be run from project directory ..."
    PRINT_DEBUG "$FILE -> Exiting.   @ $DATE"
    exit -1
fi

# install
PRINT_INFO "Installing scripts ..."

# unintsall before existing files
./uninstall.sh

ROOT="${HOME}"
if [ ! -f "./.cskconfig" ]; then
    source ./.cskconfig
elif [ ! -f "${HOME}/.cskconfig" ]; then
    source "${HOME}/.cskconfig"
fi

#BIN="${ROOT}/.config/csk"
#PROJ="./src/${NAME}"

PRINT_INFO "copying project templates ..."
mkdir -p "${ROOT}/.config/csk"
# install to .config
cp src/*.php "${ROOT}/.config/csk"
#  install to local bin
cp "src/csk.sh" "${ROOT}/bin/"
cp "src/ccsk.sh" "${ROOT}/bin/"

PRINT_INFO "set permissions ..."
# set exe perm just in case
chmod +x "${ROOT}/bin/csk.sh"
chmod +x "${ROOT}/bin/ccsk.sh"
chmod +x "${ROOT}"/.config/csk/*.php

PRINT_INFO "create links (csk & ccsk) ..."
# create easy name soft link
ln -s "${ROOT}/bin/csk.sh" "${ROOT}/bin/csk"
ln -s "${ROOT}/bin/ccsk.sh" "${ROOT}/bin/ccsk"
PRINT_INFO "Finished installing."
PRINT_INFO "$FILE -> Exiting.   @ $DATE"
