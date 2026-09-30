// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'ميدي تراك';

  @override
  String get addMedication => 'إضافة دواء';

  @override
  String get medicationName => 'اسم الدواء';

  @override
  String get dosage => 'الجرعة (مثال: 500 ملغ)';

  @override
  String get saveMedication => 'حفظ الدواء';
}
