// providers/app_state_provider.dart
import 'package:flutter/foundation.dart';

class AppStateProvider with ChangeNotifier {
  bool _isMusicEnabled = true;
  bool _isSoundEffectsEnabled = true;
  String _selectedLanguage = 'English'; // 'English' or 'Urdu'
  String _themMode = 'light'; // 'light' or 'dark'

  bool get isMusicEnabled => _isMusicEnabled;
  bool get isSoundEffectsEnabled => _isSoundEffectsEnabled;
  String get selectedLanguage => _selectedLanguage;
  String get themeMode => _themMode;

  // Toggle background music
  void toggleMusic() {
    _isMusicEnabled = !_isMusicEnabled;
    notifyListeners();
  }

  // Toggle sound effects
  void toggleSoundEffects() {
    _isSoundEffectsEnabled = !_isSoundEffectsEnabled;
    notifyListeners();
  }

  // Set music state
  void setMusicEnabled(bool enabled) {
    _isMusicEnabled = enabled;
    notifyListeners();
  }

  // Set sound effects state
  void setSoundEffectsEnabled(bool enabled) {
    _isSoundEffectsEnabled = enabled;
    notifyListeners();
  }

  // Change language
  void setLanguage(String language) {
    if (language == 'English' || language == 'Urdu') {
      _selectedLanguage = language;
      notifyListeners();
    }
  }

  // Change theme
  void setThemeMode(String mode) {
    if (mode == 'light' || mode == 'dark') {
      _themMode = mode;
      notifyListeners();
    }
  }
}