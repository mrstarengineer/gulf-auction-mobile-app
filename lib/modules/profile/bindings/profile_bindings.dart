import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/profile/profile.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileRepository>(() => ProfileRepository(apiClient: Get.find()), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(repo: Get.find()), fenix: true);
  }

}