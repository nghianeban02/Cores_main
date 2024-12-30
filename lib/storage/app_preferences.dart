import 'package:shared_preferences/shared_preferences.dart';

class AppPreferencesImpl {
  static final AppPreferencesImpl _singleton = AppPreferencesImpl._internal();
  static late final SharedPreferences _prefs;

  AppPreferencesImpl._internal();

  factory AppPreferencesImpl() {
    return _singleton;
  }

  ///key

  static const TOKEN = 'TOKEN';
  static const BIOMETRIC = 'BIOMETRIC';
  static const ACCOUNT = 'ACCOUNT';
  static const PASSWORD = "PASSWORD";
  static const DOITAC = "DOITAC";
  static const REMEMBER = "REMEMBER";
  @override
  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _setOrRemove<T>(String key, T? value) async {
    if (value == null) {
      await _prefs.remove(key);
      return;
    }

    switch (T) {
      case bool:
        await _prefs.setBool(key, value as bool);
        break;
      case String:
        await _prefs.setString(key, value as String);
        break;
    }
  }

  T? _get<T>(String key) {
    if (!_prefs.containsKey(key)) {
      return null;
    }
    if (T is List<String>) {
      return List<String>.from((_prefs.getStringList(key) ?? [])) as T;
    }

    switch (T) {
      case bool:
        return _prefs.getBool(key) as T;
      case String:
        return _prefs.getString(key) as T;
      default:
        return null;
    }
  }

  @override
  String? get getToken => _get<String>(TOKEN);

  @override
  Future<void> setToken(String? token) async {
    await _setOrRemove(TOKEN, token);
  }

  @override
  bool? get getBiometric => _get<bool>(BIOMETRIC);

  @override
  Future<void> setBiometric(bool? biometric) async {
    await _setOrRemove(BIOMETRIC, biometric);
  }

  @override
  String? get getAccount => _get<String>(ACCOUNT);

  @override
  Future<void> setAccount(String? account) async {
    await _setOrRemove(ACCOUNT, account);
  }

  @override
  String? get getPassword => _get<String>(PASSWORD);

  @override
  Future<void> setPassword(String? password) async {
    await _setOrRemove(PASSWORD, password);
  }

  @override
  String? get getDoiTac => _get<String>(DOITAC);

  @override
  Future<void> setDoiTac(String? DoiTac) async {
    await _setOrRemove(DOITAC, DoiTac);
  }

  @override
  bool? get getRemember => _get<bool>(REMEMBER) ?? false;

  @override
  Future<void> setRemember(bool? remember) async {
    await _setOrRemove(REMEMBER, remember);
  }
}
