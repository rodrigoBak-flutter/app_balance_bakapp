import 'package:shared_preferences/shared_preferences.dart';

class UserPrefence {
//  static const darkMode = 'DarkMode';
  static final UserPrefence _instance = UserPrefence._();

  factory UserPrefence() {
    return _instance;
  }
  UserPrefence._();
  SharedPreferences? _preferences;

  initPreference() async {
    _preferences = await SharedPreferences.getInstance();
  }

  bool get darkMode {
    return _preferences!.getBool('DarkMode') ?? true;
  }

  set darkMode(bool value) {
    _preferences!.setBool('DarkMode', value);
  }
}
