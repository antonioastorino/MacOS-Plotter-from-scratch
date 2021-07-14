#!/bin/bash
set -e

function f__clang_format {
	clang-format "$1" >"$1.tmp" && mv "$1.tmp" "$1"
}

BD="$(pwd)/$(dirname $0)/.."

pushd $BD
APP_DIR="plotter.app/Contents/MacOS/"
DIST_ASSETS_DIR="plotter.app/Contents/Resources"
OSX_LD_FLAGS="-framework Cocoa"
FLAGS="-fobjc-arc -g -O0"
INC="-Iinclude"
BUILD_DIR="build"
EXECUTABLE="${BUILD_DIR}/plotter"

# Cleanup.
/bin/rm -f "${EXECUTABLE}"
/bin/rm -rf \
	"plotter.app" \
	"${BUILD_DIR}"

# Setup.
mkdir -p \
	"${APP_DIR}" \
	"${BUILD_DIR}" \
	"${DIST_ASSETS_DIR}"

# Create list of source files, excluting "main".
OBJC_SCR_FILES=$(ls src/PLT*.mm)
C_SRC_FILES=$(ls src/c-compute/*.c)
OBJ_FILES=""

if [ "$1" = "test" ]; then
	# Add 'main-test.mm' to the list to run unit tests.
	OBJC_SCR_FILES="${OBJC_SCR_FILES} src/main-test.mm"
	# Set TEST flag to 1 in header file.
	sed -i.bak 's/^#define TEST.*/#define TEST 1/' "include/c/definitions.h"
else
	# Add 'main.mm' to the list to run in normal mode.
	OBJC_SCR_FILES="${OBJC_SCR_FILES} src/main.mm"
	# Set TEST flag to 0 in header file.
	sed -i.bak 's/^#define TEST.*/#define TEST 0/' "include/c/definitions.h"
fi

set -x

# Format headers
OBJC_HEAER_FILES=$(find -L include/ | grep "\.hh$")
C_HEADER_FILES=$(find -L include/ | grep "\.h$")
HEADER_FILES=`printf "${OBJC_HEAER_FILES}\n${C_HEADER_FILES}"`
for header_file in ${HEADER_FILES[@]}; do
	f__clang_format $header_file
done

# Format and compile Objective-C++ stuff.
for obj_file in ${OBJC_SCR_FILES[@]}; do
	f__clang_format "$obj_file"
	obj_file_basename=$(basename $obj_file)
	obj_file_no_ext=${obj_file_basename%.*}
	echo $obj_file_no_ext
	clang ${FLAGS} \
		${INC} \
		-c "${BD}/src/$obj_file_no_ext.mm" \
		-o "${BUILD_DIR}/$obj_file_no_ext.o"
	OBJ_FILES="${BUILD_DIR}/$obj_file_no_ext.o ${OBJ_FILES}"
done

# Format and compile C stuff.
for obj_file in ${C_SRC_FILES[@]}; do
	f__clang_format "$obj_file"
	obj_file_basename=$(basename $obj_file)
	obj_file_no_ext=${obj_file_basename%.*}
	clang ${FLAGS} \
		${INC} \
		-c "${BD}/src/c-compute/$obj_file_no_ext.c" \
		-o "${BUILD_DIR}/$obj_file_no_ext.o"
	OBJ_FILES="${BUILD_DIR}/$obj_file_no_ext.o ${OBJ_FILES}"
done

# Create executable.
clang -lc++ \
	${FLAGS} \
	${OSX_LD_FLAGS} \
	${INC} \
	-o ${EXECUTABLE} \
	${OBJ_FILES}
set +x

if ! [ "$1" == "test" ]; then
	# Populate bundle.
	cp "${EXECUTABLE}" "${APP_DIR}"
	cp assets/* "${DIST_ASSETS_DIR}"
fi

popd
