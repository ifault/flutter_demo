import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class MyAuthInterceptor extends Interceptor{
  final box = GetStorage();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["Authorization"] = "Bearer ${box.read("token")}";
    options.headers["X-User-ID"] = "${box.read("userId")}";
    if (options.data is Map) {
      (options.data as Map<String, dynamic>).putIfAbsent('user_id', () => '${box.read("userId")}');
      (options.data as Map<String, dynamic>).putIfAbsent('email', () => '${box.read("email")}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}


class MyLoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}