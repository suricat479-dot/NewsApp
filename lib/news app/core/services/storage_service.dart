import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  static const String _keyIsFirstTime = 'is_first_time';
  static const String _keyIsAuthorized = 'is_authorized';

    bool isFirstTime() {
    return _prefs.getBool(_keyIsFirstTime) ?? true;
  }

    Future<void> setOnboardingCompleted() async {
    await _prefs.setBool(_keyIsFirstTime, false);
  }

    bool isAuthorized() {
    return _prefs.getBool(_keyIsAuthorized) ?? false;
  }

    Future<void> setAuthorized(bool value) async {
    await _prefs.setBool(_keyIsAuthorized, value);
  }
}

@module
abstract class StorageModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}