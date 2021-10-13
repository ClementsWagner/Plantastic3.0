import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SystemLanguage {
  SystemLanguage(this.locale);

  final Locale locale;

  static SystemLanguage of(BuildContext context) {
    return Localizations.of<SystemLanguage>(context, SystemLanguage);
  }
}

class SystemLanguageDelegate extends LocalizationsDelegate<SystemLanguage> {
  const SystemLanguageDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'de'].contains(locale.languageCode);

  @override
  Future<SystemLanguage> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<SystemLanguage>(SystemLanguage(locale));
  }

  @override
  bool shouldReload(SystemLanguageDelegate old) => false;
}
