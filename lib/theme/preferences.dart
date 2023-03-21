import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const PREFKEY = 'theme';

  setTheme(bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setBool(PREFKEY, value);
  }

  getTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getBool(PREFKEY) ?? false;
  }
}
