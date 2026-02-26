import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'points_ledger.dart';
import 'points_ledger_storage.dart';

class PointsStore extends ChangeNotifier {
  final _storage = PointsLedgerStorage();
  final _uuid = const Uuid();

  PointsLedger _ledger = PointsLedger.empty();

  int get points => _ledger.total;
  List<PointsTransaction> get transactions => List.unmodifiable(_ledger.transactions);

  Future<void> init() async {
    _ledger = await _storage.load();
    notifyListeners();
  }

  Future<void> _persist() async {
    await _storage.save(_ledger);
  }

  //Adds a transaction (positive = gain, negative = spend)
  Future<bool> applyTransaction({
    required String source,
    required int amount,
  }) async {
    if (amount == 0) return false;

    if (_ledger.total + amount < 0) return false;

    _ledger.total += amount;
    _ledger.transactions.add(
      PointsTransaction(
        id: _uuid.v4(),
        source: source,
        amount: amount,
      ),
    );

    notifyListeners();
    await _persist();
    return true;
  }
}