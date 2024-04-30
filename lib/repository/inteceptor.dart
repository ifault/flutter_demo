import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class MyAuthInterceptor extends Interceptor{
  final box = GetStorage();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["Authorization"] = "Bearer ${box.read("token")}";
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
    print('Request:');
    print('URL: ${options.uri}');
    print('Method: ${options.method}');
    print('Data: ${options.data}');
    print('Headers: ${options.headers}');
    print('');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    // 在接收到响应后打印响应信息
    print('Response:');
    print('URL: ${response.requestOptions.uri}');
    print('Status: ${response.statusCode}');
    if (response.data != null) {
      print('Data: ${response.data}');
    }
    print('');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // 在请求发生错误时打印错误信息
    print('Error:');
    print('URL: ${err.requestOptions.uri}');
    print('Error: ${err.error}');
    print('');
    super.onError(err, handler);
  }
}