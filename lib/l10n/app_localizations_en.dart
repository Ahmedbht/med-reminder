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

  @override
  String get home => 'Home';

  @override
  String get history => 'History';

  @override
  String get reminderTime => 'Reminder time';

  @override
  String get note => 'Note (optional)';

  @override
  String get form => 'Form';

  @override
  String get pleaseEnterName => 'Please enter a medication name';

  @override
  String get noMedicationsYet => 'No medications added yet.';

  @override
  String get takenButton => 'Taken';

  @override
  String get greeting => 'Good day, Stay healthy and be Strong!';

  @override
  String get addFirstMedication => 'Add your first medication';

  @override
  String get keepUpGoodWork => 'Keep up the great work!';

  @override
  String get selectDateHistory => 'Select a date to see history';

  @override
  String get noRecordsForDay => 'No records for this day';

  @override
  String get myHistory => 'My History';

  @override
  String dosesTakenToday(int taken, int total) {
    return '$taken of $total doses taken today';
  }

  @override
  String aboutMedication(String name) {
    return 'About $name';
  }

  @override
  String errorPrefix(String message) {
    return 'Error: $message';
  }

  @override
  String get formTablet => 'Tablet';

  @override
  String get formCapsule => 'Capsule';

  @override
  String get formLiquid => 'Liquid';

  @override
  String get formInjection => 'Injection';
}
