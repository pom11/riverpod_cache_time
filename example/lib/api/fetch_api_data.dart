import 'package:dio/dio.dart';

Future<String> fetchApiData({CancelToken? cancelToken}) async {
  const String url = 'https://fakerestapi.azurewebsites.net/api/v1/Activities/1';
  Response response = await Dio().get(
    url,
    cancelToken: cancelToken,
  );
  return response.data['dueDate'];
}
