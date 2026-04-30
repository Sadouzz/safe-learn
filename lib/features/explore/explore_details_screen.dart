import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryOrange = Color(0xFFE85D1A);
    const Color tagPurple = Color(0xFFF3E8FF);
    const Color textPurple = Color(0xFF7C3AED);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Section Image ---
            Stack(
              children: [
                Container(
                  height: 350,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/goreeHeader.png'), // Image de Gorée
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Bouton Retour
                Positioned(
                  top: 50,
                  left: 20,
                  child: _buildCircularButton(
                    Icons.arrow_back_ios_new,
                    Colors.black,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                // Bouton Favoris
                Positioned(
                  top: 50,
                  right: 20,
                  child: _buildCircularButton(Icons.favorite_border, Colors.black),
                ),
                // Indicateur d'images (1/8)
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.image_outlined, color: Colors.white, size: 16),
                        SizedBox(width: 5),
                        Text('1/8', style: TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titre
                  const Text(
                    "Visite de l'île de Gorée",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  
                  // Tag
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: tagPurple,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Culture & Histoire',
                      style: TextStyle(color: textPurple, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Notes et Distance
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 5),
                      const Text("4.9", style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 5),
                      Text("(120 avis)", style: TextStyle(color: Colors.grey.shade600)),
                      const SizedBox(width: 20),
                      Icon(Icons.location_on, color: Colors.grey.shade400, size: 20),
                      const SizedBox(width: 5),
                      Text("3 km de vous", style: TextStyle(color: Colors.grey.shade600)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Description
                  Text(
                    "Classée au patrimoine mondial de l'UNESCO, l'île de Gorée est un lieu chargé d'histoire et de culture. Une visite inoubliable !",
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 14, height: 1.5),
                  ),
                  const SizedBox(height: 25),

                  // Grille d'infos (Durée, Moment, Difficulté, Accès)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoBox(Icons.access_time, "Durée", "3 heures"),
                      _buildInfoBox(Icons.wb_sunny_outlined, "Moment", "Matin (8h - 12h)"),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoBox(Icons.speed, "Difficulté", "Facile"),
                      _buildInfoBox(Icons.directions_boat_outlined, "Accès", "Ferry depuis Dakar"),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Section "Ce qui t'attend"
                  const Text(
                    "Ce qui t'attend",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildExpectationItem(Icons.home_work_outlined, "Maisons\ncoloniales"),
                      _buildExpectationItem(Icons.account_balance, "Musée de\nl'esclavage"),
                      _buildExpectationItem(Icons.directions_walk, "Balade\nhistorique"),
                      _buildExpectationItem(Icons.landscape_outlined, "Paysages\nmagnifiques"),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Barre d'action finale
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(Icons.favorite_border, color: Colors.black),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryOrange,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Voir les détails pratiques",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.arrow_forward, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      // Bottom Nav Bar identique au premier écran pour la cohérence
    );
  }

  // --- Widgets Utilitaires ---

  Widget _buildCircularButton(IconData icon, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }

  Widget _buildInfoBox(IconData icon, String label, String value) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade400, size: 24),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildExpectationItem(IconData icon, String title) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.black87),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}