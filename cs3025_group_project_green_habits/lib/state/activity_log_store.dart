import 'package:flutter/foundation.dart';
import 'activity_entry.dart';
import 'activity_log_storage.dart';

class ActivityLogStore extends ChangeNotifier {
  final _storage = ActivityLogStorage();
  List<ActivityEntry> _entries = [];

  List<ActivityEntry> get entries => List.unmodifiable(_entries);

  Future<void> init() async {
    _entries = await _storage.load();
    notifyListeners();
  }

  Future<void> addEntry({
    required String activityType,
    required String description,
  }) async {
    final entry = ActivityEntry(
      activityType: activityType,
      description: description.trim(),
      timestamp: DateTime.now(),
    );

    // newest first
    _entries.insert(0, entry);

    notifyListeners();
    await _storage.save(_entries);
  }

  Future<void> clearAll() async {
    _entries = [];
    notifyListeners();
    await _storage.save(_entries);
  }
}