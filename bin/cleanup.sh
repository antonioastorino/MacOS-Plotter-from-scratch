#!/bin/bash
set -e
BD="$(pwd)/$(dirname $0)/.."
source "${BD}/bin/variables.sh"
if [ -z $APP_NAME ]; then exit 1; fi

echo "Closing running instance"
PID=$(ps aux | grep ${APP_NAME}.app/Contents/MacOS/${APP_NAME} | grep -v grep | awk '{print $2}')
if ! [ -x ${PID} ]; then
	kill ${PID}
fi

/bin/rm -rf \
	"${EXECUTABLE}" \
	"${APP_NAME}.app" \
	"${APP_NAME}.dSYM" \
	"${BUILD_DIR}" \
	"${MAKE_FILE}" \
	*.list
