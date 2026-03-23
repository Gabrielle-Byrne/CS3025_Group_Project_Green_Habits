import 'package:flutter/foundation.dart';

enum PlantStage { seed }

class PlantedItem {
  final String assetPath;
  PlantStage stage;
  final DateTime plantedAt;

  PlantedItem({
    required this.assetPath,
    this.stage = PlantStage.seed,
    DateTime? plantedAt,
  }) : plantedAt = plantedAt ?? DateTime.now();
}

class GardenStore extends ChangeNotifier {
  final int cols;
  final List<PlantedItem?> _plots;
  final List<String> _seedQueue = [];

  GardenStore({
    this.cols = 4,
    int initialPlotCount = 12,
  }) : _plots = List<PlantedItem?>.filled(initialPlotCount, null);

  int get plotCount => _plots.length;

  int get rowCount => (_plots.length / cols).ceil();

  PlantedItem? plotAt(int index) => _plots[index];

  int get pendingSeeds => _seedQueue.length;
  String? get nextSeedAsset => _seedQueue.isNotEmpty ? _seedQueue.first : null;

  bool get allPlotsFilled => _plots.every((plot) => plot != null);

  void queueSeed(String assetPath) {
    _seedQueue.add(assetPath);
    notifyListeners();
  }

  bool plantNextSeedAt(int index) {
    if (_seedQueue.isEmpty) return false;
    if (index < 0 || index >= _plots.length) return false;
    if (_plots[index] != null) return false;

    final asset = _seedQueue.removeAt(0);
    _plots[index] = PlantedItem(assetPath: asset);
    notifyListeners();
    return true;
  }

  void extendGarden({int additionalPlots = 12}) {
    _plots.addAll(List<PlantedItem?>.filled(additionalPlots, null));
    notifyListeners();
  }
}