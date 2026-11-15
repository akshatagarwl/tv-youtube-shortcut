# TV YouTube / TizenTube shortcut

A tiny, MIT-licensed Android TV launcher shortcut, package `io.akshat.youtube.shortcut`.

It launches `io.gh.akshat.tizentube.cobalt` when available, otherwise the official `io.gh.reisxd.tizentube.cobalt`. It does not implement a video client, voice recognition, key handling or accessibility service. No permissions, network traffic, account data or preference lists.

The public build uses original generic TV artwork and the label **TizenTube**. Private YouTube-logo assets, compiled personal APKs and signing material are not published. YouTube names/trademarks belong to their owners; this is not an official YouTube or Google app. Publishing/building this source does not change an existing TV's tile or configuration.

## Build

JDK 17, Android SDK platform 34/build-tools 34.0.0:

```sh
export ANDROID_HOME=/path/to/android-sdk
export KEYSTORE_FILE=/private/path/to/your-signing.keystore
# Set KEYSTORE_PASSWORD securely in your environment; do not commit it.
./build.sh
python3 -m unittest discover -s tests -v
```

Output: ignored `dist/tv-youtube-shortcut.apk`. Supply your own key; no default signing identity is distributed. A differently signed APK cannot replace someone else's installed shortcut. Do not uninstall existing apps or clear their data to bypass that protection.

There are no installation commands or automatic launches against connected devices in the build/tests. Install and test only when the TV owner authorizes interruption. Undo using TV app settings; disabling the shortcut, where supported, leaves the actual player untouched.

## Related projects

- [Android/iPhone setup preview](https://github.com/akshatagarwl/tv-setup)
- [Channel lists and builder](https://github.com/akshatagarwl/tv-channel-lists)
- [Google voice-search handoff](https://github.com/akshatagarwl/tv-search-handoff)
- [TizenTube channel-filter fork](https://github.com/akshatagarwl/TizenTube/tree/feat/pr720-channel-block)

License: MIT for this source and original vector artwork, see `LICENSE`.
