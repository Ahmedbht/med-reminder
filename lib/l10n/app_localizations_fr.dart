// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'MediTrack';

  @override
  String get addMedication => 'Ajouter un médicament';

  @override
  String get medicationName => 'Nom du médicament';

  @override
  String get dosage => 'Dosage (ex: 500mg)';

  @override
  String get saveMedication => 'Enregistrer';
}
