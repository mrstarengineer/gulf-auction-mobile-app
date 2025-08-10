import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/splash/splash.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashRepository>(SplashRepository());
    Get.put<SplashController>(SplashController(repo: Get.find()));
  }
  
}