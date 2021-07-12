#!/bin/bash
set -e
BD="$(pwd)/$(dirname $0)/.."

pushd $BD
APP_DIR="plotter.app/Contents/MacOS/"
DIST_ASSETS_DIR="plotter.app/Contents/Resources"
OSX_LD_FLAGS="-framework Cocoa"
FLAGS="-fobjc-arc -g -O0"
INC="-Iinclude"
BUILD_DIR="build"
EXECUTABLE="${BUILD_DIR}/plotter"

/bin/rm -f "${EXECUTABLE}"
/bin/rm -rf \
	"plotter.app" \
	"${BUILD_DIR}"

mkdir -p \
	"${APP_DIR}" \
	"${BUILD_DIR}" \
	"${DIST_ASSETS_DIR}"

OBJC_SCR_FILES=$(ls src/*.mm)
C_SRC_FILES=$(ls src/c-compute/*.c)
OBJ_FILES=""

set -x
for obj_file in ${OBJC_SCR_FILES[@]}; do
	obj_file_basename=$(basename $obj_file)
	obj_file_no_ext=${obj_file_basename%.*}
	echo $obj_file_no_ext
	clang ${FLAGS} \
		${INC} \
		-c "${BD}/src/$obj_file_no_ext.mm" \
		-o "${BUILD_DIR}/$obj_file_no_ext.o"
	OBJ_FILES="${BUILD_DIR}/$obj_file_no_ext.o ${OBJ_FILES}"
done

for obj_file in ${C_SRC_FILES[@]}; do
	obj_file_basename=$(basename $obj_file)
	obj_file_no_ext=${obj_file_basename%.*}
	clang ${FLAGS} \
		${INC} \
		-c "${BD}/src/c-compute/$obj_file_no_ext.c" \
		-o "${BUILD_DIR}/$obj_file_no_ext.o"
	OBJ_FILES="${BUILD_DIR}/$obj_file_no_ext.o ${OBJ_FILES}"
done

clang -lc++ \
	${FLAGS} \
	${OSX_LD_FLAGS} \
	${INC} \
	-o ${EXECUTABLE} \
	${OBJ_FILES}
set +x
cp "${EXECUTABLE}" "${APP_DIR}"
cp assets/* "${DIST_ASSETS_DIR}"

popd
