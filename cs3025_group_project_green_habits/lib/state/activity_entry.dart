class ActivityEntry {
  final String activityType;
  final String description; 
  final DateTime timestamp;

  const ActivityEntry({
    required this.activityType,
    required this.description,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        "activityType": activityType,
        "description": description,
        "timestamp": timestamp.toIso8601String(),
      };

  factory ActivityEntry.fromJson(Map<String, dynamic> json) {
    return ActivityEntry(
      activityType: json["activityType"] as String,
      description: (json["description"] as String?) ?? "",
      timestamp: DateTime.parse(json["timestamp"] as String),
    );
  }
}