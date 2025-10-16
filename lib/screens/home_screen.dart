// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/routes.dart';
import '../widgets/custom_button.dart';
import '../services/audio_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isMusicPlaying = true;
  double _musicVolume = 0.3; // Default 30%

  @override
  void initState() {
    super.initState();
    _isMusicPlaying = AudioService().isMusicPlaying;
  }

  void _toggleMusic() async {
    setState(() {
      _isMusicPlaying = !_isMusicPlaying;
    });

    if (_isMusicPlaying) {
      await AudioService().resumeBackgroundMusic();
      print('🎵 Music resumed');
    } else {
      await AudioService().pauseBackgroundMusic();
      print('⏸️ Music paused');
    }
  }

  void _changeVolume(double volume) async {
    setState(() {
      _musicVolume = volume;
    });
    await AudioService().setBackgroundMusicVolume(volume);
    print('🔊 Volume changed to: ${(volume * 100).toInt()}%');
  }

  void _showVolumeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Music Volume'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.volume_down),
                Expanded(
                  child: Slider(
                    value: _musicVolume,
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                    label: '${(_musicVolume * 100).toInt()}%',
                    onChanged: (value) {
                      setState(() {
                        _musicVolume = value;
                      });
                      AudioService().setBackgroundMusicVolume(value);
                    },
                  ),
                ),
                const Icon(Icons.volume_up),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Volume: ${(_musicVolume * 100).toInt()}%',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.backgroundGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: Column(
              children: [
                // Music Controls (Top Right)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Volume Button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          _musicVolume > 0.5
                              ? Icons.volume_up_rounded
                              : _musicVolume > 0
                              ? Icons.volume_down_rounded
                              : Icons.volume_off_rounded,
                          color: AppColors.primaryBlue,
                          size: 28,
                        ),
                        onPressed: _showVolumeDialog,
                        tooltip: 'Volume Control',
                      ),
                    ),

                    const SizedBox(width: 10),

                    // Play/Pause Button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          _isMusicPlaying
                              ? Icons.music_note_rounded
                              : Icons.music_off_rounded,
                          color: _isMusicPlaying
                              ? AppColors.primaryBlue
                              : AppColors.textLight,
                          size: 28,
                        ),
                        onPressed: _toggleMusic,
                        tooltip: _isMusicPlaying
                            ? 'Pause Music'
                            : 'Play Music',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Header Section
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.homeWelcome,
                        style: AppTextStyles.heading1,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        AppStrings.homeQuestion,
                        style: AppTextStyles.heading3.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        AppStrings.homeSubtitle,
                        style: AppTextStyles.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // Subject Selection Buttons
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SubjectButton(
                        title: AppStrings.englishTitle,
                        subtitle: AppStrings.englishSubtitle,
                        icon: Icons.book_rounded,
                        gradient: AppGradients.englishGradient,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.lessonsList,
                            arguments: {'category': AppConstants.categoryEnglish},
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      SubjectButton(
                        title: AppStrings.mathTitle,
                        subtitle: AppStrings.mathSubtitle,
                        icon: Icons.calculate_rounded,
                        gradient: AppGradients.mathGradient,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.lessonsList,
                            arguments: {'category': AppConstants.categoryMath},
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Footer Section
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        AppAssets.homeIllustration,
                        height: 120,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.child_care_rounded,
                            size: 80,
                            color: AppColors.accentOrange,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '${AppStrings.version} ${AppConstants.appVersion}',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}