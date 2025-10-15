// models/achievement.dart
class Achievement {
  final String id;
  final String name;
  final String description;
  final String iconPath;
  final AchievementType type;
  final int targetValue;
  int currentValue;
  bool isUnlocked;
  DateTime? unlockedAt;

  Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.iconPath,
    required this.type,
    required this.targetValue,
    this.currentValue = 0,
    this.isUnlocked = false,
    this.unlockedAt,
  });

  // Get progress percentage
  double get progressPercentage {
    if (targetValue == 0) return 0.0;
    return (currentValue / targetValue).clamp(0.0, 1.0) * 100;
  }

  // Check if achievement is completed
  bool get isCompleted => currentValue >= targetValue;

  // JSON Serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'iconPath': iconPath,
      'type': type.toString().split('.').last,
      'targetValue': targetValue,
      'currentValue': currentValue,
      'isUnlocked': isUnlocked,
      'unlockedAt': unlockedAt?.toIso8601String(),
    };
  }

  // JSON Deserialization
  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      iconPath: json['iconPath'] as String,
      type: _parseAchievementType(json['type'] as String),
      targetValue: json['targetValue'] as int,
      currentValue: json['currentValue'] as int? ?? 0,
      isUnlocked: json['isUnlocked'] as bool? ?? false,
      unlockedAt: json['unlockedAt'] != null
          ? DateTime.parse(json['unlockedAt'] as String)
          : null,
    );
  }

  static AchievementType _parseAchievementType(String type) {
    switch (type) {
      case 'lessonsCompleted':
        return AchievementType.lessonsCompleted;
      case 'streak':
        return AchievementType.streak;
      case 'categoryMaster':
        return AchievementType.categoryMaster;
      case 'timeSpent':
        return AchievementType.timeSpent;
      default:
        return AchievementType.lessonsCompleted;
    }
  }

  @override
  String toString() {
    return 'Achievement(name: $name, progress: $currentValue/$targetValue)';
  }
}

enum AchievementType {
  lessonsCompleted,   // Complete X lessons
  streak,             // X day streak
  categoryMaster,     // Complete all lessons in category
  timeSpent,          // Spend X minutes learning
}