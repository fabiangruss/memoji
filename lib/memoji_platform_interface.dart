import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'memoji_method_channel.dart';

abstract class MemojiPlatform extends PlatformInterface {
  /// Constructs a MemojiPlatform.
  MemojiPlatform() : super(token: _token);

  static final Object _token = Object();

  static MemojiPlatform _instance = MethodChannelMemoji();

  /// The default instance of [MemojiPlatform] to use.
  ///
  /// Defaults to [MethodChannelMemoji].
  static MemojiPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MemojiPlatform] when
  /// they register themselves.
  static set instance(MemojiPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
