import 'package:flutter/foundation.dart';

//Only keeps points while app is running
class PointsStore extends ChangeNotifier {
  int _points = 0;
  int get points => _points;

  final Map<String, int> _activityPoints = const {
    'Recycling': 10,
    'Transit': 15,
    'Energy': 5,
  };

  int pointsFor(String activity) => _activityPoints[activity] ?? 0;

  void logActivity(String activity) {
    final earned = pointsFor(activity);
    _points += earned;
    notifyListeners();
  }

  void addPoints(int amount) {
    _points += amount;
    notifyListeners();
  }
}