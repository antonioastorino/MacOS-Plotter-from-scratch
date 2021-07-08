#!/bin/bash
set -e
BD="`pwd`"
echo "Building"
${BD}/bin/build.sh
echo "Registering"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -f "$BD/plotter.app"
echo "Running"
open $BD/plotter.app
tail -f /Volumes/DataMBP/plotter.log