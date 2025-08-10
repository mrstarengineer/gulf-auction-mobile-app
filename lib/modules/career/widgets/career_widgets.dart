import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/modules/career/career.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/utils.dart';

class CareerWidgets {
  CareerWidgets._();

  static Widget header() {
    return Column(
      children: [
        AppTexts.mediumText(text: 'Join Our Team', fontWeight: FontWeight.bold),
        SizedBox(
          height: Dimensions.getHeight(24),
        ),
        AppTexts.mediumText(
            text:
                'Are you passionate about making a difference and shaping the future? Join our dynamic team of talented individuals who are dedicated to innovation, collaboration, and excellence. At Gulf Cars Auction, we believe in fostering a supportive and inclusive work environment where every team member is valued and empowered to thrive.',
            overflow: TextOverflow.visible,
            color: AppColors.grey)
      ],
    );
  }

  static Widget body(
      {required List<JobsInfo> jobsData, Function(int, String?)? onTap}) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: jobsData.length,
        separatorBuilder: (context, index) => SizedBox(
              height: Dimensions.getHeight(10),
            ),
        itemBuilder: (context, index) {
          final info = jobsData[index];
          return _jobTile(
              title: info.jobTitle,
              location: info.jobLocation,
              deadline: info.applicationDeadline,
              onTap: () {
                if (info.id != null) {
                  onTap?.call(info.id!, info.jobTitle);
                }
              });
        });
  }

  static Widget careerDetailsBody(
      {String? title,
      String? location,
      String? deadline,
      String? description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == null || title.isEmpty
            ? const SizedBox.shrink()
            : AppTexts.mediumText(text: title, fontWeight: FontWeight.bold),
        SizedBox(
          height: Dimensions.getHeight(title == null || title.isEmpty ? 0 : 4),
        ),
        location == null || location.isEmpty
            ? const SizedBox.shrink()
            : AppTexts.mediumText(text: 'Location: $location'),
        SizedBox(
          height: Dimensions.getHeight(
              location == null || location.isEmpty ? 0 : 4),
        ),
        AppTexts.mediumText(text: 'Company: ${Strings.appName}'),
        SizedBox(
          height: Dimensions.getHeight(4),
        ),
        deadline == null || deadline.isEmpty
            ? const SizedBox.shrink()
            : AppTexts.mediumText(
                text: 'Application Deadline: $deadline'),
        SizedBox(
          height: Dimensions.getHeight(16),
        ),
        description == null || description.isEmpty
            ? const SizedBox.shrink()
            : AppTexts.mediumText(text: 'Description:'),
        SizedBox(
          height: Dimensions.getHeight(
              description == null || description.isEmpty ? 0 : 4),
        ),
        description == null || description.isEmpty
            ? const SizedBox.shrink()
            : AppTexts.htmlText(text: description, color: AppColors.grey),
      ],
    );
  }

  static Widget applyBtn({VoidCallback? onTap}) {
    return Container(
      width: double.maxFinite,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.getHeight(10),
          horizontal: Dimensions.getWidth(25)),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.primaryColorLight))),
      child: SizedBox(
          width: Get.width * 0.35,
          child: AppButtons.btnWithBg(
              onTap: onTap,
              text: 'Apply Now',
              radius: Dimensions.getHeight(100))),
    );
  }

  static void jobApplyModal(
    BuildContext context, {
    required CareerController careerController,
    required TextEditingController nameController,
    required TextEditingController fathersNameController,
    required TextEditingController emailController,
    required TextEditingController phoneController,
    required TextEditingController yearController,
    ValueChanged<String>? onUploadDocument,
    VoidCallback? onTapSubmit,
  }) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
                Dimensions.getWidth(12)), // Adjust the radius value as needed
          ),
        ),
        builder: (_) {
          return Container(
            padding: EdgeInsets.only(
                left: Dimensions.getWidth(16),
                right: Dimensions.getWidth(16),
                top: Dimensions.getHeight(24),
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              physics:  const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTexts.mediumText(
                      text: 'Apply For Job',
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
                  SizedBox(
                    height: Dimensions.getHeight(16),
                  ),

                  // NAME AND FATHERS NAME
                  Row(
                    children: [
                      Expanded(
                          child: AppTextFields.textFieldWithTitle(
                              isDense: true,
                              title: 'Name', controller: nameController)),
                      SizedBox(
                        width: Dimensions.getWidth(6),
                      ),
                      Expanded(
                        child: AppTextFields.textFieldWithTitle(
                            isDense: true,
                            title: 'Father\'s Name',
                            controller: fathersNameController),
                      ),
                    ],
                  ),

                  // EMAIL AND PHONE
                  Row(
                    children: [
                      Expanded(
                        child: AppTextFields.textFieldWithTitle(
                            isDense: true,
                            keyboardType: TextInputType.emailAddress,
                            title: 'Email',
                            controller: emailController),
                      ),
                      SizedBox(
                        width: Dimensions.getWidth(6),
                      ),
                      Expanded(
                        child: AppTextFields.textFieldWithTitle(
                            isDense: true,
                            keyboardType: TextInputType.phone,
                            title: 'Phone',
                            controller: phoneController),
                      ),
                    ],
                  ),

                  // YEAR OF EXPERIENCE
                  Row(
                    children: [
                      Expanded(
                        child: AppTextFields.textFieldWithTitle(
                          isDense: true,
                            keyboardType: TextInputType.number,
                            title: 'Year\'s of Experience',
                            controller: yearController),
                      ),
                      SizedBox(
                        width: Dimensions.getWidth(6),
                      ),
                      Expanded(
                          child: AppPickersButtons.visaOptionPicker(
                              title: 'Visa Status',
                              parts: VisaInfo.availableOptions,
                              onChanged: (visa){
                                careerController.selectedVisaStatus = visa?.title;
                              })),
                    ],
                  ),

                  // UPLOAD RESUME
                  Obx(
                    () => _uploadBtn(
                        onUploadDocument: onUploadDocument,
                        jobResumeUrl: careerController.jobResumeUrl),
                  ),

                  SizedBox(
                    height: Dimensions.getHeight(14),
                  ),

                  AppTexts.mediumText(
                      text: '***All Fields are mandatory to send your request'),

                  SizedBox(
                    height: Dimensions.getHeight(14),
                  ),

                  AppButtons.btnWithBg(
                      text: 'Submit',
                      onTap: () {
                        if (nameController.text.isEmpty ||
                            fathersNameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            phoneController.text.isEmpty ||
                            yearController.text.isEmpty ||
                            careerController.selectedVisaStatus.isEmpty ||
                            careerController.jobResumeUrl.isEmpty) {
                          AppToasts.shortToast(Strings.allFieldsAreRequired);
                        } else {
                          onTapSubmit?.call();
                        }
                      }),

                  SizedBox(
                    height: Dimensions.getHeight(24),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

Widget _jobTile(
    {VoidCallback? onTap, String? title, String? location, String? deadline}) {
  return ListTile(
    onTap: onTap,
    title: AppTexts.mediumText(text: title ?? '', fontWeight: FontWeight.bold),
    subtitle: AppTexts.smallText(
        text: '${location ?? ''}, Deadline: ${deadline ?? ''}'),
    trailing: AppButtons.circleButtonStrokeOnly(
        svgIconPath: AppSvgIcons.arrowRight, iconSize: Dimensions.getWidth(15)),
  );
}

Widget _uploadBtn(
    {ValueChanged<String>? onUploadDocument, String? jobResumeUrl}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppTexts.mediumText(
          text: 'Upload Resume',
          color: AppColors.lightFontColor,
          fontWeight: FontWeight.bold),
      SizedBox(
        height: Dimensions.getHeight(12),
      ),
      SizedBox(
          width: Get.width * 0.3,
          child: AppButtons.textBtnWithStrokeOnly(
              text: 'Upload',
              onTap: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf'],
                );

                if (result != null) {
                  onUploadDocument?.call(result.files.single.path!);
                }
              })),
      SizedBox(
        height: Dimensions.getHeight(
            jobResumeUrl == null || jobResumeUrl.isEmpty ? 0 : 12),
      ),
      jobResumeUrl == null || jobResumeUrl.isEmpty
          ? const SizedBox.shrink()
          : AppTexts.smallText(text: jobResumeUrl),
    ],
  );
}
