import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/contact/contact.dart';

class ContactBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactRepository>(()=>ContactRepository(apiClient: Get.find()), fenix: true);
    Get.lazyPut<ContactController>(()=>ContactController(repo: Get.find()), fenix: true);
  }

}