import 'package:dio/dio.dart';

abstract class Http {
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters});
  Future<Response> post(String path, dynamic data);
  Future<Response> put(String path, dynamic data);
  Future<Response> delete(String path);
}


class HttpImpl implements Http {
  final Dio _dio;

  HttpImpl() : _dio = Dio();

  @override
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  @override
  Future<Response> post(String path, dynamic data) {
    return _dio.post(path, data: data);
  }

  @override
  Future<Response> put(String path, dynamic data) {
    return _dio.put(path, data: data);
  }

  @override
  Future<Response> delete(String path) {
    return _dio.delete(path);
  }
}
