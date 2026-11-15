#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
: "${ANDROID_HOME:?Set ANDROID_HOME to your Android SDK}"
: "${KEYSTORE_FILE:?Set KEYSTORE_FILE to your own private signing keystore}"
: "${KEYSTORE_PASSWORD:?Set KEYSTORE_PASSWORD}"
BT="$ANDROID_HOME/build-tools/${BUILD_TOOLS_VERSION:-34.0.0}"
JAR="$ANDROID_HOME/platforms/android-${ANDROID_API:-34}/android.jar"
# Only generated compilation output is recreated. Existing APKs are not replaced.
rm -rf out
mkdir -p out/classes out/dex dist
"$BT/aapt2" compile --dir resources -o out/res.zip
"$BT/aapt2" link out/res.zip -I "$JAR" --manifest AndroidManifest.xml --java out/gen -o out/base.apk
javac -source 8 -target 8 -nowarn -cp "$JAR" -d out/classes $(find src out/gen -name '*.java')
"$BT/d8" --min-api 24 --lib "$JAR" --output out/dex $(find out/classes -name '*.class')
cp out/dex/classes.dex out/
(cd out && zip -q base.apk classes.dex)
"$BT/zipalign" -f -p 4 out/base.apk out/aligned.apk
"$BT/apksigner" sign --ks "$KEYSTORE_FILE" --ks-pass env:KEYSTORE_PASSWORD --out dist/tv-youtube-shortcut.apk out/aligned.apk
"$BT/apksigner" verify dist/tv-youtube-shortcut.apk
printf 'Built dist/tv-youtube-shortcut.apk; nothing was installed or contacted on a TV.\n'
