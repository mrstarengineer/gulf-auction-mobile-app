import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/modules/splash/repository/splash_repository.dart';
import 'package:gulf_car_auction/preference/preference.dart';
import 'package:gulf_car_auction/routes/routes.dart';

class SplashController extends GetxController {

  SplashController({required SplashRepository repo});

  final globalController = Get.find<GlobalController>();

  @override
  void onReady() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(milliseconds: 1500)).whenComplete(() async{
      final isUserLoggedIn = Get.find<PreferenceController>().containsKey(PrefsKeys.accessToken);
      if(isUserLoggedIn){
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        Get.offAllNamed(AppRoutes.signIn);
      }
    });
    super.onReady();
  }

  @override
  void onClose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.onClose();
  }

}