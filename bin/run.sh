#!/bin/bash
set -e
BD="$(pwd)"
echo "Building"
${BD}/bin/build.sh
echo "Registering"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -f "$BD/plotter.app"

echo "Closing running instance"
PID=$(ps aux | grep plotter.app/Contents/MacOS/plotter | grep -v grep | awk '{print $2}')
if ! [ -x ${PID} ]; then
	kill ${PID}
fi

echo "Running"
open $BD/plotter.app

