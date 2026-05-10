import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/country_provider.dart';
import 'screens/home_screen.dart';
import 'services/country_api_service.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const CountryHubApp());
}

class CountryHubApp extends StatelessWidget {
  const CountryHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CountryProvider(CountryApiService()),
      child: Consumer<CountryProvider>(
        builder: (context, provider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'CountryHub',
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: provider.themeMode,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
