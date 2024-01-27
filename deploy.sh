#! /bin/bash

#readonly GODOT_4_PATH="/home/peronio/.local/bin/Godot_v4.2.1.x86_64"
readonly GODOT_4_PATH="/Applications/Godot.app/Contents/MacOS/Godot"
readonly PROJECT_NAME="ggj-2024"

mkdir -p ./build/
${GODOT_4_PATH} --headless --export-release "Web" ./build/build.html
mv ./build/build.html ./build/index.html
zip -r -j build.zip ./build/*
butler push ./build.zip illusion-fisherman/${PROJECT_NAME}:html5
rm -rf ./build/
rm ./build.zip
