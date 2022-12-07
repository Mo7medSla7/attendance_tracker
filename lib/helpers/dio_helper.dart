import 'package:attendance_tracker/shared/end_points.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(baseUrl: API_LINK),
    );
  }

  static Future<Response> getData({
    required String url,
    String? token,
  }) async {
    dio.options.headers['authorization'] = token ?? '';
    return await dio.get(
      url,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio.options.headers['authorization'] = token ?? '';
    return await dio.post(
      url,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    return await dio.put(
      url,
      data: data,
    );
  }
}
