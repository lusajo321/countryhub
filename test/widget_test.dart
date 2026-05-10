import 'package:countryhub/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CountryHub renders search experience', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CountryHubApp());

    expect(find.text('CountryHub'), findsOneWidget);
    expect(find.text('Country lookup'), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
    expect(find.text('Start with a country name'), findsOneWidget);

    await tester.tap(find.byTooltip('Open country input'));
    await tester.pumpAndSettle();

    expect(find.text('Search a country'), findsAtLeastNWidgets(1));
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Get country info'), findsOneWidget);
  });
}
