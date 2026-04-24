import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/widgets/app_button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Decorative background element
          Positioned(
            top: -100, right: -100,
            child: Container(
              width: 300, height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [AppColors.primary.withValues(alpha: 0.2), Colors.transparent]),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text('Bienvenue ! 👋', style: AppTextStyles.h1).animate().fadeIn().slideY(begin: 0.3, end: 0),
                  const SizedBox(height: 8),
                  Text('Connectez-vous pour sauvegarder votre progression.', style: AppTextStyles.bodyMedium).animate().fadeIn(delay: 100.ms),
                  const SizedBox(height: 48),
                  TextField(
                    decoration: const InputDecoration(hintText: 'Adresse email', prefixIcon: Icon(Icons.email_outlined)),
                    style: AppTextStyles.bodyLarge,
                  ).animate().fadeIn(delay: 200.ms),
                  const SizedBox(height: 16),
                  TextField(
                    obscureText: true,
                    decoration: const InputDecoration(hintText: 'Mot de passe', prefixIcon: Icon(Icons.lock_outline_rounded)),
                    style: AppTextStyles.bodyLarge,
                  ).animate().fadeIn(delay: 300.ms),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      text: 'Connexion',
                      onPressed: () => context.go('/home'),
                    ),
                  ).animate().fadeIn(delay: 400.ms),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () => context.go('/home'),
                      child: Text('Continuer en visiteur', style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary)),
                    ),
                  ).animate().fadeIn(delay: 500.ms),
                  const Spacer(),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Pas de compte ? ', style: AppTextStyles.bodyMedium),
                        Text(
                          'Créer un compte',
                          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
