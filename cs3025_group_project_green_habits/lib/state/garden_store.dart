import 'package:flutter/foundation.dart';

enum PlantStage { seed }

class PlantedItem {
  final String assetPath; // e.g. assets/vectors/seed.svg
  PlantStage stage;
  final DateTime plantedAt;

  PlantedItem({
    required this.assetPath,
    this.stage = PlantStage.seed,
    DateTime? plantedAt,
  }) : plantedAt = plantedAt ?? DateTime.now();
}

class GardenStore extends ChangeNotifier {
  // 12 plots by default: 3 rows x 4 cols
  final int rows;
  final int cols;

  GardenStore({this.rows = 3, this.cols = 4})
      : _plots = List<PlantedItem?>.filled(rows * cols, null);

  final List<PlantedItem?> _plots;

  // Seeds purchased but not planted yet (user chooses plot)
  final List<String> _seedQueue = [];

  int get plotCount => rows * cols;
  PlantedItem? plotAt(int index) => _plots[index];

  int get pendingSeeds => _seedQueue.length;
  String? get nextSeedAsset => _seedQueue.isNotEmpty ? _seedQueue.first : null;

  void queueSeed(String assetPath) {
    _seedQueue.add(assetPath);
    notifyListeners();
  }

  bool plantNextSeedAt(int index) {
    if (_seedQueue.isEmpty) return false;
    if (_plots[index] != null) return false;

    final asset = _seedQueue.removeAt(0);
    _plots[index] = PlantedItem(assetPath: asset);
    notifyListeners();
    return true;
  }
}