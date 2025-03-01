import 'package:dio/dio.dart';

abstract class ApiManager<T> {
  ApiManager._();
  Future<Response> get(String path,
      {Map<String, dynamic>? headers, Map<String, dynamic>? queryParameters});

  Future<Response> post(String path,
      {Map<String, dynamic>? headers, dynamic data});

  Future<Response> patch(String path, {data, Map<String, dynamic>? headers});

  Future<Response> delete(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers});

  Future<Response> fileUpload(String path, {FormData? data});
}
