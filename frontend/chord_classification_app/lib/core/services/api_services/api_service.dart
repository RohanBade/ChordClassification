import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../abstractservices/api_manager.dart';
import '../../../modules/injection_container.dart';
import '../../extensions/extensions.dart';
import '../interceptors/cache_interceptors.dart';
import '../interceptors/token_interceptors.dart';

class ApiManagerImpl implements ApiManager {
  final _connectTimeout = 10.seconds;
  final _receiveTimeout = 10.seconds;
  final _sendTimeout = 10.seconds;

  late Dio dio;

  ApiManagerImpl(Ref ref) {
    BaseOptions options = BaseOptions(
        baseUrl: ref.read(baseUrlProvider),
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        sendTimeout: _sendTimeout,
        responseType: ResponseType.json,
        contentType: Headers.jsonContentType);

    dio = Dio(options);

    dio.interceptors.add(ref.read(tokenResolverProvider));
    dio.interceptors.add(ref.read(cacheResolverProvider));
  }

  @override
  Future<Response> get(path, {headers, queryParameters}) async {
    return await dio.get(path,
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  @override
  Future<Response> post(path, {headers, data}) async {
    return await dio.post(path, data: data, options: Options(headers: headers));
  }

  @override
  Future<Response> patch(path, {data, headers}) {
    return dio.patch(path, data: data, options: Options(headers: headers));
  }

  @override
  Future<Response> delete(path, {data, queryParameters, headers}) {
    return dio.delete(path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers));
  }

  @override
  Future<Response> fileUpload(path, {data}) async {
    return await post(path,
        headers: {'enctype': 'multipart/form-data'}, data: data);
  }
}
