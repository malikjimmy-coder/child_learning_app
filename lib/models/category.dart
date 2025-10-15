// models/category.dart
class Category {
  final String id;
  final String name;              // "English" or "Math"
  final String displayName;       // "English Language"
  final String description;
  final String iconPath;
  final String colorHex;          // Primary color for category
  final int totalLessons;
  int completedLessons;

  Category({
    required this.id,
    required this.name,
    required this.displayName,
    required this.description,
    required this.iconPath,
    required this.colorHex,
    required this.totalLessons,
    this.completedLessons = 0,
  });

  // Get completion percentage
  double get completionPercentage {
    if (totalLessons == 0) return 0.0;
    return (completedLessons / totalLessons) * 100;
  }

  // Check if all lessons completed
  bool get isAllCompleted => completedLessons >= totalLessons;

  // Get remaining lessons
  int get remainingLessons => totalLessons - completedLessons;

  // JSON Serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'displayName': displayName,
      'description': description,
      'iconPath': iconPath,
      'colorHex': colorHex,
      'totalLessons': totalLessons,
      'completedLessons': completedLessons,
    };
  }

  // JSON Deserialization
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
      displayName: json['displayName'] as String,
      description: json['description'] as String,
      iconPath: json['iconPath'] as String,
      colorHex: json['colorHex'] as String,
      totalLessons: json['totalLessons'] as int,
      completedLessons: json['completedLessons'] as int? ?? 0,
    );
  }

  @override
  String toString() {
    return 'Category(name: $name, completed: $completedLessons/$totalLessons)';
  }
}

// Predefined Categories
class Categories {
  static final Category english = Category(
    id: 'cat_english',
    name: 'English',
    displayName: 'English Language',
    description: 'Learn alphabets, words, and basic English',
    iconPath: 'assets/images/icons/english_icon.png',
    colorHex: '#4CAF50',
    totalLessons: 15,
  );

  static final Category math = Category(
    id: 'cat_math',
    name: 'Math',
    displayName: 'Mathematics',
    description: 'Learn numbers, counting, and basic math',
    iconPath: 'assets/images/icons/math_icon.png',
    colorHex: '#2196F3',
    totalLessons: 15,
  );

  static List<Category> getAllCategories() {
    return [english, math];
  }
}