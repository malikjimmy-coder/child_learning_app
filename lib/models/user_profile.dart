// models/user_profile.dart
class UserProfile {
  final String id;
  String name;
  int age;
  String? avatarPath;
  DateTime createdAt;
  DateTime lastActiveAt;
  int totalLessonsCompleted;
  int currentStreak;
  int longestStreak;

  UserProfile({
    required this.id,
    required this.name,
    required this.age,
    this.avatarPath,
    DateTime? createdAt,
    DateTime? lastActiveAt,
    this.totalLessonsCompleted = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
  })  : createdAt = createdAt ?? DateTime.now(),
        lastActiveAt = lastActiveAt ?? DateTime.now();

  // JSON Serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'avatarPath': avatarPath,
      'createdAt': createdAt.toIso8601String(),
      'lastActiveAt': lastActiveAt.toIso8601String(),
      'totalLessonsCompleted': totalLessonsCompleted,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
    };
  }

  // JSON Deserialization
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      avatarPath: json['avatarPath'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastActiveAt: DateTime.parse(json['lastActiveAt'] as String),
      totalLessonsCompleted: json['totalLessonsCompleted'] as int? ?? 0,
      currentStreak: json['currentStreak'] as int? ?? 0,
      longestStreak: json['longestStreak'] as int? ?? 0,
    );
  }

  @override
  String toString() {
    return 'UserProfile(name: $name, age: $age, completed: $totalLessonsCompleted)';
  }
}