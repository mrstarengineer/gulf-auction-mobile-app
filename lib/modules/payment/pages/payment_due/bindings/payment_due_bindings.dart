import 'package:get/get.dart';

import '../payment_due.dart';

class PaymentDueBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentDueRepository>(
        () => PaymentDueRepository(apiClient: Get.find()),
        fenix: true);
    Get.lazyPut<PaymentDueController>(
        () => PaymentDueController(repo: Get.find()),
        fenix: true);
  }
}
