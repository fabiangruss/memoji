
# Memoji Flutter Plugin

A Flutter plugin for iOS to fetch Memoji from the user's iPhone.
The plugin opens the iOS (emoji) keyboard and allows the user to select a Memoji. The selected Memoji is then returned as an image or saved to a temporary folder and returned as a path.

This plugin uses the [MemojiView](https://github.com/emrearmagan/MemojiView) library for handling Memoji on the iOS side.

## ⚠️ Important Note
This plugin only works on iOS devices because it uses iOS specific functionality for Memoji. Android is not supported.

## Installation

### 1. Add it to your pubspec.yaml:

```yaml
dependencies:
  memoji: ^0.0.1
```

### 2. Install the package:

```bash
flutter pub get
```

### 3. Import it in your Dart code:

```dart
import 'package:memoji/memoji.dart';
```

## Usage

This package provides two main functions:

### 1. Fetching the Memoji as an image:

```dart
Uint8List memojiImage = await Memoji.getMemoji();
```

### 2. Fetching the Memoji, saving it locally and returning the file path:

```dart
String filePath = await Memoji.getMemojiAndSave();
```

## Example

Check the `example` directory for a sample app using memoji plugin.

## Info.plist

Add the following key to your Info.plist file, located in `<project root>/ios/Runner/Info.plist`:

```xml
<key>NSPhotoLibraryAddUsageDescription</key>
<string>Save memojis to photo library</string>
```

This key is required if you want to use the `getMemojiAndSave` function that saves the Memoji to the photo library.

## License

MIT
