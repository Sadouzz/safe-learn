import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class ProgressRing extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final double size;
  final Color activeColor;
  final Color backgroundColor;
  final double strokeWidth;

  const ProgressRing({
    super.key,
    required this.progress,
    this.size = 64,
    this.activeColor = AppColors.primary,
    this.backgroundColor = AppColors.surfaceAlt,
    this.strokeWidth = 6,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: progress),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeOutCubic,
        builder: (context, value, _) {
          return CircularProgressIndicator(
            value: value,
            strokeWidth: strokeWidth,
            backgroundColor: backgroundColor,
            valueColor: AlwaysStoppedAnimation<Color>(activeColor),
            strokeCap: StrokeCap.round,
          );
        },
      ),
    );
  }
}
