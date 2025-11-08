/// [SharePreferenceStorageAbstract] interface
abstract class SharePreferenceStorageAbstract {
  Future<void> init ();
  
  void dispose();

  bool get hasInitialized;

  bool has (String key);

  /// clear all data in storage
  Future<void> clear ();

  Object? get (String key);

  Future<void> set (String key, String value);

  Future<bool> remove (String key);
}