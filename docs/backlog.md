# Backlog

Follow-up items identified while getting the Android build working again and
verifying the app on-device (2026-07-30/31).

## Build / dependencies

- **Replace `tflite_v2`.** It's unmaintained (last published ~2020) and its
  Android build script used the defunct `jcenter()` repo plus an ancient AGP
  3.6.3 classpath, which broke under the Gradle version Flutter now requires.
  It's currently vendored under `third_party/tflite_v2` with a modernized
  `build.gradle` (see `dependency_overrides` in `pubspec.yaml`) as a stopgap.
  Migrate to a maintained TFLite plugin (e.g. `tflite_flutter`) — this is a
  real code migration of the object-recognition inference calls, not a
  drop-in swap.
- **`camera` / `flutter_tts` still apply their own Kotlin Gradle Plugin
  directly**, unlike `file_picker` (>=11.x) which switched to relying on
  AGP's built-in Kotlin support. Flutter's tooling warns this will become a
  hard build failure in a future release. `file_picker` is pinned to
  `10.3.10` specifically because the newer 11.x releases assume built-in
  Kotlin, which conflicts with `camera_android_camerax`'s still-unconverted
  build script. Once `camera`/`camerax` ship an AGP-9-aware release,
  re-evaluate bumping `file_picker` back to latest and enabling
  `android.builtInKotlin=true`.

## Release / signing

- **APK is debug-signed.** Fine for beta distribution via GitHub Releases,
  but a real release keystore needs to be generated and wired into
  `android/app/build.gradle` before any Play Store submission.
- **APK is unsplit (~139 MB, bundles all ABIs).** Consider
  `flutter build apk --split-per-abi` for smaller per-device beta downloads,
  or building an `.aab` app bundle if/when this goes to Play Store.

## Known code issues

- **`home_page.dart` debug leftover**: the whole-page long-press handler's
  `_counter == 0` branch navigates to `/welcome1` unconditionally
  (`// TODO: Debug` in source). Harmless today since counter 0 is the page
  title, but it's leftover debug code, not intentional behavior, and worth
  removing or replacing with a no-op.
