class CountryModel {
  final String id;
  final String name;
  final String flagUrl;
  final String capital;
  final String language;
  final String dish;
  final bool discovered;

  CountryModel({
    required this.id,
    required this.name,
    required this.flagUrl,
    required this.capital,
    required this.language,
    required this.dish,
    this.discovered = false,
  });
}

final mockCountries = [
  CountryModel(
    id: 'sn',
    name: 'Sénégal',
    flagUrl: '🇸🇳',
    capital: 'Dakar',
    language: 'Wolof, Français',
    dish: 'Thiéboudienne',
    discovered: true,
  ),
  CountryModel(
    id: 'ng',
    name: 'Nigeria',
    flagUrl: '🇳🇬',
    capital: 'Abuja',
    language: 'Anglais, Hausa, Yoruba',
    dish: 'Jollof Rice',
    discovered: true,
  ),
  CountryModel(
    id: 'ke',
    name: 'Kenya',
    flagUrl: '🇰🇪',
    capital: 'Nairobi',
    language: 'Swahili, Anglais',
    dish: 'Nyama Choma',
    discovered: false,
  ),
  CountryModel(
    id: 'za',
    name: 'Afrique du Sud',
    flagUrl: '🇿🇦',
    capital: 'Pretoria',
    language: 'Zulu, Xhosa, Afrikaans',
    dish: 'Braai',
    discovered: false,
  ),
];
