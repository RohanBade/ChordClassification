import 'dart:convert';
import '../../../abstractservices/response_cache_service.dart';
import '../../../abstractservices/storage_services.dart';

class ResponseCacheImpl implements ResponseCache {
  ResponseCacheImpl(this.storageServices);
  final StorageServices storageServices;

  @override
  Future<void> storeResponse(String key, dynamic data) async {
    await storageServices.set(key, jsonEncode(data));
  }

  @override
  Future<String> getResponse(String key) async {
    final data = await storageServices.get(key);
    return data ?? '';
  }
}
