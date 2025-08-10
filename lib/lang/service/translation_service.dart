import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/preference/preference.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import '../value/value.dart';


class TranslationService extends Translations {

  static String _getSavedLanguage() => Get.find<PreferenceController>().getString(PrefsKeys.appLangCode);

  static var savedLanguage = _getSavedLanguage();


  static Locale? get locale {
    switch (savedLanguage) {
      case AppLanguagesCode.arabic:
        return AppLanguagesLocales.arabic;
      case AppLanguagesCode.english:
        return AppLanguagesLocales.english;
      default:
        return AppLanguagesLocales.english;
    }
  }



  static final fallbackLocale = AppLanguagesLocales.english;


  static void changeLocale(String langCode) {
    final locale = _getLocaleFromLanguage(langCode: langCode);
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en,
    'ar_AE': ar,
  };

  static final _langCodes = ['en', 'ar'];

  static final _locales = [
    const Locale('en', 'US'),
    const Locale('ar', 'AE'),
  ];

  static Locale _getLocaleFromLanguage({String? langCode}) {
    var lang = langCode ?? Get.deviceLocale?.languageCode;
    for (int i = 0; i < _langCodes.length; i++) {
      if (lang == _langCodes[i]) return _locales[i];
    }
    return Get.locale!;
  }
}