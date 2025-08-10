import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/sell_my_car/sell_my_car.dart';

class SellMyCarBindings extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut<SellMyCarRepository>(()=> SellMyCarRepository(apiClient: Get.find()), fenix: true);
   Get.lazyPut<SellMyCarController>(()=> SellMyCarController(repo: Get.find()), fenix: true);
  }

}