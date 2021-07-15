#!/bin/bash
APP_NAME="plotter"
APP_DIR="${APP_NAME}.app/Contents/MacOS/"
DIST_ASSETS_DIR="${APP_NAME}.app/Contents/Resources"
OBJCFLAGS="-fobjc-arc -g"
DEF_HEADER="include/c/definitions.h"
# CPPFLAGS="-Wextra -std=c++14" #unused here
CFLAGS="-Wextra"
GLOBAL_COMPILER="clang"
LIB="-lc++"
BUILD_DIR="build"
EXECUTABLE="${BUILD_DIR}/${APP_NAME}"
MAKE_FILE="Makefile"
MAIN="main"
MAIN_TEST="main-test"
SRC_EXTENSIONS=("mm" "c")
INC_EXTENSIONS=("hh" "h")
