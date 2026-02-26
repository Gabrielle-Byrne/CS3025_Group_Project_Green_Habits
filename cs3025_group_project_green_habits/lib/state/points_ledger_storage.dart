import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'points_ledger.dart';
import 'package:flutter/foundation.dart';

class PointsLedgerStorage {
  static const _fileName = "points_ledger.json";

  Future<File> _file() async {
    final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/$_fileName");
  }

  Future<PointsLedger> load() async {
    final f = await _file();
    if (!await f.exists()) return PointsLedger.empty();
    final text = await f.readAsString();
    return PointsLedger.fromJsonString(text);
  }

  Future<void> save(PointsLedger ledger) async {
    try {
      final f = await _file();
      debugPrint("Saving ledger to: ${f.path}");
      await f.writeAsString(jsonEncode(ledger.toJson()));
      debugPrint("Saved OK. Size: ${await f.length()} bytes");
    } catch (e, st) {
      debugPrint("Ledger save FAILED: $e");
      debugPrint("$st");
    }
  }
}
