abstract class ResponseCache {
  Future<void> storeResponse(String key, dynamic data);
  Future<String> getResponse(String key);
}
