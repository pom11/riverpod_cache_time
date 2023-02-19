import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_cache_time/riverpod_cache_time.dart';
import 'package:riverpod_cache_time_example/api/fetch_api_data.dart';
part 'get_api_data.provider.g.dart';

@riverpod
Future<String> getApiData(GetApiDataRef ref) async {
  final String data = await fetchApiData();
  final link = ref.keepAlive();
  RiverpodCacheTime(
    cacheMaxSecond: 3, // 갱신된 데이터를 가지고 온 시간으로부터 3초가 지나면 본 provider 의 link.close() 가 호출됨!
    ref: ref,
    link: link,
  );
  return data;
}
