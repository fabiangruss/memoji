import 'package:flutter_test/flutter_test.dart';
import 'package:memoji/memoji.dart';
import 'package:memoji/memoji_platform_interface.dart';
import 'package:memoji/memoji_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMemojiPlatform
    with MockPlatformInterfaceMixin
    implements MemojiPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MemojiPlatform initialPlatform = MemojiPlatform.instance;

  test('$MethodChannelMemoji is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMemoji>());
  });

  test('getPlatformVersion', () async {
    Memoji memojiPlugin = Memoji();
    MockMemojiPlatform fakePlatform = MockMemojiPlatform();
    MemojiPlatform.instance = fakePlatform;

    expect(await memojiPlugin.getPlatformVersion(), '42');
  });
}
