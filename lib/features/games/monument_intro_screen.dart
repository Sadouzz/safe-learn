import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';

class MonumentIntroScreen extends StatelessWidget {
  const MonumentIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/musee_civilisations.png'),
                fit: BoxFit.cover,
              ),
            ),
            // Placeholder si l'image manque
            child: Container(
              color: Colors.black.withValues(alpha: 0.4),
              child: const Center(
                child: Icon(Icons.museum_outlined, size: 100, color: Colors.white54),
              ),
            ),
          ),
          
          // Overlay dégradé pour améliorer la lisibilité du texte
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.6),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.8),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // Titre et Sous-titre
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Musée des\nCivilisations noires",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.amber, // Couleur dorée
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                      shadows: [
                        Shadow(color: Colors.black54, blurRadius: 10, offset: Offset(0, 4)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Une création continue de l'humanité !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(color: Colors.black54, blurRadius: 5, offset: Offset(0, 2)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bouton d'action
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: ElevatedButton(
              onPressed: () => context.push('/games/monument/ar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50), // Vert pomme
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
              ),
              child: const Text(
                "Commencer l'exploration",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
