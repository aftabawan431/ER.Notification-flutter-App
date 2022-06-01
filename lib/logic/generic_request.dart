import 'package:dio/dio.dart';

class Request {
  static Future<Response> post(String url, Map data) async {
    try {
      final response = await Dio().post(
        url,
        data: data,
      );

      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }
}
