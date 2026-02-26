import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

class AuthStore extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _username; // your login identifier (email/username)

  // In-session overrides when user changes email/password in Profile.
  // Key = original username (login id), value = updated password/email.
  final Map<String, String> _passwordOverride = {};
  final Map<String, String> _emailOverride = {};

  bool get isLoggedIn => _isLoggedIn;
  String? get username => _username;

  /// Loads users from the JSON asset:
  /// [
  ///   {"username":"abrown@unb.ca","password":"123"}
  /// ]
  Future<List<Map<String, dynamic>>> _loadUsers() async {
    final raw = await rootBundle.loadString('assets/data/users.json');
    final decoded = jsonDecode(raw);
    if (decoded is! List) throw Exception('users.json must be a JSON array');

    return decoded.map<Map<String, dynamic>>((e) {
      if (e is Map<String, dynamic>) return e;
      if (e is Map) return Map<String, dynamic>.from(e);
      throw Exception('Invalid entry in users.json');
    }).toList();
  }

  Future<bool> login(String username, String password) async {
    final u = username.trim().toLowerCase();
    final p = password;

    final users = await _loadUsers();

    // 1) Check if user exists in JSON
    final user = users.firstWhere(
      (row) => (row['username'] ?? '').toString().trim().toLowerCase() == u,
      orElse: () => {},
    );

    if (user.isEmpty) return false;

    // 2) Determine expected password (override if profile changed it this session)
    final expected =
        _passwordOverride[u] ?? (user['password'] ?? '').toString();

    final ok = expected == p;
    if (!ok) return false;

    _isLoggedIn = true;
    _username = u;
    notifyListeners();
    return true;
  }

  void logout() {
    _isLoggedIn = false;
    _username = null;
    notifyListeners();
  }

  /// Update email for the current logged-in user (session-only).
  /// If you treat email as the login identifier, this changes what they will use next login
  /// ONLY for this app run (because assets can't be edited).
  void updateEmailForCurrentUser(String newEmail) {
    if (_username == null) return;
    final current = _username!;
    final normalized = newEmail.trim().toLowerCase();
    _emailOverride[current] = normalized;
    // Optionally also switch the username (login id) immediately:
    _username = normalized;
    notifyListeners();
  }

  /// Update password for the current logged-in user (session-only).
  void updatePasswordForCurrentUser(String newPassword) {
    if (_username == null) return;
    final current = _username!;
    _passwordOverride[current] = newPassword;
    notifyListeners();
  }

  /// For showing in Profile (masked), if you want.
  String? get displayEmail {
    if (_username == null) return null;
    // If you used updateEmailForCurrentUser, _username already updated.
    return _username;
  }

  Future<Map<String, dynamic>?> getCurrentUserRecord() async {
    if (_username == null) return null;

    final users = await _loadUsers();
    final u = _username!.trim().toLowerCase();

    for (final row in users) {
      final name = (row['username'] ?? '').toString().trim().toLowerCase();
      if (name == u) return row;
    }
    return null;
  }
}
