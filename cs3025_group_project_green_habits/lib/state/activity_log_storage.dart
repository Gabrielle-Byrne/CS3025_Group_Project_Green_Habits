import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'activity_entry.dart';

class ActivityLogStorage {
  static const _fileName = "activity_log.json";

  Future<File> _file() async {
    final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/$_fileName");
  }

  Future<List<ActivityEntry>> load() async {
    final f = await _file();
    if (!await f.exists()) return [];

    final text = await f.readAsString();
    if (text.trim().isEmpty) return [];

    final raw = jsonDecode(text) as List<dynamic>;
    return raw
        .map((e) => ActivityEntry.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> save(List<ActivityEntry> entries) async {
    final f = await _file();
    final data = entries.map((e) => e.toJson()).toList();
    await f.writeAsString(jsonEncode(data));
  }
}