import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool nightThemeEnabled;
  ThemePreferences _preferences = ThemePreferences();
  bool showDarkButton;
  void switchTheme() {
    nightThemeEnabled = !nightThemeEnabled;
    _preferences.setTheme(nightThemeEnabled);
    notifyListeners();
    showDarkButton = nightThemeEnabled;
  }

  void listTileClicked() {
    showDarkButton = !showDarkButton;
    notifyListeners();
  }

  ThemeProvider() {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    nightThemeEnabled = brightness == Brightness.dark;
    showDarkButton = nightThemeEnabled;
    getPreferences();
  }

  getPreferences() async {
    nightThemeEnabled = await _preferences.getTheme() ?? nightThemeEnabled;
    showDarkButton = nightThemeEnabled;
    notifyListeners();
  }

  ThemeData getTheme() {
    if (nightThemeEnabled)
      return FlexColorScheme.dark(scheme: FlexScheme.barossa).toTheme;
    else
      return FlexColorScheme.light(scheme: FlexScheme.barossa).toTheme;
  }
}

class ThemePreferences {
  static const PREF_KEY = "theme";

  setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(PREF_KEY, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(PREF_KEY);
  }
}
