import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/medication_provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});
  @override
  State<Homescreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MedicationProvider>(context, listen: false).loadMedications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final medProvider = Provider.of<MedicationProvider>(context);


    return Scaffold(
      appBar: AppBar(title: const Text('MediTrack')),
      body:medProvider.medications.isEmpty
          ? const Center(child : Text('No medications added yet.'))
          : ListView.builder(
            
          )
    )
  }
}
