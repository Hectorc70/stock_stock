#!/bin/bash 
PATH_PROJECT=$(pwd)
APP_NAME="Stock Stock"

# Commandos flutter build apk
flutter clean
flutter pub get
flutter build apk --release
#flutter build appbundle --target-platform android-arm,android-arm64,android-x64

# mueve archivo al folder principal
cp "$PATH_PROJECT/build/app/outputs/flutter-apk/app-release.apk" "$PATH_PROJECT/$APP_NAME.apk"
#cp "$PATH_PROJECT/build/app/outputs/bundle/release/app-release.aab" "$PATH_PROJECT/$APP_NAME.aab"