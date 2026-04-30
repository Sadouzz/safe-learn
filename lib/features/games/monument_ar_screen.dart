import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class MonumentARScreen extends StatelessWidget {
  const MonumentARScreen({super.key});

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
          // Simulated Camera / AR Background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/musee_ar_view.png'),
                fit: BoxFit.cover,
              ),
            ),
            // Placeholder si l'image manque (Simulation de vue caméra)
            child: Container(
              color: Colors.brown.withValues(alpha: 0.3),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.camera_alt_outlined, size: 80, color: Colors.white54),
                  Positioned(
                    top: 100,
                    child: Text(
                      "Simulation AR/Caméra",
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // AR Target Button (Bottom Right)
          Positioned(
            bottom: 40,
            right: 24,
            child: GestureDetector(
              onTap: () {
                // Action pour capturer ou scanner
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cible scannée avec succès ! +50 XP')),
                );
              },
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF4CAF50), // Vert pomme
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
