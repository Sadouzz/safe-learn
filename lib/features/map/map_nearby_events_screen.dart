import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class MapNearbyEventsScreen extends StatelessWidget {
  const MapNearbyEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Evènements à proximité",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Bandeau avec motif (Pattern)
          Container(
            height: 40,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/pattern_header.png'), // Mettre un vrai pattern
                fit: BoxFit.cover,
                repeat: ImageRepeat.repeatX,
              ),
              color: Colors.amber, // Fallback color
            ),
          ),
          
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildEventCard(
                  imageUrl: 'assets/images/event_foot.png',
                  sportIcon: Icons.sports_soccer,
                  sportColor: Colors.green,
                  sportName: 'Football',
                  title: 'Maroc vs Egypte',
                  location: 'Stade Abdoulaye Wade',
                  time: '18:00',
                  distance: '2 km',
                ),
                _buildEventCard(
                  imageUrl: 'assets/images/event_basket.png',
                  sportIcon: Icons.sports_basketball,
                  sportColor: Colors.orange,
                  sportName: 'Basketball',
                  title: 'Allemagne vs Italie',
                  location: 'Dakar Aréna',
                  time: '19:00',
                  distance: '4 km',
                ),
                _buildEventCard(
                  imageUrl: 'assets/images/event_natation.png',
                  sportIcon: Icons.pool,
                  sportColor: Colors.blue,
                  sportName: 'Natation',
                  title: 'France vs Angleterre',
                  location: 'Piscine Olympique',
                  time: '15:30',
                  distance: '2 km',
                ),
                _buildEventCard(
                  imageUrl: 'assets/images/event_karate.png',
                  sportIcon: Icons.sports_martial_arts,
                  sportColor: Colors.red,
                  sportName: 'Karaté',
                  title: 'France vs Angleterre',
                  location: 'Stade Marius Ndiaye',
                  time: '16:00',
                  distance: '1 km',
                ),
              ],
            ),
          ),
          
          // Bouton "Voir tout le programme"
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF55C519), // Vert flash
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Voir tout le programme",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard({
    required String imageUrl,
    required IconData sportIcon,
    required Color sportColor,
    required String sportName,
    required String title,
    required String location,
    required String time,
    required String distance,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          // Image à gauche
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Icon(Icons.image, color: Colors.white54), // Fallback
            ),
          ),
          // Contenu à droite
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Sport et Icône dorée (Logo)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(sportIcon, size: 14, color: sportColor),
                          const SizedBox(width: 4),
                          Text(sportName, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                        ],
                      ),
                      const Icon(Icons.shield_outlined, size: 16, color: Colors.amber),
                    ],
                  ),
                  // Titre (Équipes)
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Lieu
                  Text(
                    location,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Heure et Distance
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 14, color: Colors.black54),
                          const SizedBox(width: 4),
                          Text(time, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.directions_run, size: 14, color: Colors.black54),
                          const SizedBox(width: 4),
                          Text(distance, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
