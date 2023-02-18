import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'riverpod_cache_time_method_channel.dart';

abstract class RiverpodCacheTimePlatform extends PlatformInterface {
  /// Constructs a RiverpodCacheTimePlatform.
  RiverpodCacheTimePlatform() : super(token: _token);

  static final Object _token = Object();

  static RiverpodCacheTimePlatform _instance = MethodChannelRiverpodCacheTime();

  /// The default instance of [RiverpodCacheTimePlatform] to use.
  ///
  /// Defaults to [MethodChannelRiverpodCacheTime].
  static RiverpodCacheTimePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RiverpodCacheTimePlatform] when
  /// they register themselves.
  static set instance(RiverpodCacheTimePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
