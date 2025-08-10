import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/bids/bids_view/bids_view.dart';

class BidsViewBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BidsViewRepository>(() => BidsViewRepository(apiClient: Get.find()), fenix: true);
    Get.lazyPut<BidsViewController>(() => BidsViewController(repo: Get.find()), fenix: true);
  }

}