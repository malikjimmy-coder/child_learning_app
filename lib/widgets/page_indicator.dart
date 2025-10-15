// lib/widgets/page_indicator.dart
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Color activeColor;
  final Color inactiveColor;
  final double dotSize;
  final double spacing;
  final int maxDotsToShow;

  const PageIndicator({
    Key? key,
    required this.currentPage,
    required this.totalPages,
    this.activeColor = AppColors.primaryBlue,
    this.inactiveColor = AppColors.textLight,
    this.dotSize = 8.0,
    this.spacing = 4.0,
    this.maxDotsToShow = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dotsToShow = totalPages > maxDotsToShow ? maxDotsToShow : totalPages;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        dotsToShow,
            (index) {
          final bool isActive = index == currentPage;
          return Container(
            margin: EdgeInsets.symmetric(horizontal: spacing),
            width: isActive ? dotSize : dotSize * 0.75,
            height: isActive ? dotSize : dotSize * 0.75,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? activeColor
                  : inactiveColor.withOpacity(0.3),
            ),
          );
        },
      ),
    );
  }
}

/// Linear Page Indicator (Progress Bar)
class LinearPageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Color activeColor;
  final Color inactiveColor;
  final double height;

  const LinearPageIndicator({
    Key? key,
    required this.currentPage,
    required this.totalPages,
    this.activeColor = AppColors.primaryBlue,
    this.inactiveColor = AppColors.divider,
    this.height = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = totalPages > 0 ? (currentPage + 1) / totalPages : 0.0;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: inactiveColor,
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            color: activeColor,
            borderRadius: BorderRadius.circular(height / 2),
          ),
        ),
      ),
    );
  }
}