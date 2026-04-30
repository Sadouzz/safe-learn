import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';

class GamesMapScreen extends StatelessWidget {
  const GamesMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4CAF50), // Fond vert pelouse/nature
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Partie Carte",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        reverse: true, // On commence en bas (comme Candy Crush)
        child: Container(
          width: double.infinity,
          height: 1200, // Hauteur totale du chemin
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF81C784), // Vert clair haut
                Color(0xFF2E7D32), // Vert sombre bas
              ],
            ),
          ),
          child: Stack(
            children: [
              // Le tracé du chemin (Path)
              CustomPaint(
                size: const Size(double.infinity, 1200),
                painter: _MapPathPainter(),
              ),
              
              // Les différents niveaux/points d'intérêt positionnés de bas en haut
              
              // Point 1 (Départ) - En bas
              _buildMapNode(
                context: context,
                bottom: 100,
                left: 60,
                number: 1,
                title: "Monument de la Renaissance",
                isUnlocked: true,
                icon: Icons.account_balance,
              ),

              // Point 2
              _buildMapNode(
                context: context,
                bottom: 300,
                right: 80,
                number: 2,
                title: "Musée des Civilisations",
                isUnlocked: true,
                icon: Icons.museum,
                onTap: () => context.push('/games/monument'), // Ouvre l'intro du monument
              ),

              // Point 3
              _buildMapNode(
                context: context,
                bottom: 500,
                left: 80,
                number: 3,
                title: "Stade du Sénégal",
                isUnlocked: false, // Niveau bloqué
                icon: Icons.sports_soccer,
              ),

              // Point 4
              _buildMapNode(
                context: context,
                bottom: 700,
                right: 60,
                number: 4,
                title: "Village Olympique",
                isUnlocked: false,
                icon: Icons.holiday_village,
              ),

              // Point 5 (Arrivée / Sommet)
              _buildMapNode(
                context: context,
                bottom: 950,
                left: 120,
                number: 5,
                title: "Dakar Arena",
                isUnlocked: false,
                icon: Icons.stadium,
                isBoss: true,
              ),

              // Objets décoratifs (Coffres, Pièces)
              Positioned(
                bottom: 50,
                left: 150,
                child: Icon(Icons.monetization_on, color: Colors.amber, size: 40),
              ),
              Positioned(
                bottom: 400,
                right: 150,
                child: Icon(Icons.monetization_on, color: Colors.amber, size: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapNode({
    required BuildContext context,
    required double bottom,
    double? left,
    double? right,
    required int number,
    required String title,
    required bool isUnlocked,
    required IconData icon,
    bool isBoss = false,
    VoidCallback? onTap,
  }) {
    final Color nodeColor = isUnlocked ? AppColors.primary : Colors.grey;

    return Positioned(
      bottom: bottom,
      left: left,
      right: right,
      child: GestureDetector(
        onTap: isUnlocked ? onTap : null,
        child: Column(
          children: [
            // Tooltip (Titre)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: nodeColor, width: 2),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 4, offset: const Offset(0, 2)),
                ],
              ),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
            // Nœud circulaire
            Container(
              width: isBoss ? 80 : 60,
              height: isBoss ? 80 : 60,
              decoration: BoxDecoration(
                color: nodeColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(color: Colors.black45, blurRadius: 8, offset: const Offset(0, 4)),
                ],
              ),
              child: Center(
                child: isUnlocked
                    ? Icon(icon, color: Colors.white, size: isBoss ? 40 : 28)
                    : const Icon(Icons.lock, color: Colors.white, size: 24),
              ),
            ),
            // Numéro
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Text(
                number.toString(),
                style: TextStyle(color: nodeColor, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Peintre personnalisé pour dessiner le chemin sinueux
class _MapPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.5)
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final borderPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.1)
      ..strokeWidth = 26
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    // Départ en bas (Point 1)
    path.moveTo(90, size.height - 100);
    
    // Courbe vers Point 2
    path.quadraticBezierTo(size.width / 2, size.height - 150, size.width - 110, size.height - 300);
    
    // Courbe vers Point 3
    path.quadraticBezierTo(size.width - 50, size.height - 400, 110, size.height - 500);

    // Courbe vers Point 4
    path.quadraticBezierTo(50, size.height - 600, size.width - 90, size.height - 700);

    // Courbe vers Point 5 (Arrivée)
    path.quadraticBezierTo(size.width / 2, size.height - 850, 160, size.height - 950);

    // Dessine l'ombre du chemin puis le chemin lui-même
    canvas.drawPath(path, borderPaint);
    canvas.drawPath(path, paint);

    // Pointillés sur le chemin
    final dashPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
      
    // Simulation simple de pointillés en dessinant le même chemin fin en blanc
    // (Pour de vrais pointillés, il faudrait extraire les PathMetrics)
    canvas.drawPath(path, dashPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
