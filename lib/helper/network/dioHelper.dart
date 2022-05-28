import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          // baseUrl: 'http://192.168.130.133:5000/',
           baseUrl: 'http://10.0.2.2:5000/',
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
      'x-auth-token': token ?? '',
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
      'x-auth-token': token ?? '',
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
      'x-auth-token': token ?? '',
      'Content-Type': 'application/json',
    };

    return dio!.put(
      url,
      data: data,
    );
  }

  static Future<Response> putImage({
    required String url,
    required FormData data,
    String? token,
  }) async {
    dio!.options.headers = {
      'x-auth-token': token ?? '',
      'Content-Type': 'application/json',
    };

    return dio!.put(
      url,
      data: data,
    );
  }
}





