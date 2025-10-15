// models/lesson_page.dart
class LessonPage {
  final String id;                    // Unique page identifier
  final String title;                 // "A for Apple"
  final String primaryText;           // "A" or "1"
  final String secondaryText;         // "Apple" or "One"
  final String? description;          // Additional explanation (optional)
  final String imagePath;             // Asset path for main image
  final String? audioPath;            // Asset path for pronunciation audio
  final String? backgroundColor;      // Hex color code for page background
  final int pageNumber;               // Page sequence number
  final PageType pageType;            // Type of content

  LessonPage({
    required this.id,
    required this.title,
    required this.primaryText,
    required this.secondaryText,
    this.description,
    required this.imagePath,
    this.audioPath,
    this.backgroundColor,
    required this.pageNumber,
    this.pageType = PageType.standard,
  });

  // Check if audio is available
  bool get hasAudio => audioPath != null && audioPath!.isNotEmpty;

  // Check if description is available
  bool get hasDescription => description != null && description!.isNotEmpty;

  // Get background color or default
  String get bgColor => backgroundColor ?? '#FFFFFF';

  // JSON Serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'primaryText': primaryText,
      'secondaryText': secondaryText,
      'description': description,
      'imagePath': imagePath,
      'audioPath': audioPath,
      'backgroundColor': backgroundColor,
      'pageNumber': pageNumber,
      'pageType': pageType.toString().split('.').last,
    };
  }

  // JSON Deserialization
  factory LessonPage.fromJson(Map<String, dynamic> json) {
    return LessonPage(
      id: json['id'] as String,
      title: json['title'] as String,
      primaryText: json['primaryText'] as String,
      secondaryText: json['secondaryText'] as String,
      description: json['description'] as String?,
      imagePath: json['imagePath'] as String,
      audioPath: json['audioPath'] as String?,
      backgroundColor: json['backgroundColor'] as String?,
      pageNumber: json['pageNumber'] as int,
      pageType: _parsePageType(json['pageType'] as String?),
    );
  }

  // Parse PageType from string
  static PageType _parsePageType(String? type) {
    if (type == null) return PageType.standard;
    switch (type) {
      case 'standard':
        return PageType.standard;
      case 'quiz':
        return PageType.quiz;
      case 'interactive':
        return PageType.interactive;
      case 'video':
        return PageType.video;
      default:
        return PageType.standard;
    }
  }

  // Copy with method
  LessonPage copyWith({
    String? id,
    String? title,
    String? primaryText,
    String? secondaryText,
    String? description,
    String? imagePath,
    String? audioPath,
    String? backgroundColor,
    int? pageNumber,
    PageType? pageType,
  }) {
    return LessonPage(
      id: id ?? this.id,
      title: title ?? this.title,
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      audioPath: audioPath ?? this.audioPath,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      pageNumber: pageNumber ?? this.pageNumber,
      pageType: pageType ?? this.pageType,
    );
  }

  @override
  String toString() {
    return 'LessonPage(id: $id, title: $title, pageNumber: $pageNumber, '
        'hasAudio: $hasAudio, hasDescription: $hasDescription)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LessonPage && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// Page Type Enum
enum PageType {
  standard,      // Normal lesson page
  quiz,          // Quiz/practice page (future use)
  interactive,   // Interactive activity (future use)
  video,         // Video content (future use)
}