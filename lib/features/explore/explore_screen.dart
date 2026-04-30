import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryOrange = Color(0xFFE85D1A);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // --- Header ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Explorer',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Découvre Dakar et tout ce que\ntu peux vivre pendant les JOJ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.notifications,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // --- Search Bar ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Rechercher un lieu, une activité ...',
                            hintStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade500,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: primaryOrange,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // --- Hero Banner ---
              Container(
                //margin: const EdgeInsets.symmetric(horizontal: 20.0),
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/explore_hero.png',
                    ), // Image Monument de la Renaissance
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade900.withOpacity(0.8),
                        Colors.transparent,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Bienvenue à Dakar 🇸🇳',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Ville hôte des JOJ 2026',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          minimumSize: Size.zero,
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Découvrir la ville',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 10,
                              color: primaryOrange,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),

              // --- Categories ---
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Catégories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCategoryItem(
                      Icons.account_balance,
                      'Culture &\npatrimoine',
                    ),
                    _buildCategoryItem(
                      Icons.directions_run,
                      'Activités à\nfaire',
                    ),
                    _buildCategoryItem(Icons.beach_access, 'Plages &\nNature'),
                    _buildCategoryItem(
                      Icons.restaurant,
                      'Cuisine\nSénégalaise',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // --- Evènements du moment ---
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Evènements du moment',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: 160,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  children: [
                    _buildEventCard(
                      'Concert Youssou Ndour',
                      'Esplanade du grand théâtre',
                      '02 Novembre',
                      Colors.orange,
                      'assets/images/concertYoussou.png',
                    ),
                    _buildEventCard(
                      'Beach Party Ngor',
                      'Plage de Ngor',
                      '04 Novembre',
                      Colors.yellow,
                      'assets/images/beachParty.png',
                    ),
                    _buildEventCard(
                      'Festival des Arts',
                      'Village JOJ',
                      '07 Novembre',
                      Colors.lightGreen,
                      'assets/images/festival.png',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: InkWell(
                  onTap: () {},
                  child: const Text(
                    'Voir tous les événements',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),

              // --- Activités à la une ---
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Activités à la une',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildActivityCard(
                      context,
                      imageUrl: 'assets/images/activiteGoree.png',
                      title: 'Visite de l\'île de Gorée',
                      subtitle: 'Histoire & culture',
                      rating: 4.8,
                      reviews: 201,
                      isPopular: true,
                      route: '/explore/details',
                    ),
                    const SizedBox(width: 15),
                    _buildActivityCard(
                      context,
                      imageUrl: 'assets/images/activiteNgor.png',
                      title: 'Plage de Ngor',
                      subtitle: 'Détente',
                      rating: 4.5,
                      reviews: 112,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // --- Bottom Navigation Bar ---
    );
  }

  // --- Helpers ---

  Widget _buildCategoryItem(IconData icon, String title) {
    return Column(
      children: [
        Container(
          height: 65,
          width: 65,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, size: 30, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard(
    String title,
    String subtitle,
    String date,
    Color dotColor,
    String imageUrl,
  ) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            spreadRadius: 0,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with errorBuilder via Stack
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: SizedBox(
              height: 80,
              width: double.infinity,
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 80,
                  color: AppColors.surfaceAlt,
                  child: const Icon(
                    Icons.landscape_outlined,
                    color: AppColors.textMuted,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 10),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        color: dotColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: dotColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(
    BuildContext context, {
    required String imageUrl,
    required String title,
    required String subtitle,
    required double rating,
    required int reviews,
    String? route,
    bool isPopular = false,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (route != null && route.isNotEmpty) {
            context.push(route);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Image de l'activité avec errorBuilder
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceAlt,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.photo_camera_outlined,
                          color: AppColors.textMuted,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                ),
                // Badge "Populaire" si vrai
                if (isPopular)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Populaire',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            // Titre
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // Sous-titre
            Text(
              subtitle,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
            const SizedBox(height: 4),
            // Rating (Étoile + Note)
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 14),
                const SizedBox(width: 4),
                Text(
                  "$rating ($reviews)",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
