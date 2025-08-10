import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/modules/dashboard/dashboard.dart';
import 'package:gulf_car_auction/modules/dashboard/pages/more/more.dart';
import 'package:gulf_car_auction/preference/preference.dart';
import 'package:gulf_car_auction/routes/routes.dart';
import 'package:gulf_car_auction/settings/settings.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  final _globalController = Get.find<GlobalController>();
  final _dashboardController = Get.find<DashboardController>();
  final _prefsController = Get.find<PreferenceController>();
  final _isUserLoggedIn =
      Get.find<PreferenceController>().containsKey(PrefsKeys.accessToken);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isUserLoggedIn) {
        _initialApiCalls();
      }
    });
  }

  _initialApiCalls() {
    _globalController.fetchMe().then((response) {
      if (response.isSuccess) {
        if (_globalController.userInfo?.requiredDocuments ?? false) {
          Get.offAllNamed(AppRoutes.signUp + AppRoutes.signUpStepper,
              parameters: {'isDocumentsRequired': 'true'});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MorePageWidgets.appBar(
          isUserLoggedIn: _isUserLoggedIn,
          onTapBack: () {
            _dashboardController.updateSelectedScreenIndex(0);
          },
          onTapLogout: () {
            AppDialogs.closingConfirmation(context,
                title: 'Do You Want to Log Out?',
                btn2Text: 'Logout', onTapBtn2: () {
              _prefsController.clearData();
              Get.offAllNamed(AppRoutes.signIn);
            });
          }),
      body: !_isUserLoggedIn
          ? AppAlertMessages.loginAlert()
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // HEADER
                  Obx(() => MorePageWidgets.header(
                        profilePicUrl: _globalController.userInfo?.profilePhoto,
                        name: _globalController.userInfo?.name,
                        accountTypeName:
                            _globalController.userInfo?.accountTypeName,
                        roleName: _globalController.userInfo?.roleName,
                      )),

                  SizedBox(
                    height: Dimensions.getHeight(12),
                  ),

                  // BODY
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: MorePageWidgets.body(onTap: (optionName) {
                        /// ACCOUNT OPTIONS
                        if (optionName == MAccountOptions.myProfile) {
                          //   CALLING MY PROFILE
                          Get.toNamed(AppRoutes.profile);
                        } else if (optionName == MAccountOptions.myDocuments) {
                          //   CALLING MY DOCUMENTS
                          Get.toNamed(AppRoutes.myDocuments);
                        } else if (optionName == MAccountOptions.watchList) {
                          //   CALLING MY WATCH LIST
                          Get.toNamed(AppRoutes.watchedVehicle);
                        }

                        /// BID STATUS OPTIONS
                        else if (optionName == MBidStatusOptions.preBid) {
                          //   CALLING MY BID
                          Get.toNamed(AppRoutes.bidsView,
                              arguments: MBidStatusOptions.preBid);
                        } else if (optionName ==
                            MBidStatusOptions.vehiclesWon) {
                          //   CALLING LOTS WON
                          Get.toNamed(AppRoutes.bidsView,
                              arguments: MBidStatusOptions.vehiclesWon);
                        } else if (optionName ==
                            MBidStatusOptions.vehiclesLoss) {
                          //   CALLING LOTS LOSS
                          Get.toNamed(AppRoutes.bidsView,
                              arguments: MBidStatusOptions.vehiclesLoss);
                        } else if (optionName ==
                            MBidStatusOptions.vehiclesOnApproval) {
                          //   CALLING VEHICLE ON APPROVAL
                          Get.toNamed(AppRoutes.bidsView,
                              arguments: MBidStatusOptions.vehiclesOnApproval);
                        }

                        /// AUCTIONS OPTIONS
                        else if (optionName == MAuctionsOptions.todaysAuction) {
                          //   CALLING TODAY AUCTION
                          Get.toNamed(AppRoutes.auctionList);
                        } else if (optionName == MAuctionsOptions.joinAuction) {
                          //   CALLING JOIN AUCTION
                          _dashboardController.updateSelectedScreenIndex(1);
                        } else if (optionName ==
                            MAuctionsOptions.auctionCalender) {
                          //   CALLING AUCTION CALENDER
                          Get.toNamed(AppRoutes.auctionCalender);
                        }

                        /// SELL MY CARS OPTIONS
                        else if (optionName ==
                            MSellMyCarOptions.pendingVehicle) {
                          //   CALLING ON APPROVAL CARS
                          Get.toNamed(AppRoutes.myCars,
                              arguments: MSellMyCarOptions.pendingVehicle);
                        } else if (optionName ==
                            MSellMyCarOptions.documentStatus) {
                          //   CALLING ON APPROVAL CARS
                          Get.toNamed(AppRoutes.myCars,
                              arguments: MSellMyCarOptions.documentStatus);
                        } else if (optionName ==
                            MSellMyCarOptions.returnVehicle) {
                          //   CALLING ON APPROVAL CARS
                          Get.toNamed(AppRoutes.myCars,
                              arguments: MSellMyCarOptions.returnVehicle);
                        } else if (optionName == MSellMyCarOptions.allVehicle) {
                          //   CALLING ALL CARS
                          Get.toNamed(AppRoutes.myCars,
                              arguments: MSellMyCarOptions.allVehicle);
                        } else if (optionName == MSellMyCarOptions.inStock) {
                          //   CALLING INVENTORY
                          Get.toNamed(AppRoutes.myCars,
                              arguments: MSellMyCarOptions.inStock);
                        } else if (optionName == MSellMyCarOptions.inAuction) {
                          //   CALLING AUCTION CARS
                          Get.toNamed(AppRoutes.myCars,
                              arguments: MSellMyCarOptions.inAuction);
                        } else if (optionName ==
                            MSellMyCarOptions.sellingApprovalVehicle) {
                          //   CALLING SELLING APPROVAL CARS
                          Get.toNamed(AppRoutes.myCars,
                              arguments:
                                  MSellMyCarOptions.sellingApprovalVehicle);
                        } else if (optionName ==
                            MSellMyCarOptions.soldVehicle) {
                          //   CALLING ON SOLD CARS
                          Get.toNamed(AppRoutes.myCars,
                              arguments: MSellMyCarOptions.soldVehicle);
                        } else if (optionName ==
                            MSellMyCarOptions.unsoldVehicle) {
                          //   CALLING ON UNSOLD CARS
                          Get.toNamed(AppRoutes.myCars,
                              arguments: MSellMyCarOptions.unsoldVehicle);
                        } else if (optionName ==
                            MSellMyCarOptions.rejectedVehicle) {
                          //   CALLING ON REJECTED CARS
                          Get.toNamed(AppRoutes.myCars,
                              arguments: MSellMyCarOptions.rejectedVehicle);
                        }

                        /// PAYMENT OPTIONS
                        else if (optionName == MPaymentOptions.paymentDue) {
                          //   CALLING PAYMENT DUE
                          Get.toNamed(AppRoutes.paymentDue,
                              arguments: MPaymentOptions.paymentDue);
                        } else if (optionName ==
                            MPaymentOptions.paymentHistory) {
                          Get.toNamed(AppRoutes.paymentDue,
                              arguments: MPaymentOptions.paymentHistory);
                          //   CALLING PAYMENT HISTORY
                        } else if (optionName == MPaymentOptions.myAccount) {
                          Get.toNamed(AppRoutes.accounts);
                          //   CALLING PAYMENT HISTORY
                        } else if (optionName ==
                            MPaymentOptions.depositAccount) {
                          //   CALLING DEPOSIT ACCOUNT
                          Get.toNamed(AppRoutes.depositPayment,
                              arguments: MPaymentOptions.depositAccount);
                        } else if (optionName ==
                            MPaymentOptions.onlineAccount) {
                          //   CALLING ONLINE ACCOUNT
                          Get.toNamed(AppRoutes.accounts,
                              arguments: MPaymentOptions.onlineAccount);
                        } else if (optionName ==
                            MPaymentOptions.bookedVehicleDue) {
                          //   CALLING BOOKED VEHICLE DUE
                        } else if (optionName ==
                            MPaymentOptions.bookedPaymentHistory) {
                          //   CALLING BOOKED PAYMENT HISTORY
                        }

                        /// DOWNLOAD AND CAREER OPTIONS
                        else if (optionName == MMoreOptions.downloads) {
                          //   CALLING DOWNLOADS
                          Get.toNamed(AppRoutes.downloads);
                        } else if (optionName == MMoreOptions.career) {
                          //   CALLING CAREER
                          Get.toNamed(AppRoutes.career);
                        } else if (optionName == MMoreOptions.contact) {
                          //   CALLING CONTACT
                          Get.toNamed(AppRoutes.contact);
                        }
                      }),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
