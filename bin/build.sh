#!/bin/bash
set -e
BD="$(pwd)/$(dirname $0)/.."

pushd $BD
APP_DIR="plotter.app/Contents/MacOS/"
OSX_LD_FLAGS="-framework Cocoa"
FLAGS="-fobjc-arc -g -O3"
INC="-Iinclude"
BUILD_DIR="build"
EXECUTABLE="${BUILD_DIR}/plotter"

/bin/rm -f "${EXECUTABLE}"
/bin/rm -rf \
	"${BD}/plotter.app" \
	"${BUILD_DIR}"

mkdir -p \
	"${APP_DIR}" \
	"${BUILD_DIR}"

OBJC_SCR_FILES=$(basename $(ls src))
OBJC_OBJ_FILES=""

echo $OBJC_SCR_FILES
set -x
for obj_file in ${OBJC_SCR_FILES[@]}; do
	obj_file_no_ext=${obj_file%.*}
	clang ${FLAGS} \
		${INC} \
		-c "${BD}/src/$obj_file_no_ext.mm" \
		-o "${BUILD_DIR}/$obj_file_no_ext.o"
	OBJC_OBJ_FILES="${OBJC_OBJ_FILES} ${BUILD_DIR}/$obj_file_no_ext.o"
done

clang -lc++ \
	${FLAGS} \
	${OSX_LD_FLAGS} \
	${INC} \
	-o ${EXECUTABLE} \
	${OBJC_OBJ_FILES}

set +x
cp "${EXECUTABLE}" "${APP_DIR}"

popd
