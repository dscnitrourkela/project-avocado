import 'package:shared_preferences/shared_preferences.dart';

class localStorageService {
  static LocalStorageService _instance;
  static sharedPreferences _preferences;

  static Future<localStorageService> getInstance() async {
    if (_instance == null) {
      _instance = localStorageService();
    }
    if (_preferences = null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }
}

Future setupLocator() async {
  var instance = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(instance);
}
