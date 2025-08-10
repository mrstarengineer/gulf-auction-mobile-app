import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/account/account.dart';

class MyDocumentsBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MyDocumentsRepository>(() => MyDocumentsRepository(apiClient: Get.find()), fenix: true);
    Get.lazyPut<MyDocumentsController>(() => MyDocumentsController(repo: Get.find()), fenix: true);
  }

}