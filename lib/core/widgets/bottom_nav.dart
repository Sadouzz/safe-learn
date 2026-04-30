
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';

class AppBottomNavShell extends StatelessWidget {
  final Widget child;

  const AppBottomNavShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.08))),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(icon: Icons.home_rounded, label: 'Accueil', path: '/home'),
                _NavItem(icon: Icons.sports_esports_rounded, label: 'Games', path: '/quiz'),
                _NavItem(icon: Icons.public_rounded, label: 'Explore', path: '/explore'),
                _NavItem(icon: Icons.map, label: 'Map', path: '/map'),
                _NavItem(icon: Icons.people, label: 'Community', path: '/community'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String path;

  const _NavItem({required this.icon, required this.label, required this.path});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final isActive = location.startsWith(path);

    return GestureDetector(
      onTap: () {
        if (!isActive) context.go(path);
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppColors.primary : AppColors.textMuted,
              size: isActive ? 26 : 24,
            ).animate(target: isActive ? 1 : 0).scaleXY(end: 1.1),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: isActive ? AppColors.primary : AppColors.textMuted,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

