import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/downloads/downloads.dart';

class DownloadsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DownloadsRepository>(()=>DownloadsRepository(apiClient: Get.find()), fenix: true);
    Get.lazyPut<DownloadsController>(()=>DownloadsController(repo: Get.find()), fenix: true);
  }

}