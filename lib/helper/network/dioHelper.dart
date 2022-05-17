import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          // baseUrl: 'http://192.168.130.133:5000/',
           baseUrl: 'http://192.168.1.18:5000/',
          receiveDataWhenStatusError: true,
          connectTimeout: 30000),
    );
  }

  static Future<Response> getData({
    required String? url,
    String? token,
  }) async {
    dio?.options.headers = {
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials": true,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };

    return await dio!.get(
      url!,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio!.options.headers = {
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials": true,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };

    return dio!.post(
      url,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };

    return dio!.put(
      url,
      data: data,
    );
  }
}
