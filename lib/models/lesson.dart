// models/lesson.dart
import 'lesson_page.dart';

class Lesson {
  final String id;                    // Unique identifier (e.g., "eng_01", "math_01")
  final int lessonNumber;             // Sequential number (1, 2, 3...)
  final String title;                 // "Learn Alphabets A-Z"
  final String subtitle;              // "Discover all English letters"
  final String category;              // "English" or "Math"
  final String iconPath;              // Asset path for lesson icon
  final List<LessonPage> pages;       // Content pages within lesson
  bool isCompleted;                   // Completion status
  int lastViewedPage;                 // Resume functionality
  final DateTime createdAt;           // When lesson was created
  DateTime? completedAt;              // When lesson was completed

  Lesson({
    required this.id,
    required this.lessonNumber,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.iconPath,
    required this.pages,
    this.isCompleted = false,
    this.lastViewedPage = 0,
    DateTime? createdAt,
    this.completedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Get total pages count
  int get totalPages => pages.length;

  // Get completion percentage
  double get completionPercentage {
    if (pages.isEmpty) return 0.0;
    return (lastViewedPage / pages.length) * 100;
  }

  // Check if lesson is in progress
  bool get isInProgress => lastViewedPage > 0 && !isCompleted;

  // Check if lesson is started
  bool get isStarted => lastViewedPage > 0;

  // Get current page
  LessonPage? get currentPage {
    if (lastViewedPage >= 0 && lastViewedPage < pages.length) {
      return pages[lastViewedPage];
    }
    return null;
  }

  // JSON Serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lessonNumber': lessonNumber,
      'title': title,
      'subtitle': subtitle,
      'category': category,
      'iconPath': iconPath,
      'pages': pages.map((page) => page.toJson()).toList(),
      'isCompleted': isCompleted,
      'lastViewedPage': lastViewedPage,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  // JSON Deserialization
  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as String,
      lessonNumber: json['lessonNumber'] as int,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      category: json['category'] as String,
      iconPath: json['iconPath'] as String,
      pages: (json['pages'] as List<dynamic>)
          .map((pageJson) => LessonPage.fromJson(pageJson as Map<String, dynamic>))
          .toList(),
      isCompleted: json['isCompleted'] as bool? ?? false,
      lastViewedPage: json['lastViewedPage'] as int? ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }

  // Copy with method
  Lesson copyWith({
    String? id,
    int? lessonNumber,
    String? title,
    String? subtitle,
    String? category,
    String? iconPath,
    List<LessonPage>? pages,
    bool? isCompleted,
    int? lastViewedPage,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return Lesson(
      id: id ?? this.id,
      lessonNumber: lessonNumber ?? this.lessonNumber,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      category: category ?? this.category,
      iconPath: iconPath ?? this.iconPath,
      pages: pages ?? this.pages,
      isCompleted: isCompleted ?? this.isCompleted,
      lastViewedPage: lastViewedPage ?? this.lastViewedPage,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  String toString() {
    return 'Lesson(id: $id, lessonNumber: $lessonNumber, title: $title, '
        'category: $category, isCompleted: $isCompleted, '
        'lastViewedPage: $lastViewedPage, totalPages: $totalPages)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Lesson && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}