import 'package:get/get.dart';

import '../auctions_list.dart';

class AuctionsListBindings extends Bindings {
  @override
  void dependencies() {

    // AUCTIONS
    Get.lazyPut<AuctionsListRepository>(() => AuctionsListRepository(apiClient: Get.find()), fenix: true);
    Get.lazyPut<AuctionsListController>(() => AuctionsListController(repo: Get.find()), fenix: true);
  }

}