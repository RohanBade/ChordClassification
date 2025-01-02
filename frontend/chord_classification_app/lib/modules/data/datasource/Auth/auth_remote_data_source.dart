import 'package:dio/dio.dart';

import '../../../../core/services/api_services/api_service.dart';
import '../../../../core/utils/api_endpoints.dart';

abstract class AuthRemoteDataSource {
  Future<String> login(String email, String password);
  Future<void> signUp(String userName, String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._apiManager);
  final ApiManager _apiManager;

  @override
  Future<String> login(email, password) async {
    Map<String, dynamic> body = {};
    body['username'] = email;
    body['password'] = password;
    final data = FormData.fromMap(body);
    final response = await _apiManager.post(ApiEndpoints.login, data: data);
    return response.data['access_token'];
  }

  @override
  Future<void> signUp(userName, email, password) async {
    Map<String, dynamic> body = {};
    body['name'] = userName;
    body['email'] = email;
    body['password'] = password;
    await _apiManager.post(ApiEndpoints.signup, data: body);
  }
}
