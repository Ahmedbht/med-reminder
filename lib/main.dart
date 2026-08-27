import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/medication_provider.dart';
import 'screens/home_screen.dart';
import 'services/notification_service.dart';

final notificationService = NotificationService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await notificationService.init();
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
