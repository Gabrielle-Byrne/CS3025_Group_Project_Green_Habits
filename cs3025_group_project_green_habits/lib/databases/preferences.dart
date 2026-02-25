import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const _keyUsername = 'username';
  static const _keyEmail = 'email';
  static const _keyCoins = 'coins';
  // NOTE: this previously (incorrectly) reused the coins key.
  static const _keyPoints = 'points';
  static const _keyDarkMode = 'darkMode';
  static const _keyLanguage = 'language';
  static const _keySound = 'soundEnabled';
  static const _keyLeaderboard = 'leaderboardEnabled';

  // Profile / settings
  static const _keyPassword = 'password'; // prototype only (not secure)
  static const _keyTextScale = 'textScale';
  static const _keyVibration = 'vibrationEnabled';

  //static const _keyPlantsOwned = 'plants';


  // Save Username
  static Future<void> setUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
  }

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername);
  }

  // Save Email
  static Future<void> setEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, email);
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  // Points
  static Future<void> setPoints(int points) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyPoints, points);
  }

  static Future<int> getPoints() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyPoints) ?? 0;
  }

  // Coins
  static Future<void> setCoins(int coins) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyCoins, coins);
  }

  static Future<int> getCoins() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyCoins) ?? 0;
  }

  // Dark Mode
  static Future<void> setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyDarkMode, value);
  }

  static Future<bool> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyDarkMode) ?? false; //Default to ight mode
  }

  // Language
  static Future<void> setLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguage, language);
  }

  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguage) ?? 'en';   //Default to english
  }

  // Sound Enabled or Disabled
  static Future<void> setSoundEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keySound, value);
  }

  static Future<bool> getSoundEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keySound) ?? false;
  }

  
  // Sharing / leaderboard Enabled or Disabled
  static Future<void> setSharing(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLeaderboard, value);
  }

  static Future<bool> getSharing() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyLeaderboard) ?? false;
  }

  // Password (prototype only)
  static Future<void> setPassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPassword, password);
  }

  static Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPassword);
  }

  // Text scaling (1.0 = default)
  static Future<void> setTextScale(double scale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_keyTextScale, scale);
  }

  static Future<double> getTextScale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_keyTextScale) ?? 1.0;
  }

  // Vibration preference
  static Future<void> setVibrationEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyVibration, value);
  }

  static Future<bool> getVibrationEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyVibration) ?? true;
  }
}