import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/notification/notification.dart';

class NotificationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationRepository>(() => NotificationRepository(apiClient: Get.find()), fenix: true);
    Get.lazyPut<NotificationController>(() => NotificationController(repo: Get.find()), fenix: true);
  }

}