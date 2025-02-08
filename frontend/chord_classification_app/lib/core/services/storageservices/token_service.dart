import '../../../abstractservices/storage_services.dart';
import '../../../abstractservices/token_manager.dart';
import '../../utils/storage_key_constants.dart';

class TokenServices implements TokenManager {
  late StorageServices storageServices;
  String? accessToken;

  @override
  String? get token => accessToken;

  @override
  Future<TokenManager> init(box) async {
    storageServices = box;
    accessToken = await storageServices.get(StorageKeys.token);
    return this;
  }

  @override
  void updateToken(accessToken) {
    this.accessToken = accessToken;
    if (token != null) {
      storageServices.set(StorageKeys.token, accessToken);
      return;
    }
    storageServices.remove(StorageKeys.token);
  }
}
