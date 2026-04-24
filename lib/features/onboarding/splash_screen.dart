import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) context.go('/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.1),
                boxShadow: [
                  BoxShadow(color: AppColors.primary.withValues(alpha: 0.2), blurRadius: 40, spreadRadius: 10),
                ],
              ),
              child: const Center(
                child: Icon(Icons.public_rounded, size: 64, color: AppColors.primary),
              ),
            ).animate().scale(duration: 800.ms, curve: Curves.easeOutBack).fadeIn(),
            const SizedBox(height: 24),
            Text(
              'JOJ AFRIQUE',
              style: AppTextStyles.h1.copyWith(letterSpacing: 2),
            ).animate().slideY(begin: 0.5, end: 0, duration: 600.ms, delay: 200.ms).fadeIn(),
            const SizedBox(height: 8),
            Text(
              'La Super-App Olympique',
              style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
            ).animate().slideY(begin: 0.5, end: 0, duration: 600.ms, delay: 400.ms).fadeIn(),
          ],
        ),
      ),
    );
  }
}
