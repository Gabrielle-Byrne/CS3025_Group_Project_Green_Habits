import 'dart:convert';

class PointsTransaction {
  final String id;
  final String source;
  final int amount;

  const PointsTransaction({
    required this.id,
    required this.source,
    required this.amount,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "source": source,
        "amount": amount,
      };

  factory PointsTransaction.fromJson(Map<String, dynamic> json) {
    return PointsTransaction(
      id: json["id"] as String,
      source: json["source"] as String,
      amount: (json["amount"] as num).toInt(),
    );
  }
}

class PointsLedger {
  int total;
  final List<PointsTransaction> transactions;

  PointsLedger({required this.total, required this.transactions});

  factory PointsLedger.empty() => PointsLedger(total: 0, transactions: []);

  Map<String, dynamic> toJson() => {
        "total": total,
        "transactions": transactions.map((t) => t.toJson()).toList(),
      };

  factory PointsLedger.fromJsonString(String s) {
    final map = jsonDecode(s) as Map<String, dynamic>;
    final listTransactions = (map["transactions"] as List<dynamic>? ?? [])
        .map((e) => PointsTransaction.fromJson(e as Map<String, dynamic>))
        .toList();
    return PointsLedger(
      total: (map["total"] as num?)?.toInt() ?? 0,
      transactions: listTransactions,
    );
  }
}