#!/bin/sh -xe
cd $(dirname $0)
flutter pub run build_runner build --delete-conflicting-outputs