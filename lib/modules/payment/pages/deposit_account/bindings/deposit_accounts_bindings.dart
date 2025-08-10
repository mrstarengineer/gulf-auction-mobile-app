import 'package:get/get.dart';

import '../deposit_accounts.dart';

class DepositAccountBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DepositAccountRepository>(
        () => DepositAccountRepository(apiClient: Get.find()),
        fenix: true);
    Get.lazyPut<DepositAccountController>(
        () => DepositAccountController(repo: Get.find()),
        fenix: true);
  }
}
