import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modules/injection_container.dart';
import '../storageservices/token_manager.dart';

class TokenInterceptors extends Interceptor {
  TokenInterceptors(this._tokenManager);

  final TokenManager _tokenManager;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) =>
      handler.next(response);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = _tokenManager.token;

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return super.onRequest(options, handler);
  }
}

final tokenResolverProvider = Provider<TokenInterceptors>(
    (ref) => TokenInterceptors(ref.read(tokenManagerProvider)));
