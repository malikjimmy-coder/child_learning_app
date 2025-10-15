// models/lesson_progress.dart
class LessonProgress {
  final String lessonId;
  bool isCompleted;
  int highestPageReached;
  DateTime? completionDate;
  DateTime lastUpdated;
  int attemptsCount;              // Number of times lesson was opened
  int timeSpentSeconds;           // Time spent on this lesson
  double? scorePercentage;        // Quiz score (future use)
  List<String> completedPages;    // Track which pages were viewed

  LessonProgress({
    required this.lessonId,
    this.isCompleted = false,
    this.highestPageReached = 0,
    this.completionDate,
    DateTime? lastUpdated,
    this.attemptsCount = 0,
    this.timeSpentSeconds = 0,
    this.scorePercentage,
    List<String>? completedPages,
  })  : lastUpdated = lastUpdated ?? DateTime.now(),
        completedPages = completedPages ?? [];

  // Get time spent in minutes
  int get timeSpentMinutes => (timeSpentSeconds / 60).round();

  // Get progress percentage
  double getProgressPercentage(int totalPages) {
    if (totalPages == 0) return 0.0;
    return (highestPageReached / totalPages) * 100;
  }

  // Mark page as completed
  void markPageCompleted(String pageId) {
    if (!completedPages.contains(pageId)) {
      completedPages.add(pageId);
    }
  }

  // Check if page is completed
  bool isPageCompleted(String pageId) {
    return completedPages.contains(pageId);
  }

  // Increment attempts
  void incrementAttempts() {
    attemptsCount++;
    lastUpdated = DateTime.now();
  }

  // Add time spent
  void addTimeSpent(int seconds) {
    timeSpentSeconds += seconds;
    lastUpdated = DateTime.now();
  }

  // JSON Serialization
  Map<String, dynamic> toJson() {
    return {
      'lessonId': lessonId,
      'isCompleted': isCompleted,
      'highestPageReached': highestPageReached,
      'completionDate': completionDate?.toIso8601String(),
      'lastUpdated': lastUpdated.toIso8601String(),
      'attemptsCount': attemptsCount,
      'timeSpentSeconds': timeSpentSeconds,
      'scorePercentage': scorePercentage,
      'completedPages': completedPages,
    };
  }

  // JSON Deserialization
  factory LessonProgress.fromJson(Map<String, dynamic> json) {
    return LessonProgress(
      lessonId: json['lessonId'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      highestPageReached: json['highestPageReached'] as int? ?? 0,
      completionDate: json['completionDate'] != null
          ? DateTime.parse(json['completionDate'] as String)
          : null,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'] as String)
          : DateTime.now(),
      attemptsCount: json['attemptsCount'] as int? ?? 0,
      timeSpentSeconds: json['timeSpentSeconds'] as int? ?? 0,
      scorePercentage: json['scorePercentage'] as double?,
      completedPages: (json['completedPages'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  // Copy with method
  LessonProgress copyWith({
    String? lessonId,
    bool? isCompleted,
    int? highestPageReached,
    DateTime? completionDate,
    DateTime? lastUpdated,
    int? attemptsCount,
    int? timeSpentSeconds,
    double? scorePercentage,
    List<String>? completedPages,
  }) {
    return LessonProgress(
      lessonId: lessonId ?? this.lessonId,
      isCompleted: isCompleted ?? this.isCompleted,
      highestPageReached: highestPageReached ?? this.highestPageReached,
      completionDate: completionDate ?? this.completionDate,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      attemptsCount: attemptsCount ?? this.attemptsCount,
      timeSpentSeconds: timeSpentSeconds ?? this.timeSpentSeconds,
      scorePercentage: scorePercentage ?? this.scorePercentage,
      completedPages: completedPages ?? this.completedPages,
    );
  }

  @override
  String toString() {
    return 'LessonProgress(lessonId: $lessonId, completed: $isCompleted, '
        'page: $highestPageReached, time: $timeSpentMinutes mins)';
  }
}