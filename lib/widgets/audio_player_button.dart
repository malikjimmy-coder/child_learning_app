// lib/widgets/audio_player_button.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../services/audio_service.dart';
import '../utils/constants.dart';

class AudioPlayerButton extends StatefulWidget {
  final String audioPath;
  final Color categoryColor;

  const AudioPlayerButton({
    Key? key,
    required this.audioPath,
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
    _audioService.player.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      }
    });
  }

  Future<void> _playAudio() async {
    try {
      if (_isPlaying) {
        await _audioService.stop();
      } else {
        await _audioService.playFromAsset(widget.audioPath);
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

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _playAudio,
      backgroundColor: widget.categoryColor,
      elevation: AppDimensions.elevationMedium,
      child: Icon(
        _isPlaying ? Icons.stop_rounded : Icons.volume_up_rounded,
        color: Colors.white,
        size: 28,
      ),
    );
  }

  @override
  void dispose() {
    _audioService.stop();
    super.dispose();
  }
}