import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Memoji {
  static const MethodChannel _channel = MethodChannel('memoji');

  /// Gets a memoji as a [Uint8List]. Note that this method will throw an exception if the memoji is not available.
  /// The memoji is not saved to the device.
  static Future<Uint8List?> getMemoji() async {
    try {
      final Uint8List? bytes = await _channel.invokeMethod('getMemoji');
      return bytes;
    } catch (e) {
      debugPrint('Failed to retrieve Memoji: $e');
      return null;
    }
  }

  /// Gets a memoji first, saves it a temporary directory and returns the path to the file as a [String].
  /// Note that this method will throw an exception if the memoji is not available.
  static Future<String?> getMemojiAndSave() async {
    try {
      final Uint8List? bytes = await _channel.invokeMethod('getMemoji');
      if (bytes == null) {
        return null;
      } else {
        // Get temporary directory
        final File file = File('${(await getTemporaryDirectory()).path}/memoji_${bytes.hashCode}.png');

        // Remove old file if it exists
        if (await file.exists()) {
          await file.delete();
        }

        await file.writeAsBytes(bytes);
        return file.path;
      }
    } catch (e) {
      debugPrint('Failed to retrieve and save Memoji: $e');
      return null;
    }
  }
}
