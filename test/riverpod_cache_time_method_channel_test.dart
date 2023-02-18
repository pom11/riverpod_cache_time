import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_cache_time/riverpod_cache_time_method_channel.dart';

void main() {
  MethodChannelRiverpodCacheTime platform = MethodChannelRiverpodCacheTime();
  const MethodChannel channel = MethodChannel('riverpod_cache_time');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
