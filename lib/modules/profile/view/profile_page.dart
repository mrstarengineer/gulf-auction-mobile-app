import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/modules/profile/profile.dart';
import 'package:gulf_car_auction/routes/routes.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/toasts/app_toasts.dart';

import '../../../preference/preference.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TabController _tabController;
  final _globalController = Get.find<GlobalController>();
  final _profileController = Get.find<ProfileController>();
  final _prefsController = Get.find<PreferenceController>();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  clearPassControllers() {
    _profileController.oldPassController.clear();
    _profileController.newPassController.clear();
    _profileController.confirmPassController.clear();
    _tabController.index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBar(title: 'Profile'),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.getHeight(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() => ProfileWidgets.header(
                profilePicUrl: _globalController.userInfo?.profilePhoto,
                name: _globalController.userInfo?.name,
                accountTypeName: _globalController.userInfo?.accountTypeName,
                roleName: _globalController.userInfo?.roleName,
                onTapProfilePhoto: (url) {
                  Get.toNamed(AppRoutes.filesPreview, arguments: url);
                },
                onTapUpdateProfilePhoto: (imgPath) {
                  context.showLoaderOverlay;
                  _profileController
                      .uploadProfilePhoto(imgPath: imgPath)
                      .then((response) {
                    context.hideLoaderOverlay;
                    if (response.isSuccess) {
                      _globalController.fetchMe().then((meResponse) {
                        if (!response.isSuccess) {
                          AppToasts.shortToast(response.message);
                        }
                      });
                    } else {
                      AppToasts.shortToast(response.message);
                    }
                  });
                })),

            SizedBox(
              height: Dimensions.getHeight(12),
            ),

            // BODY
            ProfileWidgets.tabBar(
              controller: _tabController,
              title1: 'Personal',
              title2: 'Password',
              title3: 'Account Control',
            ),

            SizedBox(
              height: Dimensions.getHeight(12),
            ),

            ProfileWidgets.tabBarBody(
              formKey: _formKey,
              controller: _tabController,
              fName: _globalController.userInfo?.firstName,
              lName: _globalController.userInfo?.lastName,
              phone: _globalController.userInfo?.primaryPhone,
              status: _globalController.userInfo?.statusName,
              email: _globalController.userInfo?.email,
              country: _globalController.userInfo?.countryName,
              address: _globalController.userInfo?.address,
              oldPassController: _profileController.oldPassController,
              confirmNewPassController:
                  _profileController.confirmPassController,
              newPassController: _profileController.newPassController,
              onTapUpdatePass: () {
                if (_formKey.currentState!.validate()) {
                  context.showLoaderOverlay;
                  _profileController.updatePass().then((response) {
                    context.hideLoaderOverlay;
                    if (response.isSuccess) {
                      clearPassControllers();
                    }
                    AppToasts.shortToast(response.message);
                  });
                }
              },
              onTapDeleteAccount: () {
                // This is where you would call your delete account API
                context.showLoaderOverlay;
                _profileController.accountDeletion().then((response) {
                  // Assuming _profileController has accountDeletion method
                  context.hideLoaderOverlay;
                  if (response.isSuccess) {
                    // Handle successful deletion, e.g., navigate to login screen
                    AppToasts.shortToast(
                        'Your account has been successfully deleted.');
                    _prefsController.clearData();
                    Get.offAllNamed(AppRoutes.signIn);
                  } else {
                    AppToasts.shortToast(response.message);
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
