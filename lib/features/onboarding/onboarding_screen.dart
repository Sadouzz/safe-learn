import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_card.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: [
                  _buildSlide(
                    icon: Icons.sports_gymnastics_rounded,
                    title: 'Découvrez les Sports',
                    subtitle: 'Participez à des quiz éducatifs sur les disciplines olympiques et gagnez de l\'XP.',
                  ),
                  _buildSlide(
                    icon: Icons.eco_rounded,
                    title: 'Impact Écologique',
                    subtitle: 'Complétez des missions vertes sur le terrain et contribuez au compteur global.',
                    color: AppColors.secondary,
                  ),
                  _buildProfileSelection(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index ? AppColors.primary : AppColors.surfaceAlt,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 32),
                  if (_currentPage == 2)
                    AppButton(
                      text: 'Commencer',
                      onPressed: () => context.go('/auth'),
                    ).animate().fadeIn(duration: 400.ms)
                  else
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => _pageController.animateToPage(2, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut),
                          child: Text('Passer', style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textMuted)),
                        ),
                        const Spacer(),
                        AppButton(
                          text: 'Suivant',
                          onPressed: () => _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlide({required IconData icon, required String title, required String subtitle, Color color = AppColors.primary}) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(shape: BoxShape.circle, color: color.withValues(alpha: 0.1)),
            child: Icon(icon, size: 80, color: color),
          ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
          const SizedBox(height: 48),
          Text(title, style: AppTextStyles.h2, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Text(subtitle, style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildProfileSelection() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Choisissez votre profil', style: AppTextStyles.h2),
          const SizedBox(height: 8),
          Text('Vous pourrez le changer plus tard.', style: AppTextStyles.bodyMedium),
          const SizedBox(height: 40),
          _ProfileCard(title: 'Spectateur', icon: Icons.visibility_rounded, color: AppColors.primary),
          const SizedBox(height: 16),
          _ProfileCard(title: 'Athlète', icon: Icons.emoji_events_rounded, color: AppColors.purple),
          const SizedBox(height: 16),
          _ProfileCard(title: 'Visiteur', icon: Icons.map_rounded, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _ProfileCard({required this.title, required this.icon, required this.color});

  @override
  State<_ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<_ProfileCard> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () => setState(() => selected = !selected),
      child: Container(
        decoration: BoxDecoration(
          border: selected ? Border.all(color: widget.color, width: 2) : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: widget.color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
              child: Icon(widget.icon, color: widget.color),
            ),
            const SizedBox(width: 16),
            Text(widget.title, style: AppTextStyles.h3),
            const Spacer(),
            if (selected) Icon(Icons.check_circle_rounded, color: widget.color)
          ],
        ),
      ),
    );
  }
}
