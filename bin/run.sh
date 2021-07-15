#!/bin/bash
set -e
BD="$(pwd)/$(dirname $0)/.."
source "${BD}/bin/variables.sh"
if [ -z $APP_NAME ]; then exit 1; fi

pushd "${BD}"

echo "Closing running instance"
PID=$(ps aux | grep ${APP_NAME}.app/Contents/MacOS/${APP_NAME} | grep -v grep | awk '{print $2}')
if ! [ -x ${PID} ]; then
	kill ${PID}
fi
if ! [ -f "${MAKE_FILE}" ]; then
	echo "No makefile found."
	echo "Calling bin/makeMakefile.sh"
	./bin/makeMakefile.sh
fi

for EXTENSION in ${SRC_EXTENSIONS[@]} ${INC_EXTENSIONS[@]}; do
	for FILE in $(find . -name "*.${EXTENSION}"); do
		if clang-format $FILE >$FILE.tmp; then
			if ! cmp --silent $FILE $FILE.tmp; then
				echo "Formatting has changed: $FILE"
				cat $FILE.tmp >$FILE
			fi
			/bin/rm -f $FILE.tmp
		fi
	done
done

echo "Running"
if [ "$1" = "test" ]; then
	make MODE=TEST
	./build/"${APP_NAME}-test"
else
	make
	open "${APP_NAME}.app"
fi
popd
