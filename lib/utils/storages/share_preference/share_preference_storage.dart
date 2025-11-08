import 'package:focus_app/utils/storages/share_preference/share_preference_storage_abstract.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceStorage implements SharePreferenceStorageAbstract {
  // constructor
  static final SharePreferenceStorage _instance = SharePreferenceStorage._internal();

  SharePreferenceStorage._internal();

  factory SharePreferenceStorage() => _instance;

  static SharePreferenceStorage get instance => _instance;

  // variables
  SharedPreferences? _storage;


  /// [init] method is initialized [SharedPreferences] storage 
  @override
  Future<void> init() async {
    _storage = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    _storage = null;
  }

  @override
  bool get hasInitialized => _storage != null;

  @override
  Future<void> clear() async {
    if(hasInitialized) {
      _storage!.clear();
    }
  }

  @override
  Object? get(String key) {
    return _storage?.get(key);
  }

  @override
  bool has(String key) {
    return _storage?.containsKey(key) ?? false;
  }

  @override
  Future<bool> remove(String key) async {
    return await _storage?.remove(key) ?? false;
  }

  @override
  Future<void> set(String key, String value) async {    
    await _storage?.setString(key, value);
  }
}