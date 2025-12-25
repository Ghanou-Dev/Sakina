import 'package:dio/dio.dart';
import 'package:sakina/core/apis/api_consumer.dart';
import 'package:sakina/core/apis/quran/quran_api_interceptor.dart';
import 'package:sakina/core/errors/exceptions.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;
  DioConsumer({required this.dio}) {
    // dio.options.baseUrl = '/../..';
    dio.interceptors.add(QuranApiInterceptor());
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
        error: true,
      ),
    );
  }

  void _handelException({required DioException er}) {
    switch (er.type) {
      case DioExceptionType.connectionTimeout:
        throw InternetTimeoutEception(message: er.message ?? 'no message ');

      case DioExceptionType.sendTimeout:
        throw InternetTimeoutEception(message: er.message ?? 'no message ');

      case DioExceptionType.receiveTimeout:
        throw InternetTimeoutEception(message: er.message ?? 'no message ');

      case DioExceptionType.badCertificate:
        throw ServerException(message: er.message ?? 'no message');

      case DioExceptionType.badResponse:
        throw ServerException(message: er.message ?? 'no message');

      case DioExceptionType.cancel:
        throw CancelException(message: er.message ?? 'no message');

      case DioExceptionType.connectionError:
        throw NoInternetException(message: er.message ?? 'no message');

      case DioExceptionType.unknown:
        throw UnknownException(message: er.message ?? 'no message');
    }
  }

  @override
  Future<dynamic> get(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (er) {
      _handelException(er: er);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (er) {
      _handelException(er: er);
    } catch (er) {
      throw UnknownException(message: 'Unknown Exception');
    }
  }

  @override
  Future<dynamic> delete(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (er) {
      _handelException(er: er);
    } catch (er) {
      throw UnknownException(message: 'Unknown Exception');
    }
  }

  @override
  Future<dynamic> patch(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (er) {
      _handelException(er: er);
    } catch (er) {
      throw UnknownException(message: 'Unknown Exception');
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (er) {
      _handelException(er: er);
    } catch (er) {
      throw UnknownException(message: 'Unknown Exception');
    }
  }
}
