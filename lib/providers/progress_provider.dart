// providers/progress_provider.dart
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProgressProvider with ChangeNotifier {
  Map<String, LessonProgress> _progressMap = {};
  bool _isLoading = false;

  Map<String, LessonProgress> get progressMap => _progressMap;
  bool get isLoading => _isLoading;

  // Initialize and load saved progress
  Future<void> loadProgress() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? progressJson = prefs.getString('lesson_progress');

      if (progressJson != null && progressJson.isNotEmpty) {
        final Map<String, dynamic> decoded = json.decode(progressJson);
        _progressMap = decoded.map(
              (key, value) => MapEntry(
            key,
            LessonProgress.fromJson(value as Map<String, dynamic>),
          ),
        );
        debugPrint('Progress loaded: ${_progressMap.length} lessons');
      } else {
        debugPrint('No saved progress found');
      }
    } catch (e) {
      debugPrint('Error loading progress: $e');
      _progressMap = {};
    }

    _isLoading = false;
    notifyListeners();
  }

  // Save progress to local storage
  Future<void> _saveProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final progressJson = json.encode(
        _progressMap.map((key, value) => MapEntry(key, value.toJson())),
      );
      await prefs.setString('lesson_progress', progressJson);
      debugPrint('Progress saved successfully');
    } catch (e) {
      debugPrint('Error saving progress: $e');
    }
  }

  // Update lesson progress
  Future<void> updateLessonProgress(
      String lessonId,
      int currentPage,
      bool isCompleted,
      ) async {
    if (_progressMap.containsKey(lessonId)) {
      // Update existing progress
      final existingProgress = _progressMap[lessonId]!;

      // Only update if the new page is higher than the previous one
      if (currentPage > existingProgress.highestPageReached) {
        existingProgress.highestPageReached = currentPage;
      }

      existingProgress.isCompleted = isCompleted;
      existingProgress.lastUpdated = DateTime.now();

      if (isCompleted && existingProgress.completionDate == null) {
        existingProgress.completionDate = DateTime.now();
      }
    } else {
      // Create new progress entry
      _progressMap[lessonId] = LessonProgress(
        lessonId: lessonId,
        isCompleted: isCompleted,
        highestPageReached: currentPage,
        completionDate: isCompleted ? DateTime.now() : null,
        lastUpdated: DateTime.now(),
      );
    }

    notifyListeners();
    await _saveProgress();
  }

  // Mark lesson as completed
  Future<void> completeLesson(String lessonId) async {
    if (_progressMap.containsKey(lessonId)) {
      _progressMap[lessonId]!.isCompleted = true;
      _progressMap[lessonId]!.completionDate = DateTime.now();
      _progressMap[lessonId]!.lastUpdated = DateTime.now();
    } else {
      _progressMap[lessonId] = LessonProgress(
        lessonId: lessonId,
        isCompleted: true,
        highestPageReached: 0,
        completionDate: DateTime.now(),
        lastUpdated: DateTime.now(),
      );
    }

    notifyListeners();
    await _saveProgress();
  }

  // Get progress for specific lesson
  LessonProgress? getLessonProgress(String lessonId) {
    return _progressMap[lessonId];
  }

  // Check if lesson is completed
  bool isLessonCompleted(String lessonId) {
    return _progressMap[lessonId]?.isCompleted ?? false;
  }

  // Get highest page reached for a lesson
  int getHighestPageReached(String lessonId) {
    return _progressMap[lessonId]?.highestPageReached ?? 0;
  }

  // Get completion percentage for all lessons
  double getCompletionPercentage(int totalLessons) {
    if (totalLessons == 0) return 0.0;
    final completedCount = _progressMap.values
        .where((progress) => progress.isCompleted)
        .length;
    return (completedCount / totalLessons) * 100;
  }

  // Get completion percentage by category
  double getCompletionPercentageByCategory(
      List<String> lessonIds,
      ) {
    if (lessonIds.isEmpty) return 0.0;

    final completedCount = lessonIds
        .where((id) => isLessonCompleted(id))
        .length;

    return (completedCount / lessonIds.length) * 100;
  }

  // Get total completed lessons count
  int getTotalCompletedCount() {
    return _progressMap.values
        .where((progress) => progress.isCompleted)
        .length;
  }

  // Get recently completed lessons (last 7 days)
  List<String> getRecentlyCompletedLessons() {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));

    return _progressMap.entries
        .where((entry) =>
    entry.value.isCompleted &&
        entry.value.completionDate != null &&
        entry.value.completionDate!.isAfter(sevenDaysAgo))
        .map((entry) => entry.key)
        .toList();
  }

  // Get in-progress lessons (started but not completed)
  List<String> getInProgressLessons() {
    return _progressMap.entries
        .where((entry) =>
    !entry.value.isCompleted &&
        entry.value.highestPageReached > 0)
        .map((entry) => entry.key)
        .toList();
  }

  // Get learning streak (consecutive days with completed lessons)
  int getLearningStreak() {
    if (_progressMap.isEmpty) return 0;

    final completedDates = _progressMap.values
        .where((progress) =>
    progress.isCompleted && progress.completionDate != null)
        .map((progress) => progress.completionDate!)
        .toList();

    if (completedDates.isEmpty) return 0;

    // Sort dates in descending order
    completedDates.sort((a, b) => b.compareTo(a));

    int streak = 0;
    DateTime checkDate = DateTime.now();

    for (var date in completedDates) {
      final dateOnly = DateTime(date.year, date.month, date.day);
      final checkDateOnly =
      DateTime(checkDate.year, checkDate.month, checkDate.day);

      if (dateOnly == checkDateOnly ||
          dateOnly == checkDateOnly.subtract(const Duration(days: 1))) {
        streak++;
        checkDate = date.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }

    return streak;
  }

  // Check if user learned today
  bool hasLearnedToday() {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    return _progressMap.values.any((progress) {
      if (progress.completionDate == null) return false;
      final completionDate = progress.completionDate!;
      final completionDateOnly = DateTime(
        completionDate.year,
        completionDate.month,
        completionDate.day,
      );
      return completionDateOnly == todayDate;
    });
  }

  // Get total learning time (estimated)
  Duration getTotalLearningTime() {
    // Assume average 5 minutes per lesson
    final completedCount = getTotalCompletedCount();
    return Duration(minutes: completedCount * 5);
  }

  // Clear all progress (for testing)
  Future<void> clearAllProgress() async {
    _progressMap.clear();
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('lesson_progress');
      debugPrint('All progress cleared');
    } catch (e) {
      debugPrint('Error clearing progress: $e');
    }
  }

  // Export progress as JSON (for backup)
  String exportProgress() {
    return json.encode(
      _progressMap.map((key, value) => MapEntry(key, value.toJson())),
    );
  }

  // Import progress from JSON (for restore)
  Future<void> importProgress(String progressJson) async {
    try {
      final Map<String, dynamic> decoded = json.decode(progressJson);
      _progressMap = decoded.map(
            (key, value) => MapEntry(
          key,
          LessonProgress.fromJson(value as Map<String, dynamic>),
        ),
      );
      notifyListeners();
      await _saveProgress();
      debugPrint('Progress imported successfully');
    } catch (e) {
      debugPrint('Error importing progress: $e');
    }
  }
}

// Progress Model
class LessonProgress {
  final String lessonId;
  bool isCompleted;
  int highestPageReached;
  DateTime? completionDate;
  DateTime lastUpdated;

  LessonProgress({
    required this.lessonId,
    required this.isCompleted,
    required this.highestPageReached,
    this.completionDate,
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? DateTime.now();

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'lessonId': lessonId,
      'isCompleted': isCompleted,
      'highestPageReached': highestPageReached,
      'completionDate': completionDate?.toIso8601String(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  // Create from JSON
  factory LessonProgress.fromJson(Map<String, dynamic> json) {
    return LessonProgress(
      lessonId: json['lessonId'] as String,
      isCompleted: json['isCompleted'] as bool,
      highestPageReached: json['highestPageReached'] as int,
      completionDate: json['completionDate'] != null
          ? DateTime.parse(json['completionDate'] as String)
          : null,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'] as String)
          : DateTime.now(),
    );
  }

  // Copy with method
  LessonProgress copyWith({
    String? lessonId,
    bool? isCompleted,
    int? highestPageReached,
    DateTime? completionDate,
    DateTime? lastUpdated,
  }) {
    return LessonProgress(
      lessonId: lessonId ?? this.lessonId,
      isCompleted: isCompleted ?? this.isCompleted,
      highestPageReached: highestPageReached ?? this.highestPageReached,
      completionDate: completionDate ?? this.completionDate,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  String toString() {
    return 'LessonProgress(lessonId: $lessonId, isCompleted: $isCompleted, '
        'highestPageReached: $highestPageReached, completionDate: $completionDate)';
  }
}