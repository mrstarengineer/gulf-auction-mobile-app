import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/career/career.dart';

class CareerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CareerRepository>(()=>CareerRepository(apiClient: Get.find()), fenix: true);
    Get.lazyPut<CareerController>(()=>CareerController(repo: Get.find()), fenix: true);
  }

}