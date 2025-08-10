import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/vehicle/pages/add_vehicle/add_vehicle.dart';

class AddVehicleBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddVehicleRepository>(() => AddVehicleRepository(apiClient: Get.find()), fenix: true);
    Get.lazyPut<AddVehicleController>(() => AddVehicleController(repo: Get.find()), fenix: true);
  }

}