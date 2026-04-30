import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../app/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigation vers l'onboarding après 2,5 secondes
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) context.go('/auth');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // On utilise un fond blanc pour correspondre à votre image
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Affichage du logo central
            Image.asset(
              'assets/images/logo.png', // Remplacez par votre chemin d'accès
              width: 250, // Ajustez la taille selon vos besoins
              fit: BoxFit.contain,
            )
                .animate()
                .scale(
                  duration: 800.ms,
                  curve: Curves.easeOutBack,
                  begin: const Offset(0.8, 0.8),
                )
                .fadeIn(duration: 600.ms),
          ],
        ),
      ),
    );
  }
}
