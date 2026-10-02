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

  @override
  String get home => 'Accueil';

  @override
  String get history => 'Historique';

  @override
  String get reminderTime => 'Heure du rappel';

  @override
  String get note => 'Note (optionnel)';

  @override
  String get form => 'Forme';

  @override
  String get pleaseEnterName => 'Veuillez entrer un nom de médicament';

  @override
  String get noMedicationsYet => 'Aucun médicament ajouté pour le moment.';

  @override
  String get takenButton => 'Pris';

  @override
  String get greeting => 'Bonne journée, restez en bonne santé et soyez fort !';

  @override
  String get addFirstMedication => 'Ajoutez votre premier médicament';

  @override
  String get keepUpGoodWork => 'Continuez comme ça !';

  @override
  String get selectDateHistory => 'Sélectionnez une date pour voir l\'historique';

  @override
  String get noRecordsForDay => 'Aucun enregistrement pour ce jour';

  @override
  String get myHistory => 'Mon historique';

  @override
  String dosesTakenToday(int taken, int total) {
    return '$taken sur $total doses prises aujourd\'hui';
  }
}
