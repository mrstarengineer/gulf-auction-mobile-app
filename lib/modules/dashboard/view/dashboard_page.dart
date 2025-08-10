import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/modules/dashboard/dashboard.dart';
import 'package:gulf_car_auction/modules/dashboard/pages/home/home.dart';
import 'package:gulf_car_auction/preference/preference.dart';
import 'package:gulf_car_auction/routes/routes.dart';
import 'package:gulf_car_auction/settings/settings.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _globalController = Get.find<GlobalController>();
  final _homeController = Get.find<HomeController>();
  final _dashboardController = Get.find<DashboardController>();
  final _isUserLoggedIn =
      Get.find<PreferenceController>().containsKey(PrefsKeys.accessToken);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialApiCalls();
      _initialApiCallsHome();
    });
  }

  _initialApiCalls() {
    if (_isUserLoggedIn) {
      _globalController.fetchMe().then((response) {
        if (response.isSuccess) {
          if (_globalController.userInfo?.requiredDocuments ?? false) {
            Get.offAllNamed(AppRoutes.signUp + AppRoutes.signUpStepper,
                parameters: {'isDocumentsRequired': 'true'});
          }
        }
      });
    }
  }

  _initialApiCallsHome() {
    _homeController.fetchFilterVehicleOptions(loadingInitial: true);
    _homeController.fetchAuctionVehicles(loadingInitial: true);
    _homeController.fetchUpcomingAuctions(loadingInitial: true);
    if (_isUserLoggedIn) _homeController.fetchMemberDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => WillPopScope(
            onWillPop: () async {
              _onWillPop(context, dashboardController: _dashboardController);
              return false;
            },
            child: _dashboardController
                .screens[_dashboardController.selectedScreenIndex])),
        floatingActionButton: Transform.translate(
            offset: const Offset(0, 10),
            child: AppButtons.floatingActionBtn(context,
                svgIconPath: AppSvgIcons.addVehicle, onTap: () {
              final isUserLoggedIn = Get.find<PreferenceController>()
                  .containsKey(PrefsKeys.accessToken);
              if (isUserLoggedIn) {
                Get.toNamed(AppRoutes.addVehicle);
              } else {
                Get.toNamed(AppRoutes.signIn,
                    parameters: {'isFromGuestUser': 'true'});
              }
            })),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Obx(() => DashboardWidgets.bottomNavBar(
              currentIndex: _dashboardController.selectedScreenIndex,
              onScreenSelected: _dashboardController.updateSelectedScreenIndex,
            )));
  }
}

void _onWillPop(BuildContext context,
    {required DashboardController dashboardController}) {
  if (dashboardController.selectedScreenIndex == 0) {
    AppDialogs.closingConfirmation(context, onTapBtn2: () {
      SystemNavigator.pop();
    });
  } else {
    dashboardController.updateSelectedScreenIndex(0);
  }
}
