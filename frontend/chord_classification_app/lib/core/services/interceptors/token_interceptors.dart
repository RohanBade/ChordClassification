import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../abstractservices/token_manager.dart';
import '../../../modules/injection_container.dart';

class TokenInterceptors extends Interceptor {
  TokenInterceptors(this.tokenManager);

  final TokenManager tokenManager;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = tokenManager.token;

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return super.onRequest(options, handler);
  }
}

final tokenResolverProvider = Provider<TokenInterceptors>(
    (ref) => TokenInterceptors(ref.read(tokenManagerProvider)));
