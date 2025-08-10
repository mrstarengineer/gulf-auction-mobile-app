import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/payment/pages/accounts/controller/my_account_controller.dart';
import 'package:gulf_car_auction/modules/payment/pages/accounts/repository/my_account_repository.dart';

class MyAccountBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<MyAccountRepository>(MyAccountRepository(apiClient: Get.find()));
    Get.put<MyAccountController>(MyAccountController(repo: Get.find()));
  }
}
