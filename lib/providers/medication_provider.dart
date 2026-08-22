import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/medication.dart';

class MedicationProvider extends ChangeNotifier {
  final _uuid = const Uuid();
  List<Medication> _medications = [];

  static const String _storageKey = 'medications';

  Future<void> loadMedications() async {
    final prefs = await sharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);

    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      _medications = jsonList.map((json) => Medication.fromJson(json)).toList();
    }
    notifyListeners();
  }

  Future<void> saveMedications() async {
    final prefs = await sharedPreferences.getInstance();
    final jsonList = _medications.map((m) => m.toJson()).toList();
    await prefs.setString(_storageKey, json.encode(jsonList));
  }

  //add a brand new medication
  Future<void> addMedication({
    required String name,
    required String dosage,
    required String form,
    required String time,
    String note = '',
  }) async {
    //for building a new medication object
    final med = Medication(
      id: _uuid.v4(), // generate unique ID
      name: name,
      dosage: dosage,
      form: form,
      time: time,
      note: note,
    );
    medications.add(med);
    await saveMedications();
    notifyListeners();
  }
}
