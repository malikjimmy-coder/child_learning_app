// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/routes.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                // Header Section
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Welcome Message
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
                      // English Button
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

                      // Math Button
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
                      // Decorative Image
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

                      // Version Number
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