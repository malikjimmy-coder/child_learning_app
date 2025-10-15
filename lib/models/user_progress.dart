// models/user_progress.dart
import 'lesson_progress.dart';

class UserProgress {
  final String userId;                          // User identifier
  final String userName;                        // User name
  Map<String, LessonProgress> completedLessons; // Lesson progress map
  DateTime lastAccessDate;                      // Last app access
  DateTime createdAt;                           // Account creation date
  int totalLessonsCompleted;                    // Total completed lessons
  int currentStreak;                            // Current learning streak
  int longestStreak;                            // Longest learning streak
  int totalTimeSpent;                           // Total minutes spent
  Map<String, CategoryProgress> categoryProgress; // Progress by category
  List<String> achievements;                    // Unlocked achievements
  Map<String, int> dailyActivity;              // Daily lesson count

  UserProgress({
    required this.userId,
    required this.userName,
    Map<String, LessonProgress>? completedLessons,
    DateTime? lastAccessDate,
    DateTime? createdAt,
    this.totalLessonsCompleted = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.totalTimeSpent = 0,
    Map<String, CategoryProgress>? categoryProgress,
    List<String>? achievements,
    Map<String, int>? dailyActivity,
  })  : completedLessons = completedLessons ?? {},
        lastAccessDate = lastAccessDate ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now(),
        categoryProgress = categoryProgress ?? {},
        achievements = achievements ?? [],
        dailyActivity = dailyActivity ?? {};

  // Get overall completion percentage
  double getOverallCompletionPercentage(int totalLessons) {
    if (totalLessons == 0) return 0.0;
    return (totalLessonsCompleted / totalLessons) * 100;
  }

  // Get category completion percentage
  double getCategoryCompletionPercentage(String category) {
    final catProgress = categoryProgress[category];
    if (catProgress == null) return 0.0;
    return catProgress.completionPercentage;
  }

  // Check if user learned today
  bool hasLearnedToday() {
    final today = DateTime.now();
    final todayKey = _formatDateKey(today);
    return dailyActivity.containsKey(todayKey) &&
        dailyActivity[todayKey]! > 0;
  }

  // Add daily activity
  void addDailyActivity() {
    final today = DateTime.now();
    final todayKey = _formatDateKey(today);
    dailyActivity[todayKey] = (dailyActivity[todayKey] ?? 0) + 1;
  }

  // Calculate current streak
  void calculateStreak() {
    if (dailyActivity.isEmpty) {
      currentStreak = 0;
      return;
    }

    final sortedDates = dailyActivity.keys.toList()..sort((a, b) => b.compareTo(a));
    int streak = 0;
    DateTime checkDate = DateTime.now();

    for (var dateKey in sortedDates) {
      final date = DateTime.parse(dateKey);
      final dateOnly = DateTime(date.year, date.month, date.day);
      final checkDateOnly = DateTime(checkDate.year, checkDate.month, checkDate.day);

      final difference = checkDateOnly.difference(dateOnly).inDays;

      if (difference == 0 || difference == 1) {
        streak++;
        checkDate = date.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }

    currentStreak = streak;
    if (currentStreak > longestStreak) {
      longestStreak = currentStreak;
    }
  }

  // Add achievement
  void unlockAchievement(String achievementId) {
    if (!achievements.contains(achievementId)) {
      achievements.add(achievementId);
    }
  }

  // Get learning statistics
  Map<String, dynamic> getStatistics() {
    return {
      'totalLessonsCompleted': totalLessonsCompleted,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'totalTimeSpent': totalTimeSpent,
      'achievementsCount': achievements.length,
      'daysActive': dailyActivity.length,
      'averageLessonsPerDay': dailyActivity.isEmpty
          ? 0.0
          : totalLessonsCompleted / dailyActivity.length,
    };
  }

  // Format date as string key
  String _formatDateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  // Get last 7 days activity
  List<DailyActivityData> getLast7DaysActivity() {
    final List<DailyActivityData> activityList = [];
    final today = DateTime.now();

    for (int i = 6; i >= 0; i--) {
      final date = today.subtract(Duration(days: i));
      final dateKey = _formatDateKey(date);
      final count = dailyActivity[dateKey] ?? 0;

      activityList.add(DailyActivityData(
        date: date,
        lessonCount: count,
      ));
    }

    return activityList;
  }

  // JSON Serialization
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'completedLessons': completedLessons.map(
            (key, value) => MapEntry(key, value.toJson()),
      ),
      'lastAccessDate': lastAccessDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'totalLessonsCompleted': totalLessonsCompleted,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'totalTimeSpent': totalTimeSpent,
      'categoryProgress': categoryProgress.map(
            (key, value) => MapEntry(key, value.toJson()),
      ),
      'achievements': achievements,
      'dailyActivity': dailyActivity,
    };
  }

  // JSON Deserialization
  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      completedLessons: (json['completedLessons'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(
          key,
          LessonProgress.fromJson(value as Map<String, dynamic>),
        ),
      ) ??
          {},
      lastAccessDate: json['lastAccessDate'] != null
          ? DateTime.parse(json['lastAccessDate'] as String)
          : DateTime.now(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      totalLessonsCompleted: json['totalLessonsCompleted'] as int? ?? 0,
      currentStreak: json['currentStreak'] as int? ?? 0,
      longestStreak: json['longestStreak'] as int? ?? 0,
      totalTimeSpent: json['totalTimeSpent'] as int? ?? 0,
      categoryProgress: (json['categoryProgress'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(
          key,
          CategoryProgress.fromJson(value as Map<String, dynamic>),
        ),
      ) ??
          {},
      achievements: (json['achievements'] as List<dynamic>?)?.cast<String>() ?? [],
      dailyActivity: (json['dailyActivity'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, value as int),
      ) ??
          {},
    );
  }

  // Copy with method
  UserProgress copyWith({
    String? userId,
    String? userName,
    Map<String, LessonProgress>? completedLessons,
    DateTime? lastAccessDate,
    DateTime? createdAt,
    int? totalLessonsCompleted,
    int? currentStreak,
    int? longestStreak,
    int? totalTimeSpent,
    Map<String, CategoryProgress>? categoryProgress,
    List<String>? achievements,
    Map<String, int>? dailyActivity,
  }) {
    return UserProgress(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      completedLessons: completedLessons ?? this.completedLessons,
      lastAccessDate: lastAccessDate ?? this.lastAccessDate,
      createdAt: createdAt ?? this.createdAt,
      totalLessonsCompleted: totalLessonsCompleted ?? this.totalLessonsCompleted,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      totalTimeSpent: totalTimeSpent ?? this.totalTimeSpent,
      categoryProgress: categoryProgress ?? this.categoryProgress,
      achievements: achievements ?? this.achievements,
      dailyActivity: dailyActivity ?? this.dailyActivity,
    );
  }

  @override
  String toString() {
    return 'UserProgress(userName: $userName, completed: $totalLessonsCompleted, '
        'streak: $currentStreak, timeSpent: $totalTimeSpent mins)';
  }
}

// Category Progress Model
class CategoryProgress {
  final String categoryId;
  int completedLessons;
  int totalLessons;
  DateTime lastUpdated;

  CategoryProgress({
    required this.categoryId,
    required this.completedLessons,
    required this.totalLessons,
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? DateTime.now();

  double get completionPercentage {
    if (totalLessons == 0) return 0.0;
    return (completedLessons / totalLessons) * 100;
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'completedLessons': completedLessons,
      'totalLessons': totalLessons,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  factory CategoryProgress.fromJson(Map<String, dynamic> json) {
    return CategoryProgress(
      categoryId: json['categoryId'] as String,
      completedLessons: json['completedLessons'] as int,
      totalLessons: json['totalLessons'] as int,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'] as String)
          : DateTime.now(),
    );
  }
}

// Daily Activity Data Model
class DailyActivityData {
  final DateTime date;
  final int lessonCount;

  DailyActivityData({
    required this.date,
    required this.lessonCount,
  });
}