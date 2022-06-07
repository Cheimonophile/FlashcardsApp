#!/bin/sh -xe
cd $(dirname $0)
./prebuild.sh
flutter build macos
cp "build/macos/Build/Products/Release/FlashcardsApp.app" "/Applications/"