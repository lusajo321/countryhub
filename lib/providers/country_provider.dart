import 'package:flutter/material.dart';

import '../models/country.dart';
import '../services/country_api_service.dart';

class CountryProvider extends ChangeNotifier {
  CountryProvider(this._apiService);

  final CountryApiService _apiService;

  Country? _country;
  String? _error;
  bool _isLoading = false;
  ThemeMode _themeMode = ThemeMode.system;

  Country? get country => _country;
  String? get error => _error;
  bool get isLoading => _isLoading;
  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> searchCountry(String countryName) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _country = await _apiService.searchByName(countryName);
    } on CountryApiException catch (exception) {
      _country = null;
      _error = exception.message;
    } catch (_) {
      _country = null;
      _error = 'Check your connection and try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleTheme() {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
