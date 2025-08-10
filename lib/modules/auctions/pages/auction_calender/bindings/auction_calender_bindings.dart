import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/auctions/pages/auction_calender/auction_calender.dart';

class AuctionCalenderBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuctionCalenderRepository>(() => AuctionCalenderRepository(apiClient: Get.find()), fenix: true);
    Get.lazyPut<AuctionCalenderController>(() => AuctionCalenderController(repo: Get.find()), fenix: true);
  }

}