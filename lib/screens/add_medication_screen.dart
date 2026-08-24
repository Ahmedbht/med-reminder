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
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: const Text('Add Medication')),
    body: Padding(padding:  ,))
}
}
