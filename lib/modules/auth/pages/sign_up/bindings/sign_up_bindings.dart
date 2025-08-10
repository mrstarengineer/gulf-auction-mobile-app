import 'package:get/get.dart';

import '../sign_up.dart';

class SignUpBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpRepository(apiClient: Get.find()), fenix: true);
    Get.lazyPut(() => SignUpController(repo: Get.find()), fenix: true);
  }

}