import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barre de recherche
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Rechercher des posts, #hashtags...",
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),

            // Tendances du jour
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Tendances du jour",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildTrendChip(context, "#JOJDakar", "10.4K posts", Colors.purple, route: '/community/hashtag'),
                  _buildTrendChip(context, "#TeamSenegal", "8.3K posts", Colors.orange),
                  _buildTrendChip(context, "#AthleteDuJour", "7.1K posts", Colors.blue),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Fil d'actualité (Post)
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [_buildPostCard()],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.orange,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  Widget _buildTrendChip(BuildContext context, String title, String subtitle, Color color, {String? route}) {
    return GestureDetector(
      onTap: () {
        if (route != null && route.isNotEmpty) {
          context.push(route);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Post
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/imagePost.png',
                    ),
                    backgroundColor: AppColors.surfaceAlt,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hiro_Sprint 🇯🇵",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[700],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 12,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Stade Abdoulaye Wade",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Text(
                "il y'a 2 heures",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Image Post
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              'assets/images/imagePost.png',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.surfaceAlt,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image_outlined, size: 48, color: AppColors.textMuted),
                    SizedBox(height: 8),
                    Text(
                      'Photo du stade Abdoulaye Wade',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.favorite, color: Colors.red),
                  const SizedBox(width: 4),
                  const Text("324"),
                  const SizedBox(width: 16),
                  Icon(Icons.chat_bubble_outline, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  const Text("45"),
                ],
              ),
              Icon(Icons.share, color: Colors.grey[600]),
            ],
          ),
        ],
      ),
    );
  }
}
