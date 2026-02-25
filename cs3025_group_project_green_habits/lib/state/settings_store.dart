import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../databases/preferences.dart';

/// App-wide settings that should immediately affect the whole UI.
///
/// - themeMode: light/dark
/// - locale: language
/// - textScale: global text scaling
/// - sound/vibration: prototype toggles stored in SharedPreferences
class SettingsStore extends ChangeNotifier {
  SettingsStore({
    required Locale initialLocale,
    required ThemeMode initialThemeMode,
    required double initialTextScale,
    required bool initialSound,
    required bool initialVibration,
  })  : _locale = initialLocale,
        _themeMode = initialThemeMode,
        _textScale = initialTextScale,
        _soundEnabled = initialSound,
        _vibrationEnabled = initialVibration;

  Locale _locale;
  ThemeMode _themeMode;
  double _textScale; // 1.0 = default
  bool _soundEnabled;
  bool _vibrationEnabled;

  Locale get locale => _locale;
  ThemeMode get themeMode => _themeMode;
  double get textScale => _textScale;
  bool get soundEnabled => _soundEnabled;
  bool get vibrationEnabled => _vibrationEnabled;

  String get languageLabel => _locale.languageCode == 'fr' ? 'French' : 'English';
  String get themeLabel {
    if (_themeMode == ThemeMode.dark) return 'Dark';
    return 'Light';
  }

  String get textSizeLabel {
    // Keep it simple / UI-friendly.
    if (_textScale < 0.95) return 'Small';
    if (_textScale > 1.15) return 'Large';
    return 'Medium';
  }

  Future<void> setLanguageCode(String code) async {
    final next = Locale(code);
    if (next == _locale) return;
    _locale = next;
    await PreferencesService.setLanguage(code);
    notifyListeners();
  }

  Future<void> setDarkMode(bool enabled) async {
    final next = enabled ? ThemeMode.dark : ThemeMode.light;
    if (next == _themeMode) return;
    _themeMode = next;
    await PreferencesService.setDarkMode(enabled);
    notifyListeners();
  }

  Future<void> toggleThemeMode() async {
    await setDarkMode(_themeMode != ThemeMode.dark);
  }

  Future<void> setTextScale(double scale) async {
    final clamped = scale.clamp(0.85, 1.35);
    if (clamped == _textScale) return;
    _textScale = clamped;
    await PreferencesService.setTextScale(_textScale);
    notifyListeners();
  }

  Future<void> setSoundEnabled(bool enabled) async {
    if (enabled == _soundEnabled) return;
    _soundEnabled = enabled;
    await PreferencesService.setSoundEnabled(enabled);
    notifyListeners();
  }

  Future<void> toggleSound() async => setSoundEnabled(!_soundEnabled);

  Future<void> setVibrationEnabled(bool enabled) async {
    if (enabled == _vibrationEnabled) return;
    _vibrationEnabled = enabled;
    await PreferencesService.setVibrationEnabled(enabled);
    notifyListeners();
  }

  Future<void> toggleVibration() async => setVibrationEnabled(!_vibrationEnabled);
}
