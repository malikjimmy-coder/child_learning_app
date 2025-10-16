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

  // Load lessons by category and sync with saved progress
  Future<void> loadLessons(String category, {Map<String, bool>? completedLessons}) async {
    _isLoading = true;
    _currentCategory = category;
    notifyListeners();

    // Simulate loading delay
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      if (category == 'English') {
        _allLessons = EnglishLessonsData.getAllLessons();
      } else if (category == 'Math') {
        _allLessons = MathLessonsData.getAllLessons();
      } else {
        _allLessons = [];
      }

      // Sort lessons by lesson number first
      _allLessons.sort((a, b) => a.lessonNumber.compareTo(b.lessonNumber));

      // Sync with saved progress if provided
      if (completedLessons != null) {
        _syncWithProgress(completedLessons);
      }

      // Initialize lesson locks after progress sync
      _updateLessonLocks();
      
      debugPrint('Loaded ${_allLessons.length} lessons for $category');
      for (var lesson in _allLessons) {
        debugPrint('Lesson ${lesson.lessonNumber}: ${lesson.title} - Completed: ${lesson.isCompleted}, Locked: ${lesson.isLocked}');
      }
    } catch (e) {
      debugPrint('Error loading lessons: $e');
      _allLessons = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Sync lessons with saved progress
  void _syncWithProgress(Map<String, bool> completedLessons) {
    for (var lesson in _allLessons) {
      if (completedLessons.containsKey(lesson.id)) {
        lesson.isCompleted = completedLessons[lesson.id]!;
      }
    }
  }

  // Update lesson locks based on completion status
  void _updateLessonLocks() {
    if (_allLessons.isEmpty) return;

    // Sort lessons by lesson number to ensure correct order
    _allLessons.sort((a, b) => a.lessonNumber.compareTo(b.lessonNumber));

    // First lesson is always unlocked
    _allLessons[0].isLocked = false;

    // Lock/unlock subsequent lessons based on previous lesson completion
    for (int i = 1; i < _allLessons.length; i++) {
      // Unlock if the immediately previous lesson is completed
      _allLessons[i].isLocked = !_allLessons[i - 1].isCompleted;

      debugPrint('Lesson ${_allLessons[i].lessonNumber}: ${_allLessons[i].title} - '
          'isLocked: ${_allLessons[i].isLocked}, '
          'Previous lesson (${_allLessons[i - 1].lessonNumber}) completed: ${_allLessons[i - 1].isCompleted}');
    }
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

  // Update lesson completion and unlock next lesson
  void updateLessonCompletion(String lessonId, bool isCompleted) {
    final lessonIndex = _allLessons.indexWhere((l) => l.id == lessonId);
    if (lessonIndex != -1) {
      _allLessons[lessonIndex].isCompleted = isCompleted;

      if (isCompleted) {
        _allLessons[lessonIndex].completedAt = DateTime.now();
      }

      // Update locks for all lessons
      _updateLessonLocks();

      debugPrint('✅ Lesson ${_allLessons[lessonIndex].title} completed');
      if (lessonIndex < _allLessons.length - 1) {
        debugPrint('🔓 Next lesson unlocked: ${_allLessons[lessonIndex + 1].title}');
      }

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

  // Get unlocked lessons count
  int getUnlockedLessonsCount() {
    return _allLessons.where((lesson) => !lesson.isLocked).length;
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
      lesson.isLocked = lesson.lessonNumber != 1;
    }
    notifyListeners();
  }

  // Clear all lessons
  void clearLessons() {
    _allLessons.clear();
    _currentCategory = '';
    notifyListeners();
  }

  // Reload lessons with current progress
  void reloadWithProgress(Map<String, bool> completedLessons) {
    // Ensure lessons are sorted before syncing
    _allLessons.sort((a, b) => a.lessonNumber.compareTo(b.lessonNumber));
    
    // Sync with progress
    _syncWithProgress(completedLessons);
    
    // Update locks after progress sync
    _updateLessonLocks();
    
    debugPrint('Reloaded lessons with progress:');
    for (var lesson in _allLessons) {
      debugPrint('Lesson ${lesson.lessonNumber}: ${lesson.title} - Completed: ${lesson.isCompleted}, Locked: ${lesson.isLocked}');
    }
    
    notifyListeners();
  }

  // Force refresh lesson locks (useful when returning from lesson detail)
  void refreshLessonLocks() {
    if (_allLessons.isNotEmpty) {
      _updateLessonLocks();
      notifyListeners();
      debugPrint('Lesson locks refreshed');
    }
  }
}