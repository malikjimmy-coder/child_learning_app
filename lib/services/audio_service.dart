// lib/services/audio_service.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/widgets.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _backgroundMusicPlayer = AudioPlayer(); // 👈 Background music player
  final FlutterTts _flutterTts = FlutterTts();

  bool _isPlaying = false;
  bool _isSpeaking = false;
  bool _isMusicPlaying = false;
  bool _isMusicInitialized = false;
  String? _currentAudioPath;
  String? _currentMusicPath;

  /// Get audio player instance
  AudioPlayer get player => _audioPlayer;

  /// Check if audio is playing
  bool get isPlaying => _isPlaying || _isSpeaking;

  /// Check if background music is playing
  bool get isMusicPlaying => _isMusicPlaying;

  /// Check if background music is initialized
  bool get isMusicInitialized => _isMusicInitialized;

  /// Get current audio path
  String? get currentAudioPath => _currentAudioPath;

  /// Initialize audio service
  Future<void> init() async {
    // Setup Audio Player
    _audioPlayer.onPlayerStateChanged.listen((state) {
      _isPlaying = state == PlayerState.playing;
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      _isPlaying = false;
      _currentAudioPath = null;
    });

    // Setup Background Music Player
    _backgroundMusicPlayer.onPlayerStateChanged.listen((state) {
      _isMusicPlaying = state == PlayerState.playing;
    });

    // Setup TTS
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);

    _flutterTts.setStartHandler(() {
      _isSpeaking = true;
    });

    _flutterTts.setCompletionHandler(() {
      _isSpeaking = false;
    });

    _flutterTts.setErrorHandler((msg) {
      print("TTS Error: $msg");
      _isSpeaking = false;
    });
  }

  /// Play background music (loops continuously)
  Future<void> playBackgroundMusic({
    String assetPath = 'audio/background_music.mp3',
    double volume = 0.3, // Lower volume so it doesn't overpower TTS
  }) async {
    try {
      // Check if same music is already playing
      if (_isMusicPlaying && _currentMusicPath == assetPath) {
        print('🎵 Background music already playing: $assetPath');
        return;
      }

      // Stop current music if different
      if (_isMusicPlaying && _currentMusicPath != assetPath) {
        await stopBackgroundMusic();
      }

      // Only start if not already playing
      if (!_isMusicPlaying) {
        await _backgroundMusicPlayer.setVolume(volume);
        await _backgroundMusicPlayer.setReleaseMode(ReleaseMode.loop);
        await _backgroundMusicPlayer.play(AssetSource(assetPath));
        _isMusicPlaying = true;
        _currentMusicPath = assetPath;
        _isMusicInitialized = true;
        print('✅ Background music started: $assetPath');
      }
    } catch (e) {
      print('❌ Error playing background music: $e');
      _isMusicPlaying = false;
      _currentMusicPath = null;
    }
  }

  /// Stop background music
  Future<void> stopBackgroundMusic() async {
    if (_isMusicPlaying) {
      await _backgroundMusicPlayer.stop();
      _isMusicPlaying = false;
      _currentMusicPath = null;
      print('⏹️ Background music stopped');
    }
  }

  /// Pause background music
  Future<void> pauseBackgroundMusic() async {
    if (_isMusicPlaying) {
      await _backgroundMusicPlayer.pause();
      _isMusicPlaying = false;
      print('⏸️ Background music paused');
    }
  }

  /// Resume background music
  Future<void> resumeBackgroundMusic() async {
    if (_isMusicInitialized && !_isMusicPlaying) {
      await _backgroundMusicPlayer.resume();
      _isMusicPlaying = true;
      print('▶️ Background music resumed');
    }
  }

  /// Set background music volume
  Future<void> setBackgroundMusicVolume(double volume) async {
    await _backgroundMusicPlayer.setVolume(volume.clamp(0.0, 1.0));
  }

  /// Speak text using TTS
  Future<void> speak(String text) async {
    try {
      print('Speaking: $text');
      // Don't stop background music, just speak over it
      _isSpeaking = true;
      await _flutterTts.speak(text);
    } catch (e) {
      print('Error speaking: $e');
      _isSpeaking = false;
    }
  }

  /// Stop TTS
  Future<void> stopSpeaking() async {
    await _flutterTts.stop();
    _isSpeaking = false;
  }

  /// Play audio from asset
  Future<void> playFromAsset(String assetPath) async {
    try {
      if (_isPlaying && _currentAudioPath == assetPath) {
        await stop();
        return;
      }

      await stop(); // Stop current audio (but NOT background music)
      _currentAudioPath = assetPath;
      await _audioPlayer.play(AssetSource(assetPath));
      _isPlaying = true;
    } catch (e) {
      print('Error playing audio: $e');
      _isPlaying = false;
    }
  }

  /// Play audio from URL
  Future<void> playFromUrl(String url) async {
    try {
      if (_isPlaying && _currentAudioPath == url) {
        await stop();
        return;
      }

      await stop();
      _currentAudioPath = url;
      await _audioPlayer.play(UrlSource(url));
      _isPlaying = true;
    } catch (e) {
      print('Error playing audio from URL: $e');
      _isPlaying = false;
    }
  }

  /// Pause audio
  Future<void> pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
  }

  /// Resume audio
  Future<void> resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
  }

  /// Stop audio (but NOT background music)
  Future<void> stop() async {
    await _audioPlayer.stop();
    _isPlaying = false;
    _currentAudioPath = null;
  }

  /// Set volume (0.0 to 1.0)
  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume.clamp(0.0, 1.0));
  }

  /// Set TTS speech rate
  Future<void> setSpeechRate(double rate) async {
    await _flutterTts.setSpeechRate(rate.clamp(0.0, 1.0));
  }

  /// Seek to position
  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  /// Get duration
  Future<Duration?> getDuration() async {
    return await _audioPlayer.getDuration();
  }

  /// Get current position
  Future<Duration?> getCurrentPosition() async {
    return await _audioPlayer.getCurrentPosition();
  }

  /// Stop all audio (including background music)
  Future<void> stopAll() async {
    await stop();
    await stopSpeaking();
    await stopBackgroundMusic();
  }

  /// Stop only foreground audio (NOT background music)
  Future<void> stopForeground() async {
    await stop();
    await stopSpeaking();
  }

  /// Handle app lifecycle changes
  Future<void> handleAppLifecycleChange(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        // Pause background music when app goes to background or is hidden
        await pauseBackgroundMusic();
        break;
      case AppLifecycleState.resumed:
        // Resume background music when app comes to foreground
        await resumeBackgroundMusic();
        break;
      case AppLifecycleState.detached:
        // Stop all audio when app is detached
        await stopAll();
        break;
    }
  }

  /// Reset music state (useful for development/hot reload)
  void resetMusicState() {
    _isMusicInitialized = false;
    _isMusicPlaying = false;
    _currentMusicPath = null;
    print('🔄 Music state reset');
  }

  /// Dispose audio players and TTS
  Future<void> dispose() async {
    await _audioPlayer.dispose();
    await _backgroundMusicPlayer.dispose();
    await _flutterTts.stop();
    _isMusicInitialized = false;
    _isMusicPlaying = false;
    _currentMusicPath = null;
  }
}