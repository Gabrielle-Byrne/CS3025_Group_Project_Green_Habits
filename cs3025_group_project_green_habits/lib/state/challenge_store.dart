import 'package:flutter/foundation.dart';
import 'points_store.dart';

@immutable
class ChallengeDefinition {
  final String id;
  final String title;
  final String activityKey;
  final int targetCount;
  final int rewardPoints;

  const ChallengeDefinition({
    required this.id,
    required this.title,
    required this.activityKey,
    required this.targetCount,
    required this.rewardPoints,
  });
}

class JoinedChallenge {
  final ChallengeDefinition def;
  int progress;

  JoinedChallenge(this.def, {this.progress = 0});

  bool get isComplete => progress >= def.targetCount;
}

class ChallengeStore extends ChangeNotifier {
  PointsStore? _pointsStore;

  void ensureDailyChallenge() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final stored = DateTime(_dailyDate.year, _dailyDate.month, _dailyDate.day);

    if (_dailyDef == null || today.isAfter(stored)) {
      _dailyDate = today;
      _dailyProgress = 0;

      _dailyDef = ChallengeDefinition(
        id: 'daily_${today.toIso8601String().substring(0, 10)}',
        title: 'Recycle bottles 2 times',
        activityKey: 'Recycling',
        targetCount: 2,
        rewardPoints: 50,
      );

      notifyListeners();
    }
  }

  ChallengeDefinition? _dailyDef;
  int _dailyProgress = 0;
  DateTime _dailyDate = DateTime.now();

  ChallengeDefinition? get dailyDef => _dailyDef;
  int get dailyProgress => _dailyProgress;
  bool get dailyComplete =>
      _dailyDef != null && _dailyProgress >= _dailyDef!.targetCount;

  final List<ChallengeDefinition> _available = const [
    ChallengeDefinition(
      id: 'res_energy',
      title: 'Residence Energy Challenge',
      activityKey: 'Energy',
      targetCount: 5,
      rewardPoints: 50,
    ),
    ChallengeDefinition(
      id: 'meatless_monday',
      title: 'Meatless Mondays',
      activityKey: 'Energy',
      targetCount: 3,
      rewardPoints: 40,
    ),
    ChallengeDefinition(
      id: 'bike_challenge',
      title: 'Academic Bike Challenge',
      activityKey: 'Transit',
      targetCount: 7,
      rewardPoints: 80,
    ),
  ];

  final List<JoinedChallenge> _joined = [];
  final List<ChallengeDefinition> _achievements = [];

  int _completionTick = 0;
  String? _lastCompletionMessage;

  // --- Public getters ---
  List<ChallengeDefinition> get available {
    final joinedIds = _joined.map((j) => j.def.id).toSet();
    final achievedIds = _achievements.map((a) => a.id).toSet();
    return _available
        .where((c) => !joinedIds.contains(c.id) && !achievedIds.contains(c.id))
        .toList();
  }

  List<JoinedChallenge> get joined => List.unmodifiable(_joined);
  List<ChallengeDefinition> get achievements =>
      List.unmodifiable(_achievements);

  int get completionTick => _completionTick;
  String? get lastCompletionMessage => _lastCompletionMessage;

  void attachPointsStore(PointsStore pointsStore) {
    _pointsStore = pointsStore;
  }

  // --- Actions ---
  void joinChallenge(ChallengeDefinition def) {
    if (_joined.any((j) => j.def.id == def.id)) return;
    if (_achievements.any((a) => a.id == def.id)) return;
    _joined.add(JoinedChallenge(def));
    notifyListeners();
  }

  // Called whenever an activity is logged
  void onActivityLogged(String activityKey) {
    ensureDailyChallenge();

    bool changed = false;

    // --- Daily progress ---
    if (_dailyDef != null &&
        !dailyComplete &&
        _dailyDef!.activityKey == activityKey) {
      _dailyProgress += 1;
      changed = true;

      if (dailyComplete) {
        _pointsStore?.addPoints(_dailyDef!.rewardPoints);
        _lastCompletionMessage =
            'Daily challenge completed! (+${_dailyDef!.rewardPoints} pts)';
        _completionTick++;
      }
    }

    // ✅ If no joined challenges, still notify so SnackBar + UI update
    if (_joined.isEmpty) {
      if (changed) notifyListeners();
      return;
    }

    // --- Joined challenges progress ---
    final List<JoinedChallenge> completedNow = [];

    for (final j in _joined) {
      if (j.def.activityKey == activityKey && !j.isComplete) {
        j.progress += 1;
        changed = true;

        if (j.isComplete) completedNow.add(j);
      }
    }

    if (completedNow.isNotEmpty) {
      for (final j in completedNow) {
        _joined.removeWhere((x) => x.def.id == j.def.id);
        _achievements.add(j.def);

        _pointsStore?.addPoints(j.def.rewardPoints);

        _lastCompletionMessage =
            'Challenge completed: ${j.def.title} (+${j.def.rewardPoints} pts)';
        _completionTick++;
      }
      changed = true;
    }

    if (changed) notifyListeners();
  }
}
