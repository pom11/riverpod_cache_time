import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_cache_time/riverpod_cache_time.dart';
import 'package:riverpod_cache_time_example/api/fetch_api_data.dart';

final getApiDataProvider = FutureProvider.autoDispose((ref) async {
  CancelToken cancelToken = CancelToken();
  final String data = await fetchApiData(cancelToken: cancelToken);
  final link = ref.keepAlive();
  RiverpodCacheTime(
    cacheMaxSecond: 3, // 갱신된 데이터를 가지고 온 시간으로부터 3초가 지나면 본 provider 의 link.close() 가 호출됨!
    ref: ref,
    link: link,
    cancelToken: cancelToken,
  );
  return data;
});
