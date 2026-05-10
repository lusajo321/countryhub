import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/country.dart';

class CountryApiException implements Exception {
  const CountryApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

class CountryApiService {
  CountryApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const _fields = [
    'name',
    'capital',
    'region',
    'subregion',
    'population',
    'area',
    'languages',
    'currencies',
    'timezones',
    'flags',
  ];

  Future<Country> searchByName(String countryName) async {
    final query = countryName.trim();
    if (query.isEmpty) {
      throw const CountryApiException('Enter a country name to begin.');
    }

    final uri = Uri.https('restcountries.com', '/v3.1/name/$query', {
      'fields': _fields.join(','),
    });

    final response = await _client.get(uri);

    if (response.statusCode == 404) {
      throw CountryApiException('No country found for "$query".');
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw const CountryApiException(
        'Country data is temporarily unavailable.',
      );
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! List ||
        decoded.isEmpty ||
        decoded.first is! Map<String, dynamic>) {
      throw const CountryApiException(
        'Country data came back in an unexpected format.',
      );
    }

    return Country.fromJson(decoded.first as Map<String, dynamic>);
  }
}
