class PointsRules {
  static const Map<String, int> activityPoints = {
    "Recycling": 15,
    "Transit": 10,
    "Energy": 5,
  };

  static int pointsForActivity(String activityKey) {
    return activityPoints[activityKey] ?? 0;
  }

  static const Map<String, int> storePrices = {
    "Mystery Seed": 50,
    "Self Watering Pot": 50,
    "Extend Garden": 100,
  };

  static int costForItem(String itemName) {
    return storePrices[itemName] ?? 0;
  }
}