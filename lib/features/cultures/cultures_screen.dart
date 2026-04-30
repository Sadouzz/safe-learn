import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/widgets/app_card.dart';
import '../../data/countries_data.dart';

class CulturesScreen extends StatelessWidget {
  const CulturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cultures Africaines')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map placeholder
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.surfaceAlt,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.purple.withValues(alpha: 0.3)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/8/86/Africa_%28orthographic_projection%29.svg/540px-Africa_%28orthographic_projection%29.svg.png',
                      fit: BoxFit.contain,
                      opacity: const AlwaysStoppedAnimation(0.5),
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.surfaceAlt,
                        child: const Icon(
                          Icons.public_outlined,
                          size: 80,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                    Text(
                      'Carte Interactive',
                      style: AppTextStyles.h2.copyWith(color: AppColors.purple),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(),
            const SizedBox(height: 32),
            Text('Pays à découvrir', style: AppTextStyles.h3),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: mockCountries.length,
              itemBuilder: (context, index) {
                final country = mockCountries[index];
                return AppCard(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => _CountryDetailSheet(country: country),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(country.flagUrl, style: const TextStyle(fontSize: 48)),
                      const SizedBox(height: 16),
                      Text(country.name, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: country.discovered ? AppColors.success.withValues(alpha: 0.1) : AppColors.surfaceAlt,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          country.discovered ? 'Découvert' : 'À explorer',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: country.discovered ? AppColors.success : AppColors.textMuted,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: Duration(milliseconds: 100 * index)).scaleXY(begin: 0.9, end: 1.0);
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _CountryDetailSheet extends StatelessWidget {
  final CountryModel country;

  const _CountryDetailSheet({required this.country});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.surfaceAlt, borderRadius: BorderRadius.circular(2))),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Center(child: Text(country.flagUrl, style: const TextStyle(fontSize: 80))),
                const SizedBox(height: 16),
                Text(country.name, style: AppTextStyles.h1, textAlign: TextAlign.center),
                const SizedBox(height: 32),
                _InfoTile(icon: Icons.location_city_rounded, title: 'Capitale', value: country.capital),
                _InfoTile(icon: Icons.language_rounded, title: 'Langues', value: country.language),
                _InfoTile(icon: Icons.restaurant_rounded, title: 'Plat Traditionnel', value: country.dish),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.purple.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.purple.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.music_note_rounded, color: AppColors.purple, size: 32),
                      const SizedBox(height: 8),
                      Text('Musique Traditionnelle', style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.purple,
                        child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 36),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoTile({required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.surfaceAlt, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodySmall),
                Text(value, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
