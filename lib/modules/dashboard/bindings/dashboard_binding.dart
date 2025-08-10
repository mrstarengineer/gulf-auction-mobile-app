import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/dashboard/dashboard.dart';
import 'package:gulf_car_auction/modules/dashboard/pages/buy_now_vehicles/buy_now_vehicle.dart';
import 'package:gulf_car_auction/modules/dashboard/pages/home/home.dart';
import 'package:gulf_car_auction/modules/dashboard/pages/join_auction/join_auction.dart';
import 'package:gulf_car_auction/modules/vehicle/pages/filter_vehicle/filter_vehicle.dart';


class DashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<DashboardRepository>(DashboardRepository(apiClient: Get.find()));
    Get.put<DashboardController>(DashboardController(repo: Get.find()));

    // Filter Vehicle
    Get.put<FilterVehicleRepository>(FilterVehicleRepository(apiClient: Get.find()));
    Get.put<FilterVehicleController>(FilterVehicleController(repo: Get.find()));

    // HOME
    Get.lazyPut<HomeRepository>(() => HomeRepository(apiClient: Get.find()), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(repo: Get.find()), fenix: true);

    // JOIN AUCTIONS
    Get.lazyPut<JoinAuctionRepository>(() => JoinAuctionRepository(apiClient: Get.find()), fenix: true);
    Get.lazyPut<JoinAuctionController>(() => JoinAuctionController(repo: Get.find()), fenix: true);

    // BUY NOW VEHICLES
    Get.lazyPut<BuyNowVehicleRepository>(() => BuyNowVehicleRepository(apiClient: Get.find()), fenix: true);
    Get.lazyPut<BuyNowVehicleController>(() => BuyNowVehicleController(repo: Get.find()), fenix: true);
  }

}
