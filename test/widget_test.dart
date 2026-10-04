import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:med_reminder/main.dart';
import 'package:med_reminder/providers/medication_provider.dart';

void main() {
  testWidgets('MediTrack app launches and shows home screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => MedicationProvider(),
        child: const MyApp(),
      ),
    );
    await tester.pump();

    expect(find.text('MediTrack'), findsWidgets);
  });

  testWidgets('switching locale to Arabic shows Arabic home greeting', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => MedicationProvider(),
        child: const MyApp(),
      ),
    );
    localeNotifier.value = const Locale('ar');
    await tester.pumpAndSettle();

    expect(find.text('يوم سعيد، ابقَ بصحة جيدة وكن قويًا!'), findsOneWidget);

    localeNotifier.value = const Locale('en');
  });
}
