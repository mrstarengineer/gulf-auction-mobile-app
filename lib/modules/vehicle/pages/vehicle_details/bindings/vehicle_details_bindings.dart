import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/vehicle/pages/vehicle_details/vehicle_details.dart';

class VehicleDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehicleDetailsRepository>(() => VehicleDetailsRepository(apiClient: Get.find()), fenix: true);
    Get.lazyPut<VehicleDetailsController>(() => VehicleDetailsController(repo: Get.find()), fenix: true);
  }

}