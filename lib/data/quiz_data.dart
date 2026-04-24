import 'package:flutter/material.dart';

class QuizModel {
  final String id;
  final String title;
  final String category; // Sports, Histoire JOJ, Athlètes
  final Color color;
  final IconData icon;
  final int questionsCount;
  final int xpReward;
  final String level; // Débutant, Intermédiaire, Expert
  final double progress; // 0.0 to 1.0

  QuizModel({
    required this.id,
    required this.title,
    required this.category,
    required this.color,
    required this.icon,
    required this.questionsCount,
    required this.xpReward,
    required this.level,
    this.progress = 0.0,
  });
}

final mockQuizzes = [
  QuizModel(
    id: 'q1',
    title: 'Histoire des JOJ',
    category: 'Histoire',
    color: const Color(0xFFF5C518),
    icon: Icons.history_edu_rounded,
    questionsCount: 5,
    xpReward: 100,
    level: 'Débutant',
  ),
  QuizModel(
    id: 'q2',
    title: 'Règles de l\'Athlétisme',
    category: 'Sports',
    color: const Color(0xFFFF5F3D),
    icon: Icons.directions_run_rounded,
    questionsCount: 10,
    xpReward: 250,
    level: 'Intermédiaire',
    progress: 0.4,
  ),
  QuizModel(
    id: 'q3',
    title: 'Légendes Africaines',
    category: 'Athlètes',
    color: const Color(0xFF7B5EA7),
    icon: Icons.star_rounded,
    questionsCount: 8,
    xpReward: 200,
    level: 'Expert',
  ),
];
