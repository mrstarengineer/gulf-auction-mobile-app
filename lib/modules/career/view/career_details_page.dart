import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/modules/career/career.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/utils.dart';

class CareerDetailsPage extends StatefulWidget {
  const CareerDetailsPage({super.key});

  @override
  State<CareerDetailsPage> createState() => _CareerDetailsPageState();
}

class _CareerDetailsPageState extends State<CareerDetailsPage> {

  final _careerController = Get.find<CareerController>();
  final _jobId = Get.parameters['jobId'] ?? '';
  final _jobTitle = Get.parameters['jobTitle'] ?? '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialApiCalls();
    });
  }

  _initialApiCalls() {
    _careerController.fetchJobs(jobId: _jobId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBar(
          title: _jobTitle != 'null' ? _jobTitle : 'Featured Jobs'),
      body: Obx(() {
        final info = _careerController.specificJob;
        if (_careerController.isLoading) {
          return AppLoaders.loaderWithText();
        } else if (_careerController.allJobsData.isEmpty) {
          return AppAlertMessages.emptyAlert();
        } else {
          return Column(
            children: [

              // JOB DETAILS
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.getHeight(22),
                        horizontal: Dimensions.getWidth(16)),
                    child: CareerWidgets.careerDetailsBody(
                      title: info?.jobTitle,
                      location: info?.jobLocation,
                      deadline: info?.applicationDeadlineFormatted,
                      description: info?.description,
                    ),
                  ),
                ),
              ),

              //   APPLY
              CareerWidgets.applyBtn(onTap: () {
                CareerWidgets.jobApplyModal(
                    context, careerController: _careerController,
                    nameController: _careerController.nameController,
                    fathersNameController: _careerController.fathersNameController,
                    emailController: _careerController.emailController,
                    phoneController: _careerController.phoneController,
                    yearController: _careerController.yearController,
                onUploadDocument: (filePath){
                      context.showLoaderOverlay;
                      _careerController.jobUploadResume(filePath: filePath).then((response){
                        context.hideLoaderOverlay;
                        if(!response.isSuccess){
                          AppToasts.shortToast(response.message);
                        }
                      });
                },
                  onTapSubmit: (){
                    context.showLoaderOverlay;
                    _careerController.jobApply(jobPostId: _jobId).then((response) {
                      context.hideLoaderOverlay;
                      if(response.isSuccess){
                        Get.back();
                        Get.back();
                      }
                      AppToasts.shortToast(response.message);
                    });
                  }
                );
              })

            ],
          );
        }
      }),
    );
  }
}
