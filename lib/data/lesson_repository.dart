import '../models/lesson.dart';
import 'english_lessons_data.dart';
import 'math_lessons_data.dart';

class LessonRepository {
  // Singleton pattern
  static final LessonRepository _instance = LessonRepository._internal();
  factory LessonRepository() => _instance;
  LessonRepository._internal();

  // Cache for lessons
  final Map<String, List<Lesson>> _lessonsCache = {};

  /// Get all lessons by category
  List<Lesson> getLessonsByCategory(String category) {
    // Check cache first
    if (_lessonsCache.containsKey(category)) {
      return _lessonsCache[category]!;
    }

    // Load lessons based on category
    List<Lesson> lessons;
    if (category == 'English') {
      lessons = EnglishLessonsData.getAllLessons();
    } else if (category == 'Math') {
      lessons = MathLessonsData.getAllLessons();
    } else {
      lessons = [];
    }

    // Cache the lessons
    _lessonsCache[category] = lessons;
    return lessons;
  }

  /// Get all lessons (both categories)
  List<Lesson> getAllLessons() {
    final englishLessons = getLessonsByCategory('English');
    final mathLessons = getLessonsByCategory('Math');
    return [...englishLessons, ...mathLessons];
  }

  /// Get lesson by ID
  Lesson? getLessonById(String lessonId) {
    final allLessons = getAllLessons();
    try {
      return allLessons.firstWhere((lesson) => lesson.id == lessonId);
    } catch (e) {
      return null;
    }
  }

  /// Get lesson by number and category
  Lesson? getLessonByNumber(int lessonNumber, String category) {
    final lessons = getLessonsByCategory(category);
    try {
      return lessons.firstWhere((lesson) => lesson.lessonNumber == lessonNumber);
    } catch (e) {
      return null;
    }
  }

  /// Get total lessons count by category
  int getTotalLessonsCount(String category) {
    return getLessonsByCategory(category).length;
  }

  /// Get total lessons count (all categories)
  int getTotalLessonsCountAll() {
    return getAllLessons().length;
  }

  /// Search lessons by title
  List<Lesson> searchLessons(String query) {
    final allLessons = getAllLessons();
    final lowerQuery = query.toLowerCase();

    return allLessons.where((lesson) {
      return lesson.title.toLowerCase().contains(lowerQuery) ||
          lesson.subtitle.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  /// Get lessons by completion status
  List<Lesson> getLessonsByCompletion(String category, bool isCompleted) {
    final lessons = getLessonsByCategory(category);
    return lessons.where((lesson) => lesson.isCompleted == isCompleted).toList();
  }

  /// Get in-progress lessons
  List<Lesson> getInProgressLessons(String category) {
    final lessons = getLessonsByCategory(category);
    return lessons.where((lesson) => lesson.isInProgress).toList();
  }

  /// Clear cache (useful for testing or refreshing data)
  void clearCache() {
    _lessonsCache.clear();
  }

  /// Reload lessons for a category
  void reloadCategory(String category) {
    _lessonsCache.remove(category);
  }
}