import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const _keyUsername = 'username';
  static const _keyEmail = 'email';
  static const _keyCoins = 'coins';
  static const _keyPoints = 'points';
  static const _keyDarkMode = 'darkMode';
  static const _keyLanguage = 'language';
  static const _keySound = 'soundEnabled';
  static const _keyLeaderboard = 'leaderboardEnabled';
  static const _keyTextSize= "textsize";


  //static const _keyPlantsOwned = 'plants';


  // Save Username
  static Future<void> setUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
  }

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername) ?? "Alice Brown";
  }

  // Save Email
  static Future<void> setEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, email);
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail) ?? "abrown@unb.ca";
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
    return prefs.getBool(_keyDarkMode) ?? false; //Default to light mode
  }

  // Language
  static Future<void> setLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguage, language);
  }

  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguage) ?? 'en';   //Default to English
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
  static Future<void> setSharingEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLeaderboard, value);
  }

  static Future<bool> getSharingEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyLeaderboard) ?? false;
  }


    // Dark Mode
  static Future<void> setTextSize(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyTextSize, value);
  }

  static Future<int> getTextSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyTextSize) ?? 12; //Default to 12pt text size
  }
}