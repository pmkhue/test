# Sliding Puzzle

This is a minimal sliding puzzle game written in Flutter. It works on Android and iOS.

## Building

Make sure you have Flutter installed. Then run the following commands:

```bash
flutter pub get
flutter run            # to run on a connected device or simulator
flutter build apk      # build for Android
flutter build ios      # build for iOS
```

The repository provides only the core game logic in `lib/main.dart`. If you cloned a fresh repository without platform folders, run `flutter create .` first to generate the Android and iOS directories.
