import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/medication.dart';

class MedicationProvider extends ChangeNotifier{
  final _uuid = const Uuid();
  List<Medication> _medications = [];

  static const String _storageKey ='medications';

  Future<void> loadMedications() async{
    final prefs = await sharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);

    
  }
}