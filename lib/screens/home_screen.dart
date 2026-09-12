import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/medication_provider.dart';
import 'add_medication_screen.dart';

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
      appBar: AppBar(title: const Text('MediTrack')),
      body: Column(
        children: [
                    Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Text(
              'Good day 👋',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Text(
              total == 0 ? 'Add your first medication' : 'Keep up the great work!',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo[400]!, Colors.indigo[700]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 64,
                    height: 64,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 6,
                          backgroundColor: Colors.white24,
                          valueColor: const AlwaysStoppedAnimation(Colors.white),
                        ),
                        Text(
                          '${(progress * 100).round()}%',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      '$taken of $total doses taken today',
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: medProvider.medications.isEmpty
                ? const Center(child: Text('No medications added yet.'))
                  : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
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
                          elevation: 2,
                          shadowColor: Colors.black26,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.teal[50],
                                  child: const Icon(Icons.medication, color: Colors.teal),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        med.name,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${med.dosage} • ${med.form} • ${med.time}',
                                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                                med.isTaken
                                    ? const Icon(Icons.check_circle, color: Colors.green, size: 28)
                                    : ElevatedButton(
                                        onPressed: () {
                                          medProvider.markAsTaken(med.id);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(horizontal: 12),
                                        ),
                                        child: const Text('Taken', style: TextStyle(fontSize: 12)),
                                      ),
                              ],
                              ),
              ),
                      ),
                      );
                       },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddMedicationScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Medication'),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}