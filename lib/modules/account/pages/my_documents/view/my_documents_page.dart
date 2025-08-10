import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/account/account.dart';
import 'package:gulf_car_auction/routes/app_pages/app_pages.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/utils.dart';

import '../../../../../global/global.dart';

class MyDocumentsPage extends StatefulWidget {
  const MyDocumentsPage({super.key});

  @override
  State<MyDocumentsPage> createState() => _MyDocumentsPageState();
}

class _MyDocumentsPageState extends State<MyDocumentsPage> {
  final _myDocumentsController = Get.find<MyDocumentsController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
        _initialApiCalls();
    });
    super.initState();
  }

  _initialApiCalls (){
    _myDocumentsController.fetchDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBar(title: 'My Documents'),
      body: Obx((){
        if(_myDocumentsController.isLoading){
          return AppLoaders.loaderWithText();
        } else {
          return MyDocumentsWidgets.myDocuments(
              documents: _myDocumentsController.documentsInfo?.data,
              onTapAttachment: (url) {
                final extension = getFileExtension(url);
                if(extension == 'jpg' || extension == 'png' || extension == 'pdf'){
                  Get.toNamed(AppRoutes.filesPreview, arguments: url);
                } else {
                  AppToasts.shortToast(Strings.unsupportedFileFormat);
                }
              }
          );
        }
      }),
    );
  }
}
