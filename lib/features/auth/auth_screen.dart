import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

// J'utilise des couleurs hardcodées pour l'exemple,
// remplace-les par tes variables AppColors si nécessaire.
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fond blanc comme sur l'image
      body: Stack(
        children: [
          // 1. Décoration du Header (Le lion et les motifs)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/header_pattern.png',
                  ), // Le motif en filigrane
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  // Image du Lion dans son cadre bleu
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 1),
                    ),
                    child: Image.asset(
                      'assets/images/auth_lion.png',
                      width: 180,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Texte Dakar 2026
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.montserrat(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF333333),
                      ),
                      children: const [
                        TextSpan(
                          text: 'JOJ ',
                          style: TextStyle(color: Color(0xFFE86B10)), // Orange
                        ),
                        TextSpan(text: 'DAKAR '),
                        TextSpan(
                          text: '2026',
                          style: TextStyle(color: Color(0xFFE86B10)), // Orange
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '♦️ JEUX OLYMPIQUES DE LA JEUNESSE ♦️',
                    style: TextStyle(
                      color: Color(0xFF2E7D32), // Vert
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Formulaire de connexion (Card blanche arrondie)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                    100,
                  ), // Très arrondi comme sur l'image
                  topRight: Radius.circular(100),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Bienvenue!',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                    ),
                  ),
                  const Text(
                    'Connectez-vous à votre compte',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 30),

                  // Champs de saisie avec le style spécifique (Bords marron clair)
                  const _CustomTextField(
                    hint: 'Adresse e-mail',
                    icon: Icons.lock_outline, // Icone cadenas comme sur l'image
                    showMic: true,
                  ),
                  const SizedBox(height: 15),
                  const _CustomTextField(
                    hint: 'Mot de passe',
                    icon: Icons.email_outlined, // Icone enveloppe
                    isPassword: true,
                    showMic: true,
                  ),

                  const SizedBox(height: 30),

                  // Bouton Se Connecter (Orange)
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () => context.go('/home'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE86B10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Se connecter',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),
                  const Text("ou", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 15),

                  // Bouton Créer un compte (Bordure verte)
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF2E7D32)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Créer un compte',
                        style: TextStyle(
                          color: Color(0xFF2E7D32),
                          fontSize: 16,
                        ),
                      ),
                    ),
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

class _CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool isPassword;
  final bool showMic;

  const _CustomTextField({
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.showMic = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        prefixIcon: Icon(icon, color: Colors.grey, size: 20),
        suffixIcon: showMic
            ? const Icon(Icons.mic, color: Color(0xFF2E7D32))
            : null,
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFD7CCC8),
          ), // Couleur marron clair
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE86B10)),
        ),
      ),
    );
  }
}
