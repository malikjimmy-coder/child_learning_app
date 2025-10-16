// lib/widgets/lesson_page_widget.dart
import 'package:flutter/material.dart';
import '../models/lesson_page.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import 'audio_player_button.dart';

class LessonPageWidget extends StatelessWidget {
  final LessonPage page;
  final Color categoryColor;

  const LessonPageWidget({
    Key? key,
    required this.page,
    required this.categoryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          minHeight: screenHeight - 200,
        ),
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image Section
            Container(
              constraints: BoxConstraints(
                maxHeight: screenHeight * 0.4,
                maxWidth: double.infinity,
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(AppDimensions.radiusLarge,),
                border: Border.all(color: Colors.grey.withOpacity(0.4),width: 1),
                boxShadow: [
                  BoxShadow(
                    color: categoryColor.withOpacity(0.0),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(AppDimensions.paddingSmall),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                child: Image.asset(
                  page.imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: AppColors.cardBackground,
                      child: const Icon(
                        Icons.image_not_supported_rounded,
                        size: 80,
                        color: AppColors.textLight,
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Text Content Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppDimensions.paddingLarge),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                border: Border.all(color: Colors.grey.withOpacity(0.4),width: 1),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Primary Text (Letter/Number)
                  Text(
                    page.primaryText,
                    style: AppTextStyles.lessonPrimary.copyWith(
                      color: categoryColor,
                      fontSize: 64,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Secondary Text (Word/Name)
                  Text(
                    page.secondaryText,
                    style: AppTextStyles.lessonSecondary.copyWith(
                      fontSize: 28,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  // Description (if available)
                  if (page.description != null && page.description!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        page.description!,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  // Audio Button (always show for pronunciation)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: AudioPlayerButton(
                      audioPath: page.audioPath ?? '',
                      textToSpeak: page.title.contains('for')
                          ? page.title
                          : '${page.primaryText} for ${page.secondaryText}',
                      categoryColor: categoryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (page.backgroundColor != null && page.backgroundColor!.isNotEmpty) {
      return Helpers.parseColor(page.backgroundColor!);
    }
    return categoryColor.withOpacity(0.5);
  }
}
