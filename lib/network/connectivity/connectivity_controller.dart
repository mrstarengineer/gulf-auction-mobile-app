import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/helper/app_helper/app_helper.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ConnectivityController extends GetxController {
  final _connectionType = MConnectivityResult.none.obs;
  final Connectivity _connectivity = Connectivity();

  MConnectivityResult get connectionType => _connectionType.value;

  set connectionType(value) {
    _connectionType.value = value;
  }


  @override
  void onInit() {
    getConnectivityType();
    super.onInit();
  }

  Future<void> getConnectivityType() async {
    late List<ConnectivityResult>  connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      log('connectivity checking error: $e');
    }
    return _updateConnectionStatus(connectivityResult);
  }

  void _updateConnectionStatus (List<ConnectivityResult> connectivityResult){
    bool isLoaderOverlayVisible = Get.overlayContext?.loaderOverlay.visible ?? false;
    if( connectivityResult.contains(ConnectivityResult.mobile)){
    connectionType = MConnectivityResult.mobile;
    if(Get.isDialogOpen ?? false){
      Get.back();
    }
    } else if( connectivityResult.contains(ConnectivityResult.wifi)){
      connectionType = MConnectivityResult.wifi;
      if(Get.isDialogOpen ?? false){
        Get.back();
      }
    } else if( connectivityResult.contains(ConnectivityResult.none)){
      connectionType = MConnectivityResult.none;
      if(isLoaderOverlayVisible){
        Get.overlayContext!.loaderOverlay.hide();
      }
      showDialog('No internet connection');

    } else {
      if(isLoaderOverlayVisible){
        Get.overlayContext!.loaderOverlay.hide();
      }
      if(Get.isDialogOpen ?? false){
        Get.back();
      }
      ePrintWrapped('Failed to get connection type');
    }
  }
}

void showDialog (String message){
  Get.dialog(
    WillPopScope(
      onWillPop: () async => false,
      child: SimpleDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(8), vertical: Dimensions.getHeight(14)),
        children: [
          Icon(Icons.wifi_off, size: Dimensions.getHeight(40),),
          SizedBox(height: Dimensions.getHeight(12),),
          AppTexts.smallText(text: message, textAlign: TextAlign.center, overflow: TextOverflow.visible),
        ],
      ),
    ),
    barrierDismissible: false,
  );
}

enum MConnectivityResult { none, wifi, mobile }