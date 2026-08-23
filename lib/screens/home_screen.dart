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
      body: medProvider.medications.isEmpty
          ? const Center(child: Text('No medications added yet.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: medProvider.medications.length,
              itemBuilder: (context, index) {
                final med = medProvider.medications[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  child: ListTile(
                    title: Text(med.name),
                    subtitle: Text('${med.dosage} - ${med.form} at ${med.time}'),
                    trailing: med.isTaken
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : ElevatedButton(
                            onPressed: () {
                              medProvider.markAsTaken(med.id);
                            },
                            child: const Text('Mark as Taken'),
                          ),
                  ),
                );
              },
            ),
    );
  }
}
