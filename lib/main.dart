import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/medication_provider.dart';
import 'screens/home_screen.dart';
import 'services/notification_service.dart';

final notificationService = NotificationService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await notificationService.init();
  // TEMP SELF-TEST: schedule a reminder 1 minute from now, same code path as Add Medication.
  final testTime = DateTime.now().add(const Duration(minutes: 1));
  // ignore: avoid_print
  print('TEMP-TEST: scheduling for ${testTime.hour}:${testTime.minute}, now=${DateTime.now()}');
  notificationService
      .scheduleNotification(
        id: 999999,
        title: 'TEMP TEST reminder',
        body: 'should fire 1 minute after launch',
        hour: testTime.hour,
        minute: testTime.minute,
      )
      .then((_) => print('TEMP-TEST: scheduleNotification completed OK'))
      .catchError((e, st) => print('TEMP-TEST: scheduleNotification FAILED: $e\n$st'));
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MedicationProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'MediTrack', home: const Homescreen());
  }
}
