class UserModel {
  final String id;
  final String name;
  final String avatar;
  final int level;
  final int xp;
  final String role; // Spectateur, Athlète, Visiteur
  final String country;

  UserModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.level,
    required this.xp,
    required this.role,
    required this.country,
  });
}

final mockUser = UserModel(
  id: 'u1',
  name: 'Amadou',
  avatar: '👨🏿‍🦱',
  level: 4,
  xp: 1250,
  role: 'Spectateur',
  country: 'Sénégal',
);
