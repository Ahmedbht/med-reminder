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
}
