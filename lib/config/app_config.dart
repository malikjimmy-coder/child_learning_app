// lib/config/app_config.dart
class AppConfig {
  // App Information
  static const String appName = 'Kids Learning Hub';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';

  // Developer Information
  static const String developerName = 'Your Name';
  static const String developerEmail = 'your.email@example.com';
  static const String supportEmail = 'support@kidslearninghub.com';

  // API Configuration (for future use)
  static const String baseUrl = 'https://api.kidslearninghub.com';
  static const String apiVersion = 'v1';
  static const Duration apiTimeout = Duration(seconds: 30);

  // Features Flags
  static const bool enableAudio = true;
  static const bool enableAnimations = true;
  static const bool enableAnalytics = false;
  static const bool enableCrashReporting = false;

  // Lesson Configuration
  static const int maxLessonsPerCategory = 15;
  static const int defaultLessonDuration = 300; // 5 minutes
  static const int autoSaveInterval = 30; // seconds

  // UI Configuration
  static const Duration splashDuration = Duration(seconds: 3);
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const int maxRecentLessons = 5;

  // Storage Configuration
  static const String storagePrefix = 'kids_learning_';
  static const int maxCacheSize = 100; // MB

  // Debugging
  static const bool isDebugMode = true;
  static const bool showDebugBanner = false;
  static const bool enableLogging = true;

  // Privacy & Security
  static const bool requireParentConsent = false;
  static const int minUserAge = 3;
  static const int maxUserAge = 8;

  // Social Links (for future use)
  static const String websiteUrl = 'https://kidslearninghub.com';
  static const String facebookUrl = 'https://facebook.com/kidslearninghub';
  static const String instagramUrl = 'https://instagram.com/kidslearninghub';

  // App Store Links
  static const String playStoreUrl = 'https://play.google.com/store/apps/details?id=com.yourcompany.kidslearninghub';
  static const String appStoreUrl = 'https://apps.apple.com/app/kids-learning-hub/id123456789';

  // Privacy Policy & Terms
  static const String privacyPolicyUrl = 'https://kidslearninghub.com/privacy';
  static const String termsOfServiceUrl = 'https://kidslearninghub.com/terms';

  /// Get full API URL
  static String getApiUrl(String endpoint) {
    return '$baseUrl/$apiVersion/$endpoint';
  }

  /// Check if feature is enabled
  static bool isFeatureEnabled(String feature) {
    switch (feature) {
      case 'audio':
        return enableAudio;
      case 'animations':
        return enableAnimations;
      case 'analytics':
        return enableAnalytics;
      case 'crash_reporting':
        return enableCrashReporting;
      default:
        return false;
    }
  }
}