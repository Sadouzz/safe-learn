import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';

// ─── Modèle de destination ────────────────────────────────────────────────────
class _Destination {
  final String name;
  final String subtitle;
  final LatLng position;
  final IconData icon;
  final Color color;
  final String duration; // en minutes
  final String distance; // en km
  final List<String> transports;

  const _Destination({
    required this.name,
    required this.subtitle,
    required this.position,
    required this.icon,
    required this.color,
    required this.duration,
    required this.distance,
    required this.transports,
  });
}

// ─── Données ──────────────────────────────────────────────────────────────────
const _userPosition = LatLng(14.7415, -17.1980);

const List<_Destination> _destinations = [
  _Destination(
    name: 'Stade Abdoulaye Wade',
    subtitle: 'Diamniadio',
    position: LatLng(14.7431, -17.1991),
    icon: Icons.sports_soccer,
    color: Colors.purple,
    duration: '8 min',
    distance: '1.2 km',
    transports: ['Bus 221', 'TER', 'À pied'],
  ),
  _Destination(
    name: 'Village des Athlètes',
    subtitle: 'Diamniadio',
    position: LatLng(14.7400, -17.2020),
    icon: Icons.home_outlined,
    color: Color(0xFF2E7D32),
    duration: '12 min',
    distance: '2.4 km',
    transports: ['Bus 221', 'Navette JOJ'],
  ),
  _Destination(
    name: 'Arena Dakar',
    subtitle: 'Diamniadio',
    position: LatLng(14.7450, -17.1950),
    icon: Icons.stadium,
    color: Colors.orange,
    duration: '5 min',
    distance: '0.8 km',
    transports: ['TER', 'À pied'],
  ),
  _Destination(
    name: 'Piscine Olympique',
    subtitle: 'Diamniadio',
    position: LatLng(14.7390, -17.1960),
    icon: Icons.pool,
    color: Colors.blue,
    duration: '15 min',
    distance: '3.1 km',
    transports: ['Bus 221', 'Voiture'],
  ),
];

// ─── Écran principal ──────────────────────────────────────────────────────────
class MapHomeScreen extends StatefulWidget {
  const MapHomeScreen({super.key});

  @override
  State<MapHomeScreen> createState() => _MapHomeScreenState();
}

class _MapHomeScreenState extends State<MapHomeScreen>
    with TickerProviderStateMixin {
  final MapController _mapController = MapController();
  _Destination? _selected;
  bool _showBottomSheet = false;
  String _selectedTransport = '';
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  // Génère un itinéraire simulé (waypoints entre l'utilisateur et la dest.)
  List<LatLng> _buildRoute(_Destination dest) {
    final midLat = (_userPosition.latitude + dest.position.latitude) / 2;
    final midLng = (_userPosition.longitude + dest.position.longitude) / 2;
    // Ajoute un léger décalage pour simuler une vraie rue
    final offsetLat = midLat + 0.0005;
    final offsetLng = midLng - 0.0003;
    return [_userPosition, LatLng(offsetLat, offsetLng), dest.position];
  }

  void _selectDestination(_Destination dest) {
    setState(() {
      _selected = dest;
      _showBottomSheet = true;
      _selectedTransport = dest.transports.first;
    });
    // Anime la caméra pour centrer entre l'utilisateur et la destination
    final midLat = (_userPosition.latitude + dest.position.latitude) / 2;
    final midLng = (_userPosition.longitude + dest.position.longitude) / 2;
    _mapController.move(LatLng(midLat, midLng), 15.5);
  }

  void _clearSelection() {
    setState(() {
      _selected = null;
      _showBottomSheet = false;
    });
    _mapController.move(_userPosition, 15.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ─── 1. La Carte ──────────────────────────────────────────────────
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _userPosition,
              initialZoom: 15.0,
              onTap: (tapPos, _) {
                if (_showBottomSheet) _clearSelection();
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.safe_learn.app',
              ),

              // ── Itinéraire tracé ──────────────────────────────────────────
              if (_selected != null)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _buildRoute(_selected!),
                      strokeWidth: 6,
                      color: _selected!.color,
                      borderStrokeWidth: 2,
                      borderColor: Colors.white,
                    ),
                  ],
                ),

              // ── Marqueurs destinations ─────────────────────────────────────
              MarkerLayer(
                markers: [
                  // Position de l'utilisateur (point bleu pulsant)
                  Marker(
                    point: _userPosition,
                    width: 50,
                    height: 50,
                    child: AnimatedBuilder(
                      animation: _pulseController,
                      builder: (ctx, _) => Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 40 + (_pulseController.value * 10),
                            height: 40 + (_pulseController.value * 10),
                            decoration: BoxDecoration(
                              color: Colors.blue.withValues(
                                  alpha: 0.15 * (1 - _pulseController.value)),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 2.5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.blue.withValues(alpha: 0.4),
                                    blurRadius: 8)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Marqueurs destinations
                  ..._destinations.map((dest) {
                    final isSelected = _selected == dest;
                    return Marker(
                      point: dest.position,
                      width: isSelected ? 160 : 140,
                      height: isSelected ? 56 : 44,
                      child: GestureDetector(
                        onTap: () => _selectDestination(dest),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isSelected ? dest.color : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: dest.color,
                                      width: isSelected ? 0 : 2.5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: dest.color
                                          .withValues(alpha: 0.4),
                                      blurRadius: isSelected ? 12 : 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  dest.icon,
                                  color:
                                      isSelected ? Colors.white : dest.color,
                                  size: isSelected ? 20 : 16,
                                ),
                              ),
                              if (isSelected) ...[
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: dest.color,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: dest.color.withValues(alpha: 0.4),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2)),
                                      ],
                                    ),
                                    child: Text(
                                      dest.name.split(' ').first,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ] else ...[
                                const SizedBox(width: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.white.withValues(alpha: 0.92),
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: dest.color, width: 1),
                                  ),
                                  child: Text(
                                    dest.name.split(' ').first,
                                    style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: dest.color),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),

          // ─── 2. En-tête ───────────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Carte et infos',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                        color: Colors.white,
                                        blurRadius: 4)
                                  ])),
                          Text(
                            'Déplace toi facilement pendant les JOJ',
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                                shadows: [
                                  Shadow(color: Colors.white, blurRadius: 4)
                                ]),
                          ),
                        ],
                      ),
                      _buildFloatingIcon(Icons.notifications_none),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Barre de recherche
                  Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.orange.shade300),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 14),
                          const Icon(Icons.search,
                              color: Colors.grey, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Rechercher un lieu...',
                                border: InputBorder.none,
                                hintStyle: TextStyle(fontSize: 14),
                              ),
                              onSubmitted: (val) {
                                // Cherche dans les destinations
                                final found = _destinations
                                    .where((d) => d.name
                                        .toLowerCase()
                                        .contains(val.toLowerCase()))
                                    .firstOrNull;
                                if (found != null) _selectDestination(found);
                              },
                            ),
                          ),
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: const Icon(Icons.search,
                                color: Colors.white, size: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ─── 3. Boutons droite ────────────────────────────────────────────
          Positioned(
            right: 16,
            top: 210,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => _mapController.move(_userPosition, 15.5),
                  child: _buildFloatingIcon(Icons.my_location,
                      color: Colors.blue),
                ),
                const SizedBox(height: 12),
                _buildFloatingIcon(Icons.layers_outlined),
              ],
            ),
          ),

          // ─── 4. Chips de destinations rapides ────────────────────────────
          if (!_showBottomSheet)
            Positioned(
              bottom: 180,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _destinations.length,
                  separatorBuilder: (ctx, _) => const SizedBox(width: 10),
                  itemBuilder: (context, i) {
                    final dest = _destinations[i];
                    return GestureDetector(
                      onTap: () => _selectDestination(dest),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border:
                              Border.all(color: dest.color.withValues(alpha: 0.5)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2))
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(dest.icon, size: 16, color: dest.color),
                            const SizedBox(width: 6),
                            Text(dest.name.split(' ').first,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: dest.color)),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(delay: Duration(milliseconds: 80 * i)).slideX(begin: 0.3, end: 0);
                  },
                ),
              ),
            ),

          // ─── 5. Boutons Principaux (sans sélection) ───────────────────────
          if (!_showBottomSheet)
            Positioned(
              bottom: 120,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    icon: Icons.location_on,
                    color: Colors.blue,
                    label: 'Autour de moi',
                    onTap: () => context.push('/map/events'),
                  ),
                  _buildActionButton(
                    icon: Icons.directions_bus,
                    color: Colors.deepPurple,
                    label: 'Transport',
                    onTap: () => context.push('/map/transport'),
                  ),
                ],
              ),
            ),

          // ─── 6. Bannière Météo (sans sélection) ──────────────────────────
          if (!_showBottomSheet)
            Positioned(
              bottom: 20,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.blueAccent, Color(0xFF1565C0)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blue.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.wb_sunny,
                            color: Colors.amber, size: 22),
                        SizedBox(width: 8),
                        Text('28°C · Ensoleillé',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Text('Météo à Dakar',
                        style: TextStyle(
                            color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
            ),

          // ─── 7. Fiche Itinéraire animée (après sélection) ─────────────────
          if (_showBottomSheet && _selected != null)
            _buildRouteBottomSheet(_selected!),
        ],
      ),
    );
  }

  // ─── Widgets helpers ──────────────────────────────────────────────────────

  Widget _buildFloatingIcon(IconData icon, {Color? color}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Icon(icon, color: color ?? Colors.black87, size: 20),
    );
  }

  Widget _buildActionButton(
      {required IconData icon,
      required Color color,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.4)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 3))
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteBottomSheet(_Destination dest) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, -4))
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Titre & Fermer ─────────────────────────────────────
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color:
                              dest.color.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(dest.icon,
                            color: dest.color, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(dest.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            Text(dest.subtitle,
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: _clearSelection,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close,
                              size: 18, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // ── Infos du trajet ────────────────────────────────────
                  Row(
                    children: [
                      _buildInfoChip(
                          Icons.schedule, dest.duration, dest.color),
                      const SizedBox(width: 10),
                      _buildInfoChip(Icons.straighten,
                          dest.distance, Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // ── Sélection du transport ─────────────────────────────
                  const Text('Mode de transport',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black54)),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: dest.transports.map((t) {
                        final isActive = t == _selectedTransport;
                        IconData tIcon = Icons.directions_bus;
                        if (t.contains('TER')) {
                          tIcon = Icons.train;
                        } else if (t.contains('pied')) {
                          tIcon = Icons.directions_walk;
                        } else if (t.contains('Navette')) {
                          tIcon = Icons.airport_shuttle;
                        } else if (t.contains('Voiture')) {
                          tIcon = Icons.directions_car;
                        }
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedTransport = t),
                          child: AnimatedContainer(
                            duration:
                                const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? dest.color
                                  : Colors.grey.shade100,
                              borderRadius:
                                  BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Icon(tIcon,
                                    size: 16,
                                    color: isActive
                                        ? Colors.white
                                        : Colors.black54),
                                const SizedBox(width: 6),
                                Text(t,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: isActive
                                            ? Colors.white
                                            : Colors.black87)),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ── Bouton Démarrer ────────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                '🧭 Navigation vers ${dest.name} démarrée !'),
                            backgroundColor: dest.color,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12)),
                          ),
                        );
                      },
                      icon: const Icon(Icons.navigation,
                          color: Colors.white),
                      label: Text(
                          'Démarrer · ${dest.duration} en $_selectedTransport',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: dest.color,
                        padding:
                            const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        elevation: 3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      )
          .animate()
          .slideY(begin: 1, end: 0, duration: 300.ms, curve: Curves.easeOut)
          .fadeIn(duration: 200.ms),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: color)),
        ],
      ),
    );
  }
}
