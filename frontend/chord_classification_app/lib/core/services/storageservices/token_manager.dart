import '../../../abstractservices/storage_services.dart';
import '../../utils/storage_key_constants.dart';

class TokenManager {
  TokenManager(this._storageServices);
  final StorageServices _storageServices;

  String? token;

  Future<TokenManager> init() async {
    token = await _storageServices.get(StorageKeys.token);
    return this;
  }

  updateToken(String? token) {
    this.token = token;
    if (token != null) {
      _storageServices.set(StorageKeys.token, token);
      return;
    }
    _storageServices.remove(StorageKeys.token);
  }
}
