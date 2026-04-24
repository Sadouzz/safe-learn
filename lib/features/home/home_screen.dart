import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/gradient_card.dart';
import '../../core/widgets/xp_badge.dart';
import '../../data/user_mock.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(backgroundColor: AppColors.surfaceAlt, child: Text(mockUser.avatar, style: const TextStyle(fontSize: 20))),
        ),
        title: Column(
          children: [
            Text('Bonjour, ${mockUser.name}', style: AppTextStyles.h3),
            Text(mockUser.role, style: AppTextStyles.bodySmall),
          ],
        ),
        actions: [
          IconButton(
            icon: const Badge(backgroundColor: AppColors.accent, child: Icon(Icons.notifications_outlined)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientCard(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Niveau ${mockUser.level}', style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('${mockUser.xp} XP total', style: AppTextStyles.h2),
                      ],
                    ),
                  ),
                  const XpBadge(xp: 150, color: AppColors.background), // XP du jour
                ],
              ),
            ).animate().fadeIn().slideY(begin: 0.1, end: 0),
            const SizedBox(height: 32),
            Text('Modules', style: AppTextStyles.h3),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _ModuleCard(icon: Icons.psychology_rounded, title: 'Quiz Sports', color: AppColors.primary, onTap: () => context.push('/quiz')),
                _ModuleCard(icon: Icons.eco_rounded, title: 'Missions Vertes', color: AppColors.secondary, onTap: () => context.go('/missions')),
                _ModuleCard(icon: Icons.public_rounded, title: 'Cultures Africaines', color: AppColors.purple, onTap: () => context.go('/cultures')),
                _ModuleCard(icon: Icons.sports_esports_rounded, title: 'Mini-Jeux', color: AppColors.accent, onTap: () {}),
              ],
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Leaderboard', style: AppTextStyles.h3),
                Text('Voir tout', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary)),
              ],
            ),
            const SizedBox(height: 16),
            _LeaderboardItem(rank: 1, name: 'Kofi', avatar: '👦🏿', xp: 2450, isMe: false),
            _LeaderboardItem(rank: 2, name: 'Aminata', avatar: '👧🏿', xp: 2100, isMe: false),
            _LeaderboardItem(rank: 3, name: mockUser.name, avatar: mockUser.avatar, xp: mockUser.xp, isMe: true),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _ModuleCard({required this.icon, required this.title, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.15), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 12),
          Text(title, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _LeaderboardItem extends StatelessWidget {
  final int rank;
  final String name;
  final String avatar;
  final int xp;
  final bool isMe;

  const _LeaderboardItem({required this.rank, required this.name, required this.avatar, required this.xp, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isMe ? AppColors.primary.withValues(alpha: 0.1) : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: isMe ? Border.all(color: AppColors.primary, width: 1) : null,
      ),
      child: Row(
        children: [
          SizedBox(width: 24, child: Text('#$rank', style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textMuted, fontWeight: FontWeight.bold))),
          const SizedBox(width: 8),
          CircleAvatar(backgroundColor: AppColors.surfaceAlt, child: Text(avatar)),
          const SizedBox(width: 12),
          Expanded(child: Text(name, style: AppTextStyles.bodyLarge.copyWith(fontWeight: isMe ? FontWeight.bold : FontWeight.normal))),
          Text('$xp XP', style: AppTextStyles.stats),
        ],
      ),
    );
  }
}
