import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'screens/splash_screen.dart';
import 'providers/lesson_provider.dart';
import 'providers/progress_provider.dart';
import 'providers/app_state_provider.dart';
import 'services/storage_service.dart';
import 'services/audio_service.dart';
import 'services/navigation_service.dart';
import 'utils/theme.dart';
import 'utils/routes.dart';
import 'config/app_config.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  await _initializeServices();

  // Set system UI overlays
  _configureSystemUI();

  // Run the app
  runApp(const MyApp());
}

/// Initialize all required services
Future<void> _initializeServices() async {
  try {
    // Initialize storage service
    await StorageService.init();
    print('✅ Storage Service initialized');

    // Initialize audio service
    await AudioService().init();
    print('✅ Audio Service initialized');

    print('✅ All services initialized successfully');
  } catch (e) {
    print('❌ Error initializing services: $e');
  }
}

/// Configure system UI (status bar, navigation bar)
void _configureSystemUI() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Set preferred orientations (portrait only)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Lesson Provider
        ChangeNotifierProvider(
          create: (_) => LessonProvider(),
        ),

        // Progress Provider (load saved progress on start)
        ChangeNotifierProvider(
          create: (_) => ProgressProvider()..loadProgress(),
        ),

        // App State Provider
        ChangeNotifierProvider(
          create: (_) => AppStateProvider(),
        ),
      ],
      child: MaterialApp(
        // App Configuration
        title: AppConfig.appName,
        debugShowCheckedModeBanner: AppConfig.showDebugBanner,

        // Theme
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,

        // Navigation
        navigatorKey: NavigationService.navigatorKey,
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: AppRoutes.splash,

        // Home
        home: const SplashScreen(),

        // Builder for global error handling
        builder: (context, child) {
          // Handle text scale factor
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0, // Prevent text scaling
            ),
            child: child!,
          );
        },
      ),
    );
  }
}