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

show_help()
{
    echo "Usage:"
    echo "install -[vh]"
    echo "-h, deispay this"
    echo "-v, diplay version"
    date
}

OPTSTRING="vhf"
while getopts ${OPTSTRING} opt; do
  case ${opt} in
    v)
      INFO
      echo -e "${FMT_FG_GREEN}${VERSION}${FMT_FG_RED} ${DEBUG:-debug}${FMT_RESET}"
      exit 0
      ;;
    h)
      HELP
      exit 0;
      ;;
    f)
      CONFIG_FILE=${OPTSTRING}
      ;;
	:)
      PRINT_DEBUG "Option -${OPTARG} requires an argument."
      exit 1
      ;;
    ?)
      PRINT_DEBUG "Invalid option: -${OPTARG}."
      exit 1
      ;;
  esac
done
shift $(($OPTIND-1))


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

# set $ROOT to default $HOME
ROOT="${HOME}"
# find .cskconfig
# search current woking dir
if [ -f "./.cskconfig" ]; then
    source ./.cskconfig
# search $HOME
elif [ -f "${HOME}/.cskconfig" ]; then
    source "${HOME}/.cskconfig"
# search local bin
elif [ -f "${HOME}/bin/.cskconfig" ]; then
    source "${HOME}/bin/.cskconfig"
fi

CONFIG="${ROOT}/.config/csk"
BIN=$ROOT/bin
PRINT_DEBUG ROOT=$ROOT
PRINT_DEBUG BIN=$BIN
PRINT_DEBUG CONFIG=$CONFIG

PRINT_INFO "copying project templates ..."
mkdir -p "${ROOT}/.config/csk"
# install to .config
cp -rf src/* "${ROOT}/.config/csk"
#  install to local bin
cp "src/csk.sh" "${ROOT}/bin/"
cp "src/ccsk.sh" "${ROOT}/bin/"

PRINT_INFO "set permissions ..."
# set exe perm just in case
chmod +x "${ROOT}/bin/csk.sh"
chmod +x "${ROOT}/bin/ccsk.sh"
chmod +x "${ROOT}/.config/csk/*.php"

PRINT_INFO "create links (csk & ccsk) ..."
# create easy name soft link
ln -s "${ROOT}/bin/csk.sh" "${ROOT}/bin/csk"
ln -s "${ROOT}/bin/ccsk.sh" "${ROOT}/bin/ccsk"

PRINT_INFO "Finished installing."
PRINT_INFO "$FILE -> Exiting.   @ $DATE"
