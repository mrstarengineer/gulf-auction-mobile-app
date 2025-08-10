import 'package:get/get.dart';

import '../sign_in.dart';

class SignInBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInRepository(apiClient: Get.find(), preferenceController: Get.find()), fenix: true);
    Get.lazyPut(() => SignInController(repo: Get.find()), fenix: true);
  }

}