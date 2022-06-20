#!/bin/sh -xe
cd $(dirname $0)
./build.sh
cp "./build/macos/Build/Products/Release/FlashcardsApp.app" "/Applications/"