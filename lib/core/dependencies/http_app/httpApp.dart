import 'package:cloudwalk_weather/core/Errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HttpApp {
  final Dio _dio;

  HttpApp() : _dio = Dio();

  Future<Either<Failure, dynamic>> get(String url, {Map<String, dynamic>? queryParameters, Options? options}) async {
    try{
      Response response = await _dio.get(url, queryParameters: queryParameters, options: options);
      return Right(response.data);
    } catch (e) {
      return Left(Failure(title: "Erro ao realizar dio get", message: e.toString()));
    }
  }

  Future<Either<Failure, dynamic>> post(String url, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try{
      Response response = await _dio.post(url, data: data, queryParameters: queryParameters);
      return Right(response.data);
    } catch (e) {
      return Left(Failure(title: "Erro ao realizar dio post", message: e.toString()));
    } 
  }

  Future<Either<Failure, dynamic>> put(String url, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try{
      Response response = await _dio.put(url, data: data, queryParameters: queryParameters);
      return Right(response.data);
    } catch (e) {
      return Left(Failure(title: "Erro ao realizar dio put", message: e.toString()));
    }
  }

  Future<Either<Failure, dynamic>> delete(String url, {Map<String, dynamic>? queryParameters}) async {
    try{
      Response response = await _dio.delete(url, queryParameters: queryParameters);
      return Right(response.data);
    } catch (e) {
      return Left(Failure(title: "Erro ao realizar dio delete", message: e.toString()));
    }
  }
}
