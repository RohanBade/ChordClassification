import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/services/get.dart';
import '../../../../core/services/storageservices/token_manager.dart';
import '../../../domain/repositories/auth/auth_repo.dart';
import '../../datasource/Auth/auth_remote_data_source.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl(this._authRemoteDataSource, this._tokenManager);
  final AuthRemoteDataSource _authRemoteDataSource;
  final TokenManager _tokenManager;

  @override
  Future<bool> login(email, password) async {
    try {
      final accessToken = await _authRemoteDataSource.login(email, password);
      _tokenManager.updateToken(accessToken);
      return true;
    } on SocketException {
      Get.snackbar("No Internet Connection");
      return false;
    } on DioException catch (e) {
      final response = e.response;
      final message = response?.data['detail'];
      print("hello $e");
      if (message != null) {
        Get.snackbar(message);
      } else {
        Get.snackbar("Unexpected Error");
      }
      return false;
    }
  }

  @override
  Future<bool> signUp(userName, email, password) async {
    try {
      await _authRemoteDataSource.signUp(userName, email, password);
      return true;
    } on DioException catch (e) {
      final response = e.response;
      final message = response?.data['detail'];
      print("hello $e");
      if (message != null) {
        Get.snackbar(message);
      } else {
        Get.snackbar("Unexpected Error");
      }
      return false;
    } on SocketException {
      Get.snackbar("No Internet Connection");
      return false;
    }
  }
}
