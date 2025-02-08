import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../abstractservices/response_cache_service.dart';
import '../../../modules/injection_container.dart';

class CacheResolver extends Interceptor {
  CacheResolver(this._cache);

  final ResponseCache _cache;
  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    try {
      String url = err.requestOptions.uri.toString();
      final cachedData = await _cache.getResponse(url);
      if (cachedData.isNotEmpty) {
        handler.resolve(Response(
            requestOptions: err.requestOptions,
            statusCode: 200,
            data: jsonDecode(cachedData)));
      } else {
        handler.next(err);
      }
    } catch (e) {
      handler.next(err);
    }
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    String url = response.requestOptions.uri.toString();
    if (response.requestOptions.method == 'GET' && response.statusCode == 200) {
      await _cache.storeResponse(url, response.data);
    }
    handler.next(response);
  }
}

final cacheResolverProvider =
    Provider((ref) => CacheResolver(ref.read(responseCacheProvider)));
