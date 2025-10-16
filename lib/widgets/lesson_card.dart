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
        color: lesson.isLocked
            ? AppColors.cardBackground.withOpacity(0.5) // Dim locked lessons
            : Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        elevation: lesson.isLocked ? 0 : AppDimensions.elevationMedium,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          onTap: lesson.isLocked ? null : onTap, // Disable tap if locked
          child: Opacity(
            opacity: lesson.isLocked ? 0.5 : 1.0, // Reduce opacity for locked lessons
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
                      color: categoryColor.withOpacity(lesson.isLocked ? 0.3 : 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: lesson.isLocked
                          ? Icon(
                        Icons.lock_rounded,
                        size: 40,
                        color: categoryColor.withOpacity(0.5),
                      )
                          : (lesson.iconPath.isNotEmpty
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
                      )),
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
                        Row(
                          children: [
                            Text(
                              'Lesson ${lesson.lessonNumber}',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: categoryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (lesson.isLocked) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.textLight.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  'LOCKED',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textLight,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),

                        const SizedBox(height: 4),

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

                        // Lesson Subtitle or Lock Message
                        Text(
                          lesson.isLocked
                              ? 'Complete previous lesson to unlock'
                              : lesson.subtitle,
                          style: AppTextStyles.bodySmall.copyWith(
                            fontStyle: lesson.isLocked ? FontStyle.italic : FontStyle.normal,
                          ),
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
      ),
    );
  }

  Widget _buildStatusIndicator(Lesson lesson) {
    if (lesson.isLocked) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.textLight.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.lock_rounded,
          color: AppColors.textLight,
          size: 24,
        ),
      );
    } else if (lesson.isCompleted) {
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