#!/bin/bash

BD="`pwd`"
APP_DIR="$BD/plotter.app/Contents/MacOS/"
OSX_LD_FLAGS="-framework Cocoa"
EXECUTABLE="$BD/plotter"

/bin/rm -f "${EXECUTABLE}"
/bin/rm -rf $BD/plotter.app

mkdir -p "${APP_DIR}" 

# clang -lc++ -fobjc-arc -g ${OSX_LD_FLAGS} -o ${EXECUTABLE} $BD/src/main.mm
clang "${BD}/src/main.mm" -o ${EXECUTABLE} ${OSX_LD_FLAGS}
cp "${EXECUTABLE}" "${APP_DIR}"