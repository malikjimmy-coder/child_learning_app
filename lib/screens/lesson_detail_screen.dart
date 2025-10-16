// lib/screens/lesson_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lesson.dart';
import '../providers/progress_provider.dart';
import '../providers/lesson_provider.dart';
import '../widgets/lesson_page_widget.dart';
import '../utils/constants.dart';

class LessonDetailScreen extends StatefulWidget {
  final Lesson lesson;

  const LessonDetailScreen({
    Key? key,
    required this.lesson,
  }) : super(key: key);

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.lesson.lastViewedPage;
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });

    // Save progress
    context.read<ProgressProvider>().updateLessonProgress(
          widget.lesson.id,
          page,
          false, // Not completed yet
        );
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: AppAnimations.normal,
        curve: AppAnimations.defaultCurve,
      );
    }
  }

  void _goToNextPage() {
    if (_currentPage < widget.lesson.pages.length - 1) {
      _pageController.nextPage(
        duration: AppAnimations.normal,
        curve: AppAnimations.defaultCurve,
      );
    } else {
      // Last page - complete the lesson
      _completeLesson();
    }
  }

  Future<void> _completeLesson() async {
    // Mark lesson as completed in progress provider
    await context.read<ProgressProvider>().completeLesson(widget.lesson.id);

    // Update lesson completion in lesson provider (this will unlock next lesson)
    context.read<LessonProvider>().updateLessonCompletion(
          widget.lesson.id,
          true,
        );

    if (mounted) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  '🎉 Lesson Completed! Next lesson unlocked!',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.successGreen,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Wait a bit before going back
      await Future.delayed(const Duration(milliseconds: 500));

      // Go back to lessons list
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEnglish =
        widget.lesson.category == AppConstants.categoryEnglish;
    final Color categoryColor =
        isEnglish ? AppColors.englishPrimary : AppColors.mathPrimary;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Column(
        children: [
          // Top Navigation Bar
          Container(
            color: Colors.white,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingSmall,
                  vertical: AppDimensions.paddingSmall,
                ),
                child: Row(
                  children: [
                    // Back Button
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                      onPressed: () => Navigator.pop(context),
                    ),

                    // Lesson Title
                    Expanded(
                      child: Text(
                        'Lesson ${widget.lesson.lessonNumber}: ${widget.lesson.title}',
                        style: AppTextStyles.heading3.copyWith(fontSize: 16),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // Home Button
                    IconButton(
                      icon: const Icon(Icons.home_rounded),
                      onPressed: () {
                        Navigator.popUntil(
                          context,
                          (route) => route.isFirst,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Main Content - PageView
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: widget.lesson.pages.length,
              itemBuilder: (context, index) {
                return LessonPageWidget(
                  page: widget.lesson.pages[index],
                  categoryColor: categoryColor,
                );
              },
            ),
          ),

          // Bottom Navigation
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingSmall,
              vertical: AppDimensions.paddingMedium,
            ),
            child: SafeArea(
              top: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Previous Button
                  _NavigationButton(
                    icon: Icons.arrow_back_ios_rounded,
                    label: AppStrings.previousButton,
                    isEnabled: _currentPage > 0,
                    onPressed: _goToPreviousPage,
                  ),

                  // Page Indicator
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${_currentPage + 1} / ${widget.lesson.pages.length}',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildPageIndicatorDots(),
                    ],
                  ),

                  // Next Button
                  _NavigationButton(
                    icon: _currentPage == widget.lesson.pages.length - 1
                        ? Icons.check_circle_rounded
                        : Icons.arrow_forward_ios_rounded,
                    label: _currentPage == widget.lesson.pages.length - 1
                        ? AppStrings.completeButton
                        : AppStrings.nextButton,
                    isEnabled: true,
                    onPressed: _goToNextPage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicatorDots() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        widget.lesson.pages.length > 6 ? 6 : widget.lesson.pages.length,
        (index) {
          final bool isActive = index == _currentPage;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            width: isActive ? 8 : 6,
            height: isActive ? 8 : 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? (widget.lesson.category == AppConstants.categoryEnglish
                      ? AppColors.englishPrimary
                      : AppColors.mathPrimary)
                  : AppColors.textLight.withOpacity(0.3),
            ),
          );
        },
      ),
    );
  }
}

// Navigation Button Widget
class _NavigationButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isEnabled;
  final VoidCallback onPressed;

  const _NavigationButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.isEnabled,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isEnabled ? onPressed : null,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isEnabled ? AppColors.primaryBlue : AppColors.textLight,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        elevation: isEnabled ? AppDimensions.elevationMedium : 0,
      ),
    );
  }
}
