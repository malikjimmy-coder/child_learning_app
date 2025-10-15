// lib/services/audio_service.dart
import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String? _currentAudioPath;

  /// Get audio player instance
  AudioPlayer get player => _audioPlayer;

  /// Check if audio is playing
  bool get isPlaying => _isPlaying;

  /// Get current audio path
  String? get currentAudioPath => _currentAudioPath;

  /// Initialize audio service
  Future<void> init() async {
    // Listen to player state changes
    _audioPlayer.onPlayerStateChanged.listen((state) {
      _isPlaying = state == PlayerState.playing;
    });

    // Listen to player completion
    _audioPlayer.onPlayerComplete.listen((_) {
      _isPlaying = false;
      _currentAudioPath = null;
    });
  }

  /// Play audio from asset
  Future<void> playFromAsset(String assetPath) async {
    try {
      if (_isPlaying && _currentAudioPath == assetPath) {
        await stop();
        return;
      }

      await stop(); // Stop any currently playing audio
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

  /// Stop audio
  Future<void> stop() async {
    await _audioPlayer.stop();
    _isPlaying = false;
    _currentAudioPath = null;
  }

  /// Set volume (0.0 to 1.0)
  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume.clamp(0.0, 1.0));
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

  /// Dispose audio player
  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}