// lib/utils/constants.dart
import 'package:flutter/material.dart';

/// App-wide constants
class AppConstants {
  // App Info
  static const String appName = 'Kids Learning Hub';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Learning Made Fun for Every Child';

  // Storage Keys
  static const String userProgressKey = 'user_progress';
  static const String lessonProgressKey = 'lesson_progress';
  static const String settingsKey = 'app_settings';

  // Lesson Categories
  static const String categoryEnglish = 'English';
  static const String categoryMath = 'Math';

  // Default Values
  static const int defaultPageDuration = 300; // 5 minutes in seconds
  static const int splashDuration = 3; // seconds
  static const int maxLessonsPerCategory = 15;
}

/// Color Constants
class AppColors {
  // Brand Colors
  static const Color primaryGreen = Color(0xFF4CAF50);
  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color accentOrange = Color(0xFFFF9800);
  static const Color accentYellow = Color(0xFFFFC107);

  // Category Colors
  static const Color englishPrimary = Color(0xFF4CAF50);
  static const Color englishLight = Color(0xFF66BB6A);
  static const Color englishDark = Color(0xFF388E3C);

  static const Color mathPrimary = Color(0xFF2196F3);
  static const Color mathLight = Color(0xFF42A5F5);
  static const Color mathDark = Color(0xFF1976D2);

  // Backgrounds
  static const Color backgroundLight = Color(0xFFFFFBF5);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFF5F5F5);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFF9E9E9E);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Status Colors
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color warningOrange = Color(0xFFFF9800);
  static const Color errorRed = Color(0xFFF44336);
  static const Color infoBlue = Color(0xFF2196F3);

  // UI Elements
  static const Color divider = Color(0xFFBDBDBD);
  static const Color shadow = Color(0x1F000000);
  static const Color overlay = Color(0x80000000);

  // Transparent
  static const Color transparent = Colors.transparent;
}

/// Gradient Constants
class AppGradients {
  static const LinearGradient englishGradient = LinearGradient(
    colors: [AppColors.englishPrimary, AppColors.englishLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient mathGradient = LinearGradient(
    colors: [AppColors.mathPrimary, AppColors.mathLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFFFFF9C4), Color(0xFFFFFFFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

/// Dimension Constants
class AppDimensions {
  // Padding
  static const double paddingXSmall = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  // Margins
  static const double marginSmall = 8.0;
  static const double marginMedium = 16.0;
  static const double marginLarge = 24.0;

  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 15.0;
  static const double radiusLarge = 20.0;
  static const double radiusXLarge = 30.0;
  static const double radiusCircular = 50.0;

  // Elevation
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
  static const double elevationXHigh = 12.0;

  // Button Sizes
  static const double buttonHeightSmall = 45.0;
  static const double buttonHeightMedium = 55.0;
  static const double buttonHeightLarge = 120.0;

  // Icon Sizes
  static const double iconXSmall = 16.0;
  static const double iconSmall = 24.0;
  static const double iconMedium = 32.0;
  static const double iconLarge = 60.0;
  static const double iconXLarge = 80.0;

  // Card Sizes
  static const double lessonCardHeight = 100.0;
  static const double lessonIconSize = 80.0;

  // App Bar
  static const double appBarHeight = 60.0;
}

/// Text Style Constants
class AppTextStyles {
  // Font Family
  static const String fontFamily = 'Poppins';

  // Headings
  static const TextStyle heading1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle heading4 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // Body Text
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textLight,
    height: 1.5,
  );

  // Caption
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textLight,
    height: 1.4,
  );

  // Lesson Content
  static const TextStyle lessonPrimary = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryBlue,
    height: 1.2,
  );

  static const TextStyle lessonSecondary = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // Buttons
  static const TextStyle buttonLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite,
    letterSpacing: 0.5,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite,
    letterSpacing: 0.5,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite,
    letterSpacing: 0.5,
  );
}

/// Animation Constants
class AppAnimations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);

  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve bounceCurve = Curves.elasticOut;
  static const Curve fastOutSlowIn = Curves.fastOutSlowIn;
}

/// Asset Paths
class AppAssets {
  // Images Base Path
  static const String imagesPath = 'assets/images';
  static const String audioPath = 'assets/audio';

  // Splash
  static const String splashLogo = '$imagesPath/splash/logo.png';

  // Icons
  static const String englishIcon = '$imagesPath/icons/english_icon.png';
  static const String mathIcon = '$imagesPath/icons/math_icon.png';
  static const String alphabetIcon = '$imagesPath/icons/alphabet_icon.png';
  static const String numbersIcon = '$imagesPath/icons/numbers_icon.png';

  // Backgrounds
  static const String homeBackground = '$imagesPath/backgrounds/home_bg.png';
  static const String homeIllustration = '$imagesPath/backgrounds/home_illustration.png';

  // English Lessons
  static const String englishLessonsPath = '$imagesPath/lessons/english';
  static const String englishAlphabetsPath = '$englishLessonsPath/alphabets';
  static const String englishVowelsPath = '$englishLessonsPath/vowels';

  // Math Lessons
  static const String mathLessonsPath = '$imagesPath/lessons/math';
  static const String mathNumbersPath = '$mathLessonsPath/numbers';
  static const String mathShapesPath = '$mathLessonsPath/shapes';

  // Audio Files
  static const String englishAudioPath = '$audioPath/english';
  static const String mathAudioPath = '$audioPath/math';
}

/// String Constants
class AppStrings {
  // App
  static const String appName = 'Kids Learning Hub';
  static const String appTagline = 'Learning Made Fun for Every Child';

  // Home Screen
  static const String homeWelcome = 'Hello! 👋';
  static const String homeQuestion = 'What would you like to learn today?';
  static const String homeSubtitle = 'Choose your favorite subject';

  // Categories
  static const String englishTitle = 'ENGLISH';
  static const String englishSubtitle = 'Learn Alphabets & Words';
  static const String mathTitle = 'MATH';
  static const String mathSubtitle = 'Learn Numbers & Counting';

  // Lessons List
  static const String englishLessonsTitle = 'English Lessons';
  static const String mathLessonsTitle = 'Math Lessons';
  static const String noLessons = 'No lessons available';

  // Lesson Detail
  static const String previousButton = 'Previous';
  static const String nextButton = 'Next';
  static const String completeButton = 'Complete';
  static const String lessonCompleted = 'Lesson Completed! 🎉';

  // Common
  static const String loading = 'Loading...';
  static const String retry = 'Retry';
  static const String cancel = 'Cancel';
  static const String ok = 'OK';
  static const String version = 'Version';
}