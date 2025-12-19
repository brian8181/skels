#!/bin/bash

# @file: csk (csk.sh)
# @date: Fri, Dec 19, 2025 12:52:59 AM
# @version:    0.0.1
# @info: create project skeleton

FMT_FG_RED='\e[31m'
FMT_FG_GREEN='\e[32m'
FMT_RESET='\e[0m'

DEBUG_MSG="$PRINT_RED_DEBUG: "
INFO_MSG="$PRINT_GREEN_INFO: "
VERBOSE=1
DEBUG=

CMAKE=
CPPUNIT=
SIMPLE=FALSE

OPTSTRING="vhts"
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
        t)
            CPPUNIT="TRUE"
            ;;
        c)
            CMAKE="TRUE"
            ;;
        s)
            SIMPLE="TRUE"
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
INFO=$2
VERSION="version 0.0.1";

ROOT="${HOME}"
if [ ! -f "./.cskconfig" ]; then
    source ./.cskconfig
elif [ ! -f "${HOME}/.cskconfig" ]; then
    source "${HOME}/.cskconfig"
fi

BIN="${ROOT}/.config/csk"
PROJ="./src/${NAME}"

mkdir -p "${NAME}"/{src,test,man,doc}
pushd "${NAME}"
touch readme readme.md news copying authors changelog
php ${BIN}/makefile.php "${NAME}" "$(date)" "version 0.0.1" > makefile
php ${BIN}/gitignore.php "${NAME}" "$(date)" "version 0.0.1" > .gitignore
php ${BIN}/CMakeLists.txt.php "${NAME}" > CMakeLists.txt

pushd ./src
touch "${NAME}.hpp" "${NAME}.cpp" "${NAME}_test.hpp" "${NAME}_test.cpp"
php ${BIN}/main.cpp.php "${NAME}" "$(date)" "${SIMPLE}" > main.cpp
php ${BIN}/app.hpp.php "${NAME}" "$(date)" > "${NAME}.hpp"
php ${BIN}/app.cpp.php "${NAME}" "$(date)" > "${NAME}.cpp"
php ${BIN}/app_test.hpp.php "${NAME}_test" "$(date)" > "${NAME}_test.hpp"
php ${BIN}/app_test.cpp.php "${NAME}_test" "$(date)" > "${NAME}_test.cpp"
php ${BIN}/bash_color.hpp.php "${NAME}" "$(date)" > bash_color.hpp
php ${BIN}/config.hpp.php "${NAME}" "$(date)" > config.hpp
popd
popd
