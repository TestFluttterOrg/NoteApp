abstract class SharedPrefDataSource {
  Future<String?> getData(String key);

  Future<void> setData(String key, String data);

  Future<void> clearData(String key);
}