import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_cache_time/riverpod_cache_time.dart';

part 'get_api_data.provider.g.dart';

Future<String> fetchApiData({CancelToken? cancelToken}) async {
  const String url = 'https://fakerestapi.azurewebsites.net/api/v1/Activities/1';
  Response response = await Dio().get(
    url,
    cancelToken: cancelToken,
  );
  return response.data['dueDate'];
}

@riverpod
Future<String> getApiData(GetApiDataRef ref) async {
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
}
