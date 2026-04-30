import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';

class GamesHomeScreen extends StatelessWidget {
  const GamesHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF87CEEB), // Light sky blue
      body: SafeArea(
        child: Column(
          children: [
            // ─── Header: Niveau & XP ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 28),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Niveau 24',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: 0.7,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text('3200 Pts', style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Settings ou Profile (Placeholder)
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.settings, color: Colors.white),
                  )
                ],
              ),
            ),

            // ─── Mascotte sur Stade ───────────────────────────────────────────
            Expanded(
              flex: 4,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Placeholder Stade
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    height: 180,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/stade_placeholder.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    // Fallback si l'image n'existe pas
                    child: Center(
                      child: Icon(Icons.stadium, size: 100, color: Colors.white.withValues(alpha: 0.3)),
                    ),
                  ),
                  // Placeholder Mascotte
                  Positioned(
                    bottom: 80,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/mascot_placeholder.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                      child: Center(
                        child: Icon(Icons.pets, size: 80, color: Colors.orange.withValues(alpha: 0.8)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ─── Arbre des Menus (Panneaux en bois) ───────────────────────────
            Expanded(
              flex: 5,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  // Tronc / Branches principal (Placeholder stylisé)
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 40,
                    child: Container(
                      width: 20,
                      color: const Color(0xFF6B4226), // Couleur marron bois
                    ),
                  ),
                  // Branches horizontales
                  Positioned(top: 20, right: 40, child: _buildBranch()),
                  Positioned(top: 120, right: 40, child: _buildBranch()),
                  Positioned(top: 220, right: 40, child: _buildBranch()),

                  // Boutons Suspendus
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildWoodenSign(
                        context,
                        title: "Défis et missions",
                        icon: Icons.track_changes,
                        onTap: () => context.push('/games/map'),
                      ),
                      _buildWoodenSign(
                        context,
                        title: "Découverte et immersion",
                        icon: Icons.travel_explore,
                        onTap: () => context.push('/games/monument'),
                      ),
                      _buildWoodenSign(
                        context,
                        title: "Quizz",
                        icon: Icons.help_outline,
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Le Quiz classique arrive bientôt !')),
                        ),
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

  Widget _buildBranch() {
    return Container(
      width: 150,
      height: 10,
      decoration: BoxDecoration(
        color: const Color(0xFF6B4226),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget _buildWoodenSign(BuildContext context, {required String title, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Cordes de suspension
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 4, height: 20, color: Colors.grey.shade400),
              const SizedBox(width: 140),
              Container(width: 4, height: 20, color: Colors.grey.shade400),
            ],
          ),
          // Panneau
          Container(
            margin: const EdgeInsets.only(top: 15),
            width: 220,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFDEB887), // Couleur bois clair
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF8B4513), width: 3), // Bordure bois sombre
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: const Color(0xFF8B4513), size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF5C3A21),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
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
