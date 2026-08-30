import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/medication_provider.dart';
import 'screens/home_screen.dart';
import 'services/notification_service.dart';
import 'screens/history_screen.dart';

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
    return MaterialApp(title: 'MediTrack', home: const RootScreen());
  }
}

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currenIndex = 0;

  final List<Widget> _screens = const [Homescreen(), HistoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currenIndex,
        onTap: (index) {
          setState(() {
            _currenIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
}
