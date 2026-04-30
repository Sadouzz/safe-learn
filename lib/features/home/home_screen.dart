import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ─────────────────────────────────────────────────────────────────────────────
  // Ombre commune
  // ─────────────────────────────────────────────────────────────────────────────
  static const List<BoxShadow> _cardShadow = [
    BoxShadow(
      color: AppColors.shadowColor,
      offset: Offset(0, 4),
      blurRadius: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHero(context),
            _buildSectionTitle('Actualités'),
            _buildActualitesCard(),
            _buildSectionTitle('Défis en cours'),
            _buildDefisEnCours(),
            _buildSectionTitle('Pour toi'),
            _buildPourToi(),
            _buildSectionTitle('Temps forts Olympiques'),
            _buildTempsFortsSection(),
            _buildSectionTitle('Leaderboard'),
            _buildLeaderboard(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Section title
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 17,
              color: AppColors.textPrimary,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // 1. HERO HEADER
  // ─────────────────────────────────────────────────────────────────────────────
  Widget buildHero(BuildContext context) {
    // Largeur de l'écran pour calculer les dimensions relatives
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.85; // La carte prend 85% de l'écran

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.centerLeft,
          children: [
            // --- 1. LA CARTE ORANGE (Contenu Principal) ---
            Container(
              width: cardWidth,
              // Suppression de height fixe -> HUG CONTENT
              margin: const EdgeInsets.only(
                left: 15,
                right: 65,
              ), // Espace à gauche de l'écran
              padding: const EdgeInsets.fromLTRB(
                20,
                16,
                16,
                20,
              ), // Plus de padding à droite pour le lion
              decoration: BoxDecoration(
                color: const Color(0xFFE65100), // Orange brûlé
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Hug content vertical
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rangée du haut (Niveau + Trophée)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Badge Niveau
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Niveau 10',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // Icône Trophée
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.3),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.emoji_events_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),

                  //const SizedBox(height: 6),

                  // Infos Profil (Avatar + Nom + Pts)
                  Row(
                    children: [
                      // Avatar Femme
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/olivia_avatar.png',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                width: 60,
                                height: 60,
                                color: Colors.grey,
                              ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      // Nom et Points
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Olivia',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '3298 Pts',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  //const SizedBox(height: 6),

                  // Barre de progression
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progression vers niveau 11',
                        style: GoogleFonts.inter(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '67%',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Stack(
                    children: [
                      // Fond de la barre
                      Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      // Partie remplie (Vert)
                      FractionallySizedBox(
                        widthFactor: 0.67, // 67%
                        child: Container(
                          height: 10,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50), // Vert progression
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Texte descriptif
                  Text(
                    'Encore 100 points pour atteindre le prochain niveau',
                    style: GoogleFonts.inter(
                      color: Colors.white70,
                      fontSize: 11,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // --- Les 3 Badges blancs du bas ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatBadge(
                        icon: Icons.shield_outlined,
                        value: '5',
                        label: 'Badge',
                        color: const Color(0xFF2196F3), // Bleu
                      ),
                      _buildStatBadge(
                        icon: Icons.assignment_outlined,
                        value: '10',
                        label: 'Défis',
                        color: const Color(0xFF4CAF50), // Vert
                      ),
                      _buildStatBadge(
                        icon: Icons.local_fire_department_outlined,
                        value: '10',
                        label: 'Série',
                        color: const Color(0xFFF44336), // Rouge
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // --- 2. LE LION ---
            Positioned(
              right: -screenWidth * 0.11,
              top: -10, // Ajusté pour éviter les erreurs de hit-test
              bottom: -10, // Ajusté pour donner une zone de contrainte
              child: SizedBox(
                width: screenWidth * 0.3,
                child: Image.asset(
                  'assets/images/lion_3d.png', // Ton chemin local
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.pets, size: 30, color: Colors.brown),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget utilitaire pour créer les badges blancs du bas
  Widget _buildStatBadge({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Stack(
      clipBehavior: Clip.none, // Permet le débordement
      alignment: Alignment.topCenter,
      children: [
        // --- Le corps du badge ---
        Container(
          width: 75,
          //height: 75,
          margin: const EdgeInsets.only(
            top: 10,
          ), // Espace pour laisser l'icône dépasser
          padding: const EdgeInsets.only(top: 15, bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: GoogleFonts.inter(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        // --- L'icône qui déborde en haut ---
        Positioned(
          top: -8, // Positionne l'icône à cheval sur le bord haut
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color:
                  Colors.white, // Fond blanc pour couper la bordure si besoin
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: color.withValues(alpha: 0.2), blurRadius: 4),
              ],
            ),
            child: Icon(icon, color: color, size: 22),
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // 2. ACTUALITÉS
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildActualitesCard() {
    return Container(
      width: double.infinity,
      height: 110,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: _cardShadow,
        border: Border.all(color: AppColors.border),
      ),
      child: Stack(
        children: [
          // Image gauche
          Positioned(
            top: 10,
            left: 6,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                'assets/images/rectangle65.png',
                width: 143,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 143,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.image_outlined, color: Colors.grey),
                ),
              ),
            ),
          ),
          // Badge "À la une"
          Positioned(
            top: 15,
            left: 165,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.redBadge,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                'A la une',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 8,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Titre article
          Positioned(
            top: 26,
            left: 165,
            right: 8,
            child: Text(
              'Champions olympiques, médaillés et olympiens comme athlètes modèles',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Corps article
          Positioned(
            top: 47,
            left: 165,
            right: 8,
            child: Text(
              "Le comité international Olympiques (CIO) a annoncé la première promotion d'athlètes modèles pour les jeux Olympiques de la jeu...",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Timestamp
          Positioned(
            bottom: 8,
            left: 165,
            child: Text(
              "Il y'a 2H",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 6,
                color: AppColors.textGrey,
              ),
            ),
          ),
          // Pagination dots
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDot(filled: true),
                const SizedBox(width: 3),
                _buildDot(filled: false),
                const SizedBox(width: 3),
                _buildDot(filled: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot({required bool filled}) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? AppColors.orange : Colors.white,
        border: filled ? null : Border.all(color: AppColors.orange, width: 1),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // 3. DÉFIS EN COURS
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildDefisEnCours() {
    return SizedBox(
      height: 107,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _buildDefiCard(
              title: 'Défi Quiz Sport',
              subtitle: 'Réponds à 10 questions',
              progress: 0.6,
              label: '60% complété',
              icon: Icons.sports_soccer_rounded,
            ),
            const SizedBox(width: 12),
            _buildDefiCard(
              title: 'Mission Verte',
              subtitle: 'Scanne 3 QR éco',
              progress: 0.3,
              label: '30% complété',
              icon: Icons.eco_rounded,
            ),
            const SizedBox(width: 12),
            _buildDefiCard(
              title: 'Culture Africa',
              subtitle: 'Explore 5 pays',
              progress: 0.8,
              label: '80% complété',
              icon: Icons.public_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefiCard({
    required String title,
    required String subtitle,
    required double progress,
    required String label,
    required IconData icon,
  }) {
    return Container(
      width: 190,
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: _cardShadow,
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, color: AppColors.orange, size: 16),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 7,
                        color: AppColors.textGrey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: const Color(0xFFE0E0E0),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.orange,
                  ),
                  minHeight: 5,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 8,
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // 4. POUR TOI
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildPourToi() {
    return SizedBox(
      height: 100,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _buildPourToiCard(
              tag: 'Recommandé',
              title: 'Quiz Athlétisme',
              color: const Color(0xFF2D3748),
            ),
            const SizedBox(width: 12),
            _buildPourToiCard(
              tag: 'Nouveau',
              title: 'Mission Sénégal',
              color: const Color(0xFF1A3C4A),
            ),
            const SizedBox(width: 12),
            _buildPourToiCard(
              tag: 'Populaire',
              title: 'Jeux Mini-Arena',
              color: const Color(0xFF3D2B4A),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPourToiCard({
    required String tag,
    required String title,
    required Color color,
  }) {
    return Stack(
      children: [
        Container(
          width: 150,
          height: 90,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            boxShadow: _cardShadow,
          ),
          padding: const EdgeInsets.all(8),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 11,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              tag,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 6,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // 5. TEMPS FORTS OLYMPIQUES
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildTempsFortsSection() {
    final List<Map<String, dynamic>> cards = [
      {
        'image': 'assets/images/Rectangle 51.png',
        'footerImage': 'assets/images/rectangle65.png',
        'title': ' 🥇​Papadakis et Cizeron décrochent l’or grace à ...',
      },
      {
        'image': 'assets/images/Rectangle 53.png',
        'footerImage': 'assets/images/rectangle65.png',
        'title': 'kobayashi ryoyu décroche le premier or ...',
      },
      {
        'image': 'assets/images/Rectangle 55.png',
        'footerImage': 'assets/images/rectangle65.png',
        'title': 'Superbe applaudissement viking au biathon',
      },
      {
        'image': 'assets/images/Rectangle 57.png',
        'footerImage': 'assets/images/rectangle65.png',
        'title': 'La compagne d’Antoinette Rijpma-de ...',
      },
    ];
    return SizedBox(
      height: 124, // Hauteur calquée sur le h-[124px] du React
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: 17), // Espacement (103px - 86px = 17px)
        itemBuilder: (context, index) {
          final card = cards[index];
          return _buildTempsFortsCard(card);
        },
      ),
    );
  }

  Widget _buildTempsFortsCard(Map<String, dynamic> data) {
    return Container(
      width: 86,
      height: 124,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Stack(
          children: [
            // 1. Image de fond
            Image.asset(
              data['image'],
              width: 86,
              height: 124,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 86,
                height: 124,
                color: AppColors.surfaceAlt,
                child: const Icon(
                  Icons.image_outlined,
                  color: AppColors.textMuted,
                  size: 28,
                ),
              ),
            ),

            // 2. Badge "Nouvelle" en haut à droite
            Positioned(
              top: 6,
              right: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D99FF),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Nouveau',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 7,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // 3. Overlay Texte en bas (Fond dégradé ou semi-transparent)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  // Effet de superposition sombre pour la lisibilité
                  color: Colors.black.withOpacity(0.3),
                ),
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            data['title'] ??
                            'Papadakis et Cizeron décrochent l’or grace à ...',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 7.5,
                          fontWeight: FontWeight.w800,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  } // ─────────────────────────────────────────────────────────────────────────────

  // 6. LEADERBOARD
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildLeaderboard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: _cardShadow,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _buildLeaderboardRow(
            emoji: '🥇',
            name: 'Culture Queen',
            score: '7659',
            avatar: 'ellipse5',
          ),
          const SizedBox(height: 12),
          _buildLeaderboardRow(
            emoji: '🥈',
            name: 'SportyMaya',
            score: '7345',
            avatar: 'ellipse6',
          ),
          const SizedBox(height: 12),
          _buildLeaderboardRow(
            emoji: '🥉',
            name: 'GameMasterLeo',
            score: '7030',
            avatar: 'ellipse7',
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardRow({
    required String emoji,
    required String name,
    required String score,
    required String avatar,
  }) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 8),
        CircleAvatar(
          radius: 11,
          backgroundImage: AssetImage('assets/images/$avatar.png'),
          onBackgroundImageError: (context, error) {},
          backgroundColor: Colors.grey[300],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            name,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 11,
              color: Colors.black,
            ),
          ),
        ),
        Text(
          score,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: AppColors.orange,
          ),
        ),
      ],
    );
  }
}
