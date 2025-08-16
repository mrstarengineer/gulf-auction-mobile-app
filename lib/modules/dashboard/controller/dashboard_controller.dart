import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/dashboard/dashboard.dart';
import 'package:gulf_car_auction/modules/dashboard/pages/all_vehicles/view/all_vehicle_page.dart';
import 'package:gulf_car_auction/modules/dashboard/pages/home/home.dart';
import 'package:gulf_car_auction/modules/dashboard/pages/join_auction/join_auction.dart';
import 'package:gulf_car_auction/modules/dashboard/pages/more/more.dart';

class DashboardController extends GetxController {
  DashboardController({required DashboardRepository repo});

  final _selectedScreenIndex = 0.obs;

  int get selectedScreenIndex => _selectedScreenIndex.value;

  set selectedScreenIndex(value) => _selectedScreenIndex.value = value;

  updateSelectedScreenIndex (value) => selectedScreenIndex = value;

  final screens = [
    const HomePage(),
    const JoinAuctionPage(),
    const AllVehiclePage(),
    const MorePage()
  ];
}