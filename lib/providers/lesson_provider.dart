// providers/lesson_provider.dart
import 'package:flutter/foundation.dart';
import '../models/lesson.dart';
import '../data/english_lessons_data.dart';
import '../data/math_lessons_data.dart';

class LessonProvider with ChangeNotifier {
  List<Lesson> _allLessons = [];
  bool _isLoading = false;
  String _currentCategory = '';

  List<Lesson> get allLessons => _allLessons;
  bool get isLoading => _isLoading;
  String get currentCategory => _currentCategory;

  // Load lessons by category
  Future<void> loadLessons(String category) async {
    _isLoading = true;
    _currentCategory = category;
    notifyListeners();

    // Simulate loading delay (remove in production or reduce to 100ms)
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      if (category == 'English') {
        _allLessons = EnglishLessonsData.getAllLessons();
      } else if (category == 'Math') {
        _allLessons = MathLessonsData.getAllLessons();
      } else {
        _allLessons = [];
      }
    } catch (e) {
      debugPrint('Error loading lessons: $e');
      _allLessons = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Get lessons by category
  List<Lesson> getLessonsByCategory(String category) {
    return _allLessons
        .where((lesson) => lesson.category == category)
        .toList();
  }

  // Get lesson by ID
  Lesson? getLessonById(String lessonId) {
    try {
      return _allLessons.firstWhere((lesson) => lesson.id == lessonId);
    } catch (e) {
      debugPrint('Lesson not found: $lessonId');
      return null;
    }
  }

  // Get lesson by number and category
  Lesson? getLessonByNumber(int lessonNumber, String category) {
    try {
      return _allLessons.firstWhere(
            (lesson) =>
        lesson.lessonNumber == lessonNumber &&
            lesson.category == category,
      );
    } catch (e) {
      debugPrint('Lesson not found: $lessonNumber in $category');
      return null;
    }
  }

  // Update lesson completion status
  void updateLessonCompletion(String lessonId, bool isCompleted) {
    final lessonIndex = _allLessons.indexWhere((l) => l.id == lessonId);
    if (lessonIndex != -1) {
      _allLessons[lessonIndex].isCompleted = isCompleted;
      notifyListeners();
    }
  }

  // Update last viewed page
  void updateLastViewedPage(String lessonId, int pageNumber) {
    final lessonIndex = _allLessons.indexWhere((l) => l.id == lessonId);
    if (lessonIndex != -1) {
      _allLessons[lessonIndex].lastViewedPage = pageNumber;
      notifyListeners();
    }
  }

  // Get total lessons count
  int getTotalLessonsCount() {
    return _allLessons.length;
  }

  // Get completed lessons count
  int getCompletedLessonsCount() {
    return _allLessons.where((lesson) => lesson.isCompleted).length;
  }

  // Get lessons count by category
  int getLessonsCountByCategory(String category) {
    return _allLessons.where((lesson) => lesson.category == category).length;
  }

  // Get completed lessons count by category
  int getCompletedLessonsCountByCategory(String category) {
    return _allLessons
        .where((lesson) => lesson.category == category && lesson.isCompleted)
        .length;
  }

  // Check if all lessons in a category are completed
  bool isAllLessonsCompleted(String category) {
    final categoryLessons = getLessonsByCategory(category);
    if (categoryLessons.isEmpty) return false;
    return categoryLessons.every((lesson) => lesson.isCompleted);
  }

  // Reset all progress (for testing purposes)
  void resetAllProgress() {
    for (var lesson in _allLessons) {
      lesson.isCompleted = false;
      lesson.lastViewedPage = 0;
    }
    notifyListeners();
  }

  // Clear all lessons
  void clearLessons() {
    _allLessons.clear();
    _currentCategory = '';
    notifyListeners();
  }
}