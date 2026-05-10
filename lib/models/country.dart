class Country {
  const Country({
    required this.commonName,
    required this.officialName,
    required this.capitals,
    required this.region,
    required this.subregion,
    required this.population,
    required this.area,
    required this.languages,
    required this.currencies,
    required this.timezones,
    required this.flagPng,
    required this.flagAlt,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    final name = _map(json['name']);
    final flags = _map(json['flags']);

    return Country(
      commonName: _string(name['common'], fallback: 'Unknown country'),
      officialName: _string(
        name['official'],
        fallback: 'Unknown official name',
      ),
      capitals: _stringList(json['capital']),
      region: _string(json['region']),
      subregion: _string(json['subregion']),
      population: _int(json['population']),
      area: _double(json['area']),
      languages: _values(json['languages']),
      currencies: _currencyNames(json['currencies']),
      timezones: _stringList(json['timezones']),
      flagPng: _string(flags['png']),
      flagAlt: _string(flags['alt'], fallback: 'Country flag'),
    );
  }

  final String commonName;
  final String officialName;
  final List<String> capitals;
  final String region;
  final String subregion;
  final int population;
  final double area;
  final List<String> languages;
  final List<String> currencies;
  final List<String> timezones;
  final String flagPng;
  final String flagAlt;

  String get capitalLabel =>
      capitals.isEmpty ? 'No capital listed' : capitals.join(', ');

  String get languagesLabel =>
      languages.isEmpty ? 'Not listed' : languages.join(', ');

  String get currenciesLabel =>
      currencies.isEmpty ? 'Not listed' : currencies.join(', ');

  String get timezoneLabel =>
      timezones.isEmpty ? 'Not listed' : timezones.join(', ');

  static Map<String, dynamic> _map(Object? value) {
    return value is Map<String, dynamic> ? value : const {};
  }

  static String _string(Object? value, {String fallback = 'Not listed'}) {
    if (value is String && value.trim().isNotEmpty) {
      return value;
    }
    return fallback;
  }

  static int _int(Object? value) {
    if (value is int) {
      return value;
    }
    return 0;
  }

  static double _double(Object? value) {
    if (value is num) {
      return value.toDouble();
    }
    return 0;
  }

  static List<String> _stringList(Object? value) {
    if (value is List) {
      return value
          .whereType<String>()
          .where((item) => item.trim().isNotEmpty)
          .toList();
    }
    return const [];
  }

  static List<String> _values(Object? value) {
    if (value is Map<String, dynamic>) {
      return value.values
          .whereType<String>()
          .where((item) => item.trim().isNotEmpty)
          .toList();
    }
    return const [];
  }

  static List<String> _currencyNames(Object? value) {
    if (value is! Map<String, dynamic>) {
      return const [];
    }

    return value.values
        .whereType<Map<String, dynamic>>()
        .map((currency) => _string(currency['name'], fallback: ''))
        .where((item) => item.isNotEmpty)
        .toList();
  }
}
