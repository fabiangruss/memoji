import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'memoji_platform_interface.dart';

/// An implementation of [MemojiPlatform] that uses method channels.
class MethodChannelMemoji extends MemojiPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('memoji');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
