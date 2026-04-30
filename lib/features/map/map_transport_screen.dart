import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class MapTransportScreen extends StatelessWidget {
  const MapTransportScreen({super.key});

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
          "Se déplacer",
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
                image: AssetImage('assets/images/pattern_header.png'),
                fit: BoxFit.cover,
                repeat: ImageRepeat.repeatX,
              ),
              color: Colors.amber, // Fallback color
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Filtres (Chips)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildTransportFilter(icon: Icons.directions_bus, label: "Bus", isSelected: true),
                      _buildTransportFilter(icon: Icons.directions_walk, label: "A pied"),
                      _buildTransportFilter(icon: Icons.directions_car, label: "Voiture"),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Lieu sélectionné
                  const Text("Lieu sélectionné", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              image: const DecorationImage(
                                image: AssetImage('assets/images/stade_abdoulaye.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: const Icon(Icons.stadium, color: Colors.white54), // Fallback
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Stade Abdoulaye Wade",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              "Diamniadio",
                              style: TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Lignes disponibles
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Lignes disponibles", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text("Actualisé à 09:37", style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Ligne TER
                  _buildLineCard(
                    lineId: "TER",
                    lineColor: Colors.blue.withValues(alpha: 0.1),
                    lineIdColor: Colors.blue.shade800,
                    direction: "Diamniadio",
                    frequency: "6-7 min",
                    arriveIn: "5 min",
                    startPoint: "Gare de Dakar",
                    endPoint: "Diamniadio",
                    duration: "45 min",
                    startTime: "09:45",
                    endTime: "10:30",
                  ),
                  
                  const SizedBox(height: 16),

                  // Ligne Bus 221
                  _buildLineCard(
                    lineId: "221",
                    lineColor: Colors.amber.withValues(alpha: 0.2),
                    lineIdColor: Colors.amber.shade900,
                    direction: "Diamniadio",
                    frequency: "20 min",
                    arriveIn: null, // Pas d'arrivée imminente
                    startPoint: "Arrêt EPC",
                    endPoint: "Diamniadio",
                    duration: "55 min",
                    startTime: "09:55",
                    endTime: "10:50",
                  ),
                ],
              ),
            ),
          ),
          
          // Bouton "Voir les lignes disponibles"
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
                    "Voir les lignes disponibles",
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

  Widget _buildTransportFilter({required IconData icon, required String label, bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1B5E20) : Colors.white, // Vert foncé si sélectionné
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? const Color(0xFF1B5E20) : Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: isSelected ? Colors.white : Colors.black87),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLineCard({
    required String lineId,
    required Color lineColor,
    required Color lineIdColor,
    required String direction,
    required String frequency,
    String? arriveIn,
    required String startPoint,
    required String endPoint,
    required String duration,
    required String startTime,
    required String endTime,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          // En-tête Ligne
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [lineColor, Colors.white],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Badge Ligne
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        lineId,
                        style: TextStyle(color: lineIdColor, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Direction\n$direction",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, height: 1.2),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Fréquence : $frequency",
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                if (arriveIn != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Arrive dans", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text(
                        arriveIn,
                        style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          // Itinéraire (Timeline)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.green, size: 16),
                const SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(startPoint, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    Text(startTime, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    height: 2,
                    color: Colors.green.shade200, // Ligne pointillée normalement
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(endPoint, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    Text(endTime, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                  ],
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    duration,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
