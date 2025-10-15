// lib/screens/lessons_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/lesson_provider.dart';
import '../widgets/lesson_card.dart';
import '../utils/constants.dart';
import '../utils/routes.dart';

class LessonsListScreen extends StatefulWidget {
  final String category; // 'English' or 'Math'

  const LessonsListScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<LessonsListScreen> createState() => _LessonsListScreenState();
}

class _LessonsListScreenState extends State<LessonsListScreen> {
  @override
  void initState() {
    super.initState();
    // Load lessons when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LessonProvider>().loadLessons(widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    final lessonProvider = context.watch<LessonProvider>();
    final lessons = lessonProvider.getLessonsByCategory(widget.category);

    final bool isEnglish = widget.category == AppConstants.categoryEnglish;
    final gradient = isEnglish
        ? AppGradients.englishGradient
        : AppGradients.mathGradient;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.backgroundGradient,
        ),
        child: Column(
          children: [
            // Custom App Bar
            Container(
              decoration: BoxDecoration(
                gradient: gradient,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingMedium,
                    vertical: AppDimensions.paddingSmall,
                  ),
                  child: Row(
                    children: [
                      // Back Button
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),

                      // Title
                      Expanded(
                        child: Text(
                          '${widget.category} ${AppStrings.englishLessonsTitle.split(' ').last}',
                          style: AppTextStyles.heading2.copyWith(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      // Home Button
                      IconButton(
                        icon: const Icon(
                          Icons.home_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.popUntil(
                            context,
                            ModalRoute.withName(AppRoutes.home),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Lessons List
            Expanded(
              child: lessonProvider.isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : lessons.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.school_outlined,
                      size: 80,
                      color: AppColors.textLight,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppStrings.noLessons,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.all(
                  AppDimensions.paddingMedium,
                ),
                itemCount: lessons.length,
                itemBuilder: (context, index) {
                  final lesson = lessons[index];
                  return LessonCard(
                    lesson: lesson,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.lessonDetail,
                        arguments: lesson,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}