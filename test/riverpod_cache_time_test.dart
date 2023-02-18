import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_cache_time/riverpod_cache_time_platform_interface.dart';
import 'package:riverpod_cache_time/riverpod_cache_time_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockRiverpodCacheTimePlatform with MockPlatformInterfaceMixin implements RiverpodCacheTimePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final RiverpodCacheTimePlatform initialPlatform = RiverpodCacheTimePlatform.instance;

  test('$MethodChannelRiverpodCacheTime is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRiverpodCacheTime>());
  });

  // test('getPlatformVersion', () async {
  //   RiverpodCacheTime riverpodCacheTimePlugin = RiverpodCacheTime();
  //   MockRiverpodCacheTimePlatform fakePlatform = MockRiverpodCacheTimePlatform();
  //   RiverpodCacheTimePlatform.instance = fakePlatform;

  //   expect(await riverpodCacheTimePlugin.getPlatformVersion(), '42');
  // });
}
