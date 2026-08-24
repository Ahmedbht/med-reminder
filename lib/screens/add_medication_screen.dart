import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/medication_provider.dart';

class AddMedicationScreen extends StatefulWidget {
  const AddMedicationScreen({super.key});

  @override
  State<AddMedicationScreen> createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _noteController = TextEditingController();
  String _form = 'Tablet';
  TimeOfDay _selectedTime = TimeOfDay.now();

  final List<String> _formOptions = [
    'Tablet',
    'Capsule',
    'Liquid',
    'Injection',
  ];

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _save(){
    if(_nameController.text.trim().isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter a medication name'),
      ));
      return;
    }

  final timeString = _selectedTime.format(context);

  Provider.of<MedicationProvider>(context, listen: false).addMedication( name :_nameController.text.trim(),
  dosage: _dosageController.text.trim(),
  form: _form,
  time :timeString,
  note: _noteController.text.trim(),);

  Navigator.pop(context);
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Medication')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Medication name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _dosageController,
              decoration: const InputDecoration(labelText: 'Dosage (e.g. 500mg)'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _form,
              decoration: const InputDecoration(labelText: 'Form'),
              items: _formOptions.map((f) {
                return DropdownMenuItem(value: f, child: Text(f));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _form = value!;
                });
              },
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Reminder time'),
              subtitle: Text(_selectedTime.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: _pickTime,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: 'Note (optional)'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _save,
              child: const Text('Save Medication'),
            ),
          ],
        ),
      ),
    );
  }
}