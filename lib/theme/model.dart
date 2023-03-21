import 'package:flutter/cupertino.dart';
import 'package:wallpaper_verse/theme/preferences.dart';

class ThemeModel extends ChangeNotifier {
  bool _isDark = false;

  ThemePreferences _themePref = ThemePreferences();

  bool get isDark => _isDark;

  ThemeModel() {
    _isDark = false;
    _themePref = ThemePreferences();
  }
  set isDark(bool value) {
    _isDark = value;
    _themePref.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _themePref.getTheme();
    notifyListeners();
  }
}
