import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/widgets/app_card.dart';
import '../../data/missions_data.dart';
import '../../core/widgets/app_button.dart';

class MissionsScreen extends StatelessWidget {
  const MissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Missions Vertes')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppCard(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text('Impact Communautaire', style: AppTextStyles.bodyLarge),
                        const SizedBox(height: 16),
                        Text('2 340', style: AppTextStyles.h1.copyWith(color: AppColors.secondary, fontSize: 40)),
                        Text('déchets recyclés au village', style: AppTextStyles.bodyMedium),
                        const SizedBox(height: 24),
                        LinearPercentIndicator(
                          lineHeight: 12,
                          percent: 0.65,
                          backgroundColor: AppColors.surfaceAlt,
                          progressColor: AppColors.secondary,
                          barRadius: const Radius.circular(6),
                          padding: EdgeInsets.zero,
                          animation: true,
                          animationDuration: 1500,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Objectif : 5 000', style: AppTextStyles.bodySmall),
                            Text('65%', style: AppTextStyles.bodySmall.copyWith(color: AppColors.secondary, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ).animate().fadeIn().slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 32),
                  Text('Missions Disponibles', style: AppTextStyles.h3),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final mission = mockMissions[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(color: mission.color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(16)),
                                child: Icon(mission.icon, color: mission.color, size: 28),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(mission.title, style: AppTextStyles.h3),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(color: AppColors.surfaceAlt, borderRadius: BorderRadius.circular(8)),
                                      child: Text(
                                        mission.status == 'completed' ? 'Validée' : (mission.status == 'in_progress' ? 'En cours' : 'À faire'),
                                        style: AppTextStyles.bodySmall.copyWith(color: mission.status == 'completed' ? AppColors.success : (mission.status == 'in_progress' ? AppColors.warning : AppColors.textSecondary)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text('+${mission.xpReward}', style: AppTextStyles.stats),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(mission.description, style: AppTextStyles.bodyMedium),
                          const SizedBox(height: 16),
                          if (mission.status != 'completed')
                            SizedBox(
                              width: double.infinity,
                              child: AppButton(
                                text: 'Scanner le QR Code',
                                isPrimary: mission.status == 'in_progress',
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => _QrScannerSimulator(),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: Duration(milliseconds: 200 + index * 100));
                },
                childCount: mockMissions.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

class _QrScannerSimulator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.surfaceAlt, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 32),
          Container(
            width: 150, height: 150,
            decoration: BoxDecoration(border: Border.all(color: AppColors.secondary, width: 4), borderRadius: BorderRadius.circular(24)),
            child: const Center(child: Icon(Icons.qr_code_scanner_rounded, size: 80, color: AppColors.secondary)),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true)).scaleXY(end: 1.05),
          const SizedBox(height: 32),
          Text('Recherche du code...', style: AppTextStyles.h3),
          const SizedBox(height: 16),
          Text('Pointez votre caméra vers le QR code de la mission écologique.', style: AppTextStyles.bodyMedium, textAlign: TextAlign.center),
          const SizedBox(height: 32),
          AppButton(text: 'Simuler la validation', onPressed: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}
