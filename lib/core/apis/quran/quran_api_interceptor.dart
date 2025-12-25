import 'package:dio/dio.dart';

class QuranApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // نقوم بتمرير الاشياء الثابتة مع كل طلب
    // options.headers['Accept'] = '*/*';
    super.onRequest(options, handler);
  }

  // @override
  // void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
  //   // TODO: implement onResponse
  //   super.onResponse(response, handler);
  // }

  // @override
  // void onError(DioException err, ErrorInterceptorHandler handler) {
  //   // TODO: implement onError
  //   super.onError(err, handler);
  // }
}
