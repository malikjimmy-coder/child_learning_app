// lib/widgets/audio_player_button.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../services/audio_service.dart';
import '../utils/constants.dart';

class AudioPlayerButton extends StatefulWidget {
  final String audioPath;
  final String textToSpeak;
  final Color categoryColor;

  const AudioPlayerButton({
    Key? key,
    required this.audioPath,
    required this.textToSpeak,
    required this.categoryColor,
  }) : super(key: key);

  @override
  State<AudioPlayerButton> createState() => _AudioPlayerButtonState();
}

class _AudioPlayerButtonState extends State<AudioPlayerButton> {
  final AudioService _audioService = AudioService();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    // Listen to both audio player and TTS state changes
    _audioService.player.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing || _audioService.isPlaying;
        });
      }
    });

    // Periodic check for TTS state
    _checkPlayingState();
  }

  void _checkPlayingState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _isPlaying = _audioService.isPlaying;
        });
        _checkPlayingState();
      }
    });
  }

  Future<void> _playAudio() async {
    try {
      print('Audio button clicked. Current state: $_isPlaying');
      print('Text to speak: ${widget.textToSpeak}');

      if (_isPlaying) {
        print('Stopping audio...');
        await _audioService.stopForeground(); // 👈 CHANGED: stopAll() → stopForeground()
      } else {
        // Show visual feedback first
        print('Speaking: ${widget.textToSpeak}');
        _showPronunciationFeedback(widget.textToSpeak);

        // Then speak the text using TTS
        await _audioService.speak(widget.textToSpeak);
      }
    } catch (e) {
      print('Error playing audio: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to play audio'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _showPronunciationFeedback(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.record_voice_over_rounded,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(
              'Say "$text" out loud!',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: widget.categoryColor,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(20),
      ),
    );

    // Also show a brief visual feedback on the button
    setState(() {
      _isPlaying = true;
    });

    // Reset button state after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _playAudio,
      backgroundColor: widget.categoryColor,
      elevation: AppDimensions.elevationMedium,
      child: Icon(
        _isPlaying ? Icons.stop_rounded : Icons.record_voice_over_rounded,
        color: Colors.white,
        size: 28,
      ),
    );
  }

  @override
  void dispose() {
    _audioService.stopForeground(); // 👈 CHANGED: stopAll() → stopForeground()
    super.dispose();
  }
}