import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'riverpod_cache_time_platform_interface.dart';

/// An implementation of [RiverpodCacheTimePlatform] that uses method channels.
class MethodChannelRiverpodCacheTime extends RiverpodCacheTimePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('riverpod_cache_time');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
