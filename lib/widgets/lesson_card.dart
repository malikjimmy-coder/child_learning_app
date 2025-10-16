// lib/widgets/lesson_card.dart
import 'package:flutter/material.dart';
import '../models/lesson.dart';
import '../utils/constants.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback onTap;

  const LessonCard({
    Key? key,
    required this.lesson,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isEnglish = lesson.category == 'English';
    final Color categoryColor = isEnglish
        ? AppColors.englishPrimary
        : AppColors.mathPrimary;

    return Container(
      margin: const EdgeInsets.only(
        bottom: AppDimensions.marginMedium,
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        elevation: AppDimensions.elevationMedium,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          onTap: onTap,
          child: Container(
            height: AppDimensions.lessonCardHeight,
            padding: const EdgeInsets.all(AppDimensions.paddingSmall),
            child: Row(
              children: [
                // Lesson Icon
                Container(
                  width: AppDimensions.lessonIconSize,
                  height: AppDimensions.lessonIconSize,
                  decoration: BoxDecoration(
                    color: categoryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: lesson.iconPath.isNotEmpty
                        ? Image.asset(
                      lesson.iconPath,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          isEnglish
                              ? Icons.book_rounded
                              : Icons.calculate_rounded,
                          size: 40,
                          color: categoryColor,
                        );
                      },
                    )
                        : Icon(
                      isEnglish
                          ? Icons.book_rounded
                          : Icons.calculate_rounded,
                      size: 40,
                      color: categoryColor,
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Lesson Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Lesson Number
                      Text(
                        'Lesson ${lesson.lessonNumber}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: categoryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 2),

                      // Lesson Title
                      Text(
                        lesson.title,
                        style: AppTextStyles.heading3.copyWith(
                          fontSize: 18,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 4),

                      // Lesson Subtitle
                      Text(
                        lesson.subtitle,
                        style: AppTextStyles.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Status Indicator
                _buildStatusIndicator(lesson),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(Lesson lesson) {
    if (lesson.isCompleted) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.successGreen.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check_circle_rounded,
          color: AppColors.successGreen,
          size: 24,
        ),
      );
    } else if (lesson.lastViewedPage > 0) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.warningOrange.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.access_time_rounded,
          color: AppColors.warningOrange,
          size: 24,
        ),
      );
    } else {
      return const Icon(
        Icons.arrow_forward_ios_rounded,
        color: AppColors.textLight,
        size: 20,
      );
    }
  }
}