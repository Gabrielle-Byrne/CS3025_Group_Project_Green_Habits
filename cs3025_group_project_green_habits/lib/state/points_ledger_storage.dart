import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'points_ledger.dart';

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
    final f = await _file();
    await f.writeAsString(jsonEncode(ledger.toJson()));
  }
}