import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/medication_provider.dart';
import 'add_medication_screen.dart';
import '../main.dart';

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
    final total = medProvider.totalCount;
    final taken = medProvider.takenCount;
    final progress = total == 0 ? 0.0 : taken / total;

    return Scaffold(
            appBar: AppBar(
        title: const Text('MediTrack'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              notificationService.showTestNotification();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 6,
                            backgroundColor: Colors.blue[100],
                          ),
                          Text('${(progress * 100).round()}%'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text('$taken of $total doses taken today'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: medProvider.medications.isEmpty
                ? const Center(child: Text('No medications added yet.'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: medProvider.medications.length,
                    itemBuilder: (context, index) {
                      final med = medProvider.medications[index];
                      final borderColor = med.isTaken
                          ? Colors.green
                          : med.isMissed
                              ? Colors.red
                              : Colors.blue;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          border: Border(left: BorderSide(color: borderColor, width: 4)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Card(
                          margin: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
                          ),
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
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddMedicationScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}