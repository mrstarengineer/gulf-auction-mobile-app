import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/vehicle/pages/watched_vehicles/watched_vehicles.dart';

class WatchedVehiclesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WatchedVehiclesRepository>(() => WatchedVehiclesRepository(apiClient: Get.find()), fenix: true);
    Get.lazyPut<WatchedVehiclesController>(() => WatchedVehiclesController(repo: Get.find()), fenix: true);
  }

}