#!/bin/bash
set -e
BD="$(pwd)"
APP_DIR="${BD}/plotter.app/Contents/MacOS/"
OSX_LD_FLAGS="-framework Cocoa"
INC="-I${BD}/include"
BUILD_DIR="${BD}/build"
EXECUTABLE="${BUILD_DIR}/plotter"

/bin/rm -f "${EXECUTABLE}"
/bin/rm -rf \
	"${BD}/plotter.app" \
	"${BUILD_DIR}"

mkdir -p \
	"${APP_DIR}" \
	"${BUILD_DIR}"

clang -fobjc-arc -g -c "${BD}/src/PLTGenericView.mm" ${INC} -o "${BUILD_DIR}/PLTGenericView.o"
clang -lc++ -fobjc-arc -g "${BUILD_DIR}/PLTGenericView.o" "${BD}/src/main.mm" ${OSX_LD_FLAGS} ${INC} -o ${EXECUTABLE}
cp "${EXECUTABLE}" "${APP_DIR}"
