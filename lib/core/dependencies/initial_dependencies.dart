import 'package:get/get.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/network/network.dart';
import 'package:gulf_car_auction/preference/preference.dart';

Future<void> init() async {
  // Local Storage
  Get.put<PreferenceController>(PreferenceController(sharedPreferences: Get.find()), permanent: true);

  //Api
  Get.put<ApiClient>(ApiClient(appBaseUrl: Environment.baseApiUrlV1, preferenceController: Get.find()), permanent: true);

  // Connectivity
  Get.put<ConnectivityController>(ConnectivityController(), permanent: true);

  // Global Controller & Repo
  Get.put<GlobalRepository>(GlobalRepository(apiClient: Get.find()), permanent: true);
  Get.put<GlobalController>(GlobalController(repo: Get.find()), permanent: true);
}