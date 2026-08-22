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
  
}
