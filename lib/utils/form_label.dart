import 'package:med_reminder/l10n/app_localizations.dart';

/// Returns the localized display label for a medication form stored in
/// English (e.g. "Tablet"), falling back to the raw value if unrecognized.
String formLabel(AppLocalizations l10n, String form) {
  switch (form) {
    case 'Capsule':
      return l10n.formCapsule;
    case 'Liquid':
      return l10n.formLiquid;
    case 'Injection':
      return l10n.formInjection;
    case 'Tablet':
      return l10n.formTablet;
    default:
      return form;
  }
}
