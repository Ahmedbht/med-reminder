// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'MediTrack';

  @override
  String get addMedication => 'Add Medication';

  @override
  String get medicationName => 'Medication name';

  @override
  String get dosage => 'Dosage (e.g. 500mg)';

  @override
  String get saveMedication => 'Save Medication';
}
