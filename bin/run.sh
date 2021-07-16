#!/bin/zsh
set -e
BD="$(pwd)/$(dirname $0)/.."
source "${BD}/bin/variables.sh"
if [ -z $APP_NAME ]; then exit 1; fi

# Accept case-insensitive "test" by converting to uppercase
MODE="$1"
MODE=${MODE:u}

pushd "${BD}"

echo "Closing running instance"
PID=$(ps aux | grep ${APP_NAME}.app/Contents/MacOS/${APP_NAME} | grep -v grep | awk '{print $2}')
if ! [ "${PID}" = "" ]; then
	kill ${PID}
else
	echo "No process was runnig."
fi

if ! [ -f "${MAKE_FILE}" ]; then
	echo "No makefile found."
	echo "Calling bin/makeMakefile.sh"
	./bin/makeMakefile.sh
fi

for EXTENSION in ${SRC_EXTENSIONS[@]} ${INC_EXTENSIONS[@]}; do
	for FILE in $(find . -name "*.${EXTENSION}"); do
		clang-format -i $FILE
	done
done

echo "Running"
if [ "${MODE}" = "TEST" ]; then
	make MODE=TEST
	./build/"${APP_NAME}-test" >"${LOG_FILE_OUT}" 2>"${LOG_FILE_ERR}"
	RET_VAL=$?
	if [ ${RET_VAL} -ne 0 ]; then
		echo -e "\n\n\e[31mFAIL\e[0m - Execution interrupted with error code ${RET_VAL}.\n\n"
		exit ${RET_VAL}
	fi

	if [ -f "${LOG_FILE_ERR}" ]; then
		if [ "$(cat ${LOG_FILE_ERR})" = "" ]; then
			echo -e "\n\n\e[32mSUCCESS:\e[0m - All tests passed.\n\n"
		else
			echo -e "\n\n\e[31mFAIL\e[0m - The content of ${LOG_FILE_ERR} follows.\n\n"
			cat "${LOG_FILE_ERR}"
		fi
	else
		echo -e "\n\n\e[31mApplication not run.\e[0m\n\n"
	fi
	analyze_mem "${LOG_FILE_OUT}"
else
	make
	open "${APP_NAME}.app"
fi
popd
