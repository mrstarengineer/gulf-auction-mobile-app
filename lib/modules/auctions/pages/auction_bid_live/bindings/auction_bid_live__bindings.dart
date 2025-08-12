import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/auctions/pages/auction_bid_live/auction_bid.dart';

class AuctionBidLiveBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuctionBidLiveRepository(apiClient: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => AuctionBidLiveController(
            repo: Get.find(), preferenceController: Get.find()),
        fenix: true);

    //   PUSHER
    Get.lazyPut(
        () => PusherController(
            repo: Get.find(),
            preferenceController: Get.find(),
            pusherChannels: Get.find(),
            audioPlayer: Get.find()),
        fenix: true);
    Get.lazyPut(() => PusherRepository(apiClient: Get.find()), fenix: true);
  }
}
