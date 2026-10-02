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

  @override
  String get home => 'الرئيسية';

  @override
  String get history => 'السجل';

  @override
  String get reminderTime => 'وقت التذكير';

  @override
  String get note => 'ملاحظة (اختياري)';

  @override
  String get form => 'الشكل';

  @override
  String get pleaseEnterName => 'الرجاء إدخال اسم الدواء';

  @override
  String get noMedicationsYet => 'لم تتم إضافة أي دواء بعد.';

  @override
  String get takenButton => 'تم أخذه';

  @override
  String get greeting => 'يوم سعيد، ابقَ بصحة جيدة وكن قويًا!';

  @override
  String get addFirstMedication => 'أضف أول دواء لك';

  @override
  String get keepUpGoodWork => 'واصل العمل الرائع!';

  @override
  String get selectDateHistory => 'اختر تاريخًا لعرض السجل';

  @override
  String get noRecordsForDay => 'لا توجد سجلات لهذا اليوم';

  @override
  String get myHistory => 'سجلي';
}
