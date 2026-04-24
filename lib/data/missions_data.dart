import 'package:flutter/material.dart';

class MissionModel {
  final String id;
  final String title;
  final String description;
  final Color color;
  final IconData icon;
  final int xpReward;
  final String status; // 'available', 'in_progress', 'completed'

  MissionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
    required this.xpReward,
    this.status = 'available',
  });
}

final mockMissions = [
  MissionModel(
    id: 'm1',
    title: 'Gourde Réutilisable',
    description: 'Scannez le QR code aux fontaines d\'eau avec votre gourde.',
    color: const Color(0xFF00E5A0),
    icon: Icons.water_drop_rounded,
    xpReward: 50,
    status: 'in_progress',
  ),
  MissionModel(
    id: 'm2',
    title: 'Zéro Déchet',
    description: 'Triez vos déchets dans les poubelles colorées du stade.',
    color: const Color(0xFFF5C518),
    icon: Icons.recycling_rounded,
    xpReward: 100,
  ),
  MissionModel(
    id: 'm3',
    title: 'Mobilité Douce',
    description: 'Rejoignez le village olympique en utilisant les navettes électriques.',
    color: const Color(0xFFFF5F3D),
    icon: Icons.electric_bike_rounded,
    xpReward: 150,
    status: 'completed',
  ),
];
