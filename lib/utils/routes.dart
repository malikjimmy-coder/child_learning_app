// lib/utils/routes.dart
import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/lessons_list_screen.dart';
import '../screens/lesson_detail_screen.dart';
import '../models/lesson.dart';

class AppRoutes {
  // Route Names
  static const String splash = '/';
  static const String home = '/home';
  static const String lessonsList = '/lessons-list';
  static const String lessonDetail = '/lesson-detail';

  // Prevent instantiation
  AppRoutes._();

  /// Generate routes
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRoute(const SplashScreen(), settings);

      case home:
        return _buildRoute(const HomeScreen(), settings);

      case lessonsList:
        final args = settings.arguments as Map<String, dynamic>?;
        if (args == null || !args.containsKey('category')) {
          return _errorRoute('Missing category argument');
        }
        return _buildRoute(
          LessonsListScreen(category: args['category'] as String),
          settings,
        );

      case lessonDetail:
        final lesson = settings.arguments as Lesson?;
        if (lesson == null) {
          return _errorRoute('Missing lesson argument');
        }
        return _buildRoute(
          LessonDetailScreen(lesson: lesson),
          settings,
        );

      default:
        return _errorRoute('No route defined for ${settings.name}');
    }
  }

  /// Build route with animation
  static MaterialPageRoute _buildRoute(Widget page, RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => page,
      settings: settings,
    );
  }

  /// Build route with custom animation (optional)
  static PageRouteBuilder _buildAnimatedRoute(
      Widget page,
      RouteSettings settings,
      ) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  /// Error route
  static MaterialPageRoute _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text(
            message,
            style: const TextStyle(fontSize: 18, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}