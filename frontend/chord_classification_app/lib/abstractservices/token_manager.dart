import 'storage_services.dart';

abstract class TokenManager {
  String? get token;

  Future<TokenManager> init(StorageServices box);

  void updateToken(String? accessToken);
}