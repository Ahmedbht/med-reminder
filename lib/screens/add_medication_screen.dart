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


  
}
