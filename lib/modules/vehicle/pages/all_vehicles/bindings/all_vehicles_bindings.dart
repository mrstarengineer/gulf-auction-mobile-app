import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/vehicle/pages/all_vehicles/all_vehicles.dart';

class AllVehiclesBindings extends Bindings {
  @override
  void dependencies() {
    // All Vehicles
    Get.lazyPut<AllVehiclesRepository>(() => AllVehiclesRepository(apiClient: Get.find()), fenix: true);
    Get.lazyPut<AllVehiclesController>(() => AllVehiclesController(repo: Get.find()), fenix: true);
  }

}