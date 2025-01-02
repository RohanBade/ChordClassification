import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modules/injection_container.dart';
import '../../extensions/extensions.dart';
import '../interceptors/cache_interceptors.dart';
import '../interceptors/token_interceptors.dart';

typedef QueryType = Map<String, dynamic>?;

class ApiManager {
  final _connectTimeout = 10.seconds;
  final _receiveTimeout = 10.seconds;
  final _sendTimeout = 10.seconds;

  late Dio dio;

  ApiManager(Ref ref) {
    Map<String, dynamic> headers = {};
    BaseOptions options = BaseOptions(
        baseUrl: ref.read(baseUrlProvider),
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        sendTimeout: _sendTimeout,
        responseType: ResponseType.json,
        contentType: Headers.jsonContentType,
        headers: headers);

    dio = Dio(options);

    dio.interceptors.add(ref.read(tokenResolverProvider));
    dio.interceptors.add(ref.read(cacheResolverProvider));
  }

  Future<Response> get(String path,
      {Options? options, Map<String, dynamic>? queryParameters}) async {
    return await dio.get(path,
        queryParameters: queryParameters, options: options);
  }

  Future<Response> post(String path, {Options? options, data}) async {
    return await dio.post(path, data: data, options: options);
  }

  Future<Response> patch(String path, {data, Options? options}) {
    return dio.patch(path, data: data, options: options);
  }

  Future<Response> delete(String path,
      {data, Map<String, dynamic>? queryParameters, Options? options}) {
    return dio.delete(path,
        data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response> fileUpload(String path, {FormData? data}) async {
    return await post(
      path,
      options: Options(headers: {'enctype': 'multipart/form-data'}),
      data: data,
    );
  }
}
