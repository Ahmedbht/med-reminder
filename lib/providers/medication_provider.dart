import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/medication.dart';

class MedicationProvider extends ChangeNotifier {
  final _uuid = const Uuid();
  List<Medication> medications = [];

  static const String _storageKey = 'medications';

  Future<void> loadMedications() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);

    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      medications = jsonList.map((json) => Medication.fromJson(json)).toList();
    }
    notifyListeners();
  }

  Future<void> saveMedications() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = medications.map((m) => m.toJson()).toList();
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

  //marks a medication as taken (a specefic med)
  Future<void> markAsTaken(String id) async {
    final med = medications.firstWhere((m) => m.id == id);
    med.isTaken = true;
    med.isMissed = false;
    await saveMedications();
    notifyListeners();
  }

  // remove from list
  Future<void> deleteMedication(String id) async {
    medications.removeWhere((m) => m.id == id);
    await saveMedications();
    notifyListeners();
  }

  int get takenCount => medications.where((m) => m.isTaken).length;
  int get totalCount => medications.length;
}