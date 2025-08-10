import 'package:get/get.dart';
import 'package:gulf_car_auction/lang/lang.dart';
import 'package:gulf_car_auction/preference/preference.dart';

class LangHandler {
  void handleLanguageSelection(Language? language) async{
    final prefController = Get.find<PreferenceController>();
    if (language != null) {
      String code = language.code;

      await prefController.setString(PrefsKeys.appLangCode, value: code);

      if (code == 'en') {
        TranslationService.changeLocale('en');
      } else if (code == 'ar') {
        TranslationService.changeLocale('ar');
      } else {
        TranslationService.changeLocale('en');
      }

    }
  }
}