import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/medication_provider.dart';
import '../main.dart';

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

  String _formLabel(AppLocalizations l10n, String form) {
    switch (form) {
      case 'Capsule':
        return l10n.formCapsule;
      case 'Liquid':
        return l10n.formLiquid;
      case 'Injection':
        return l10n.formInjection;
      default:
        return l10n.formTablet;
    }
  }

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

  void _save() {
    final l10n = AppLocalizations.of(context)!;
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.pleaseEnterName)));
      return;
    }

    final timeString = _selectedTime.format(context);

    Provider.of<MedicationProvider>(context, listen: false).addMedication(
      name: _nameController.text.trim(),
      dosage: _dosageController.text.trim(),
      form: _form,
      time: timeString,
      note: _noteController.text.trim(),
    );

    notificationService.scheduleNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: l10n.timeToTake(_nameController.text.trim()),
      body: '${_dosageController.text.trim()} - $_form',
      hour: _selectedTime.hour,
      minute: _selectedTime.minute,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addMedication)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: l10n.medicationName,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _dosageController,
              decoration: InputDecoration(labelText: l10n.dosage),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _form,
              decoration: InputDecoration(labelText: l10n.form),
              items: _formOptions.map((f) {
                return DropdownMenuItem(
                  value: f,
                  child: Text(_formLabel(l10n, f)),
                );
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
              title: Text(l10n.reminderTime),
              subtitle: Text(_selectedTime.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: _pickTime,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: l10n.note,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(l10n.saveMedication),
            ),
          ],
        ),
      ),
    );
  }
}
