import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class HashtagScreen extends StatelessWidget {
  const HashtagScreen({super.key});

  // Données simulées : des "posts" avec des variantes de gris et des likes
  static const List<Map<String, dynamic>> _posts = [
    {'likes': '2.1K', 'shade': 0xFF9E9E9E, 'large': true},
    {'likes': '1.4K', 'shade': 0xFFBDBDBD, 'large': false},
    {'likes': '987',  'shade': 0xFF757575, 'large': false},
    {'likes': '3.2K', 'shade': 0xFFE0E0E0, 'large': false},
    {'likes': '654',  'shade': 0xFF9E9E9E, 'large': false},
    {'likes': '1.1K', 'shade': 0xFFBDBDBD, 'large': true},
    {'likes': '876',  'shade': 0xFF757575, 'large': false},
    {'likes': '2.4K', 'shade': 0xFFE0E0E0, 'large': false},
    {'likes': '431',  'shade': 0xFF9E9E9E, 'large': false},
    {'likes': '1.7K', 'shade': 0xFFBDBDBD, 'large': false},
    {'likes': '589',  'shade': 0xFF757575, 'large': false},
    {'likes': '2.9K', 'shade': 0xFFE0E0E0, 'large': false},
    {'likes': '712',  'shade': 0xFF9E9E9E, 'large': false},
    {'likes': '1.3K', 'shade': 0xFFBDBDBD, 'large': false},
    {'likes': '445',  'shade': 0xFF757575, 'large': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        shadowColor: AppColors.border,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Column(
          children: [
            Text(
              "#JOJDakar",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              "10.4K posts",
              style: TextStyle(color: AppColors.textMuted, fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: AppColors.textPrimary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // ─── Stats banner ───────────────────────────────────────────────────
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('10.4K', 'Posts'),
                _buildDivider(),
                _buildStatItem('48.2K', 'Vues'),
                _buildDivider(),
                _buildStatItem('5.6K', 'Participants'),
              ],
            ),
          ),

          // ─── Tabs ────────────────────────────────────────────────────────
          Container(
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTab("Top", isActive: true),
                _buildTab("Récent"),
                _buildTab("Vidéos"),
                _buildTab("Photos"),
              ],
            ),
          ),

          // ─── Grid de placeholders gris ───────────────────────────────────
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(2),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    // ── Placeholder gris avec icône image ──────────────────
                    Container(
                      color: Color(post['shade'] as int),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_outlined,
                            color: Colors.white.withValues(alpha: 0.5),
                            size: 28,
                          ),
                        ],
                      ),
                    ),
                    // ── Overlay dégradé bas ─────────────────────────────────
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 36,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.5),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    // ── Likes ───────────────────────────────────────────────
                    Positioned(
                      bottom: 6,
                      left: 6,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 13,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            post['likes'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(width: 1, height: 28, color: AppColors.border);
  }

  Widget _buildTab(String title, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        border: isActive
            ? const Border(
                bottom: BorderSide(color: AppColors.primary, width: 2.5),
              )
            : null,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? AppColors.primary : AppColors.textMuted,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
      ),
    );
  }
}
