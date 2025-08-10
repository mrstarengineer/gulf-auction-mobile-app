import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class AppPickers {
  AppPickers._();

  // IMAGE
  static Future<String?> imagePicker({required ImageSource imgSrc}) async {
    final imagePicker = ImagePicker();
    XFile? xfile = await imagePicker.pickImage(source: imgSrc);

    return xfile?.path;
  }

  // DATE
  static Future<DateTime?> datePicker({DateTime? initialDate}) async {
    final pickedDate = await showDatePicker(
      context: Get.context!,
      firstDate: DateTime(DateTime.now().year - 1),
      initialDate: initialDate ?? DateTime.now(),
      lastDate: DateTime.now(),
    );

    return pickedDate;
  } // DATE

  static Future<DateTime?> datePicker2030({DateTime? initialDate}) async {
    final pickedDate = await showDatePicker(
      context: Get.context!,
      firstDate: DateTime(DateTime.now().year - 1),
      initialDate: initialDate ?? DateTime.now(),
      lastDate: DateTime(2030),
    );

    return pickedDate;
  }

//   YEAR
  static Future<int?> yearPicker({required int currentYear}) {
    final selectedYear = showDialog<int>(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: AppTexts.mediumText(text: 'Select Year'),
          content: SizedBox(
            height: Get.height * 0.25,
            width: Get.width * 0.5,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 100,
              itemBuilder: (context, index) {
                final int year = currentYear - index;
                return ListTile(
                  title: AppTexts.mediumText(text: year.toString()),
                  onTap: () {
                    Get.back(result: year);
                  },
                );
              },
            ),
          ),
        );
      },
    );

    return selectedYear;
  }
}

class AppPickersButtons {
  AppPickersButtons._();

  static Widget countryPicker({
    bool isRequired = false,
    required String title,
    required List<CountryInfo> countries,
    required ValueChanged<CountryInfo?>? onChanged,
    bool isCountrySelected = true,
  }) =>
      Padding(
        padding: EdgeInsets.only(bottom: Dimensions.getHeight(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                    child: AppTexts.mediumText(
                        text: title,
                        color: AppColors.lightFontColor,
                        fontWeight: FontWeight.bold)),
                isRequired
                    ? AppTexts.largeText(text: '*', color: AppColors.red)
                    : const SizedBox.shrink(),
              ],
            ),
            SizedBox(
              height: Dimensions.getHeight(12),
            ),
            AppButtons.dropdownBtn(
                title: title,
                type: CountryInfo,
                items: countries,
                onChanged: (info) {
                  info as CountryInfo?;
                  onChanged?.call(info);
                }),
            SizedBox(
              height: !isCountrySelected ? Dimensions.getHeight(12) : 0,
            ),
            !isCountrySelected
                ? Row(
                    children: [
                      SizedBox(
                        width: Dimensions.getWidth(10),
                      ),
                      AppTexts.smallText(
                        text: 'filedCanNotBeEmptyTxt'.tr,
                        color: AppColors.red,
                      )
                    ],
                  )
                : const SizedBox.shrink(),
          ],
        ),
      );

  static Widget vehiclePartPicker<T>({
    bool isRequired = false,
    required String title,
    required List<VehiclePartInfo> parts,
    VehiclePartInfo? initialItem,
    required ValueChanged<VehiclePartInfo?>? onChanged,
    bool isCountrySelected = true,
    String? Function(Object?)? validator,
  }) =>
      Padding(
        padding: EdgeInsets.only(bottom: Dimensions.getHeight(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                    child: AppTexts.mediumText(
                        text: title,
                        color: AppColors.lightFontColor,
                        fontWeight: FontWeight.bold)),
                isRequired
                    ? AppTexts.largeText(text: '*', color: AppColors.red)
                    : const SizedBox.shrink(),
              ],
            ),
            SizedBox(
              height: Dimensions.getHeight(12),
            ),
            AppButtons.dropdownBtn(
              title: title,
              initialItem: initialItem,
              type: VehiclePartInfo,
              items: parts,
              onChanged: (info) {
                info as VehiclePartInfo?;
                onChanged?.call(info);
              },
              validator: validator,
            ),
            SizedBox(
              height: !isCountrySelected ? Dimensions.getHeight(12) : 0,
            ),
            !isCountrySelected
                ? Row(
                    children: [
                      SizedBox(
                        width: Dimensions.getWidth(10),
                      ),
                      AppTexts.smallText(
                        text: 'filedCanNotBeEmptyTxt'.tr,
                        color: AppColors.red,
                      )
                    ],
                  )
                : const SizedBox.shrink(),
          ],
        ),
      );

  static Widget visaOptionPicker<T>({
    bool isRequired = false,
    required String title,
    required List<VisaInfo> parts,
    VehiclePartInfo? initialItem,
    required ValueChanged<VisaInfo?>? onChanged,
    bool isCountrySelected = true,
    String? Function(Object?)? validator,
  }) =>
      Padding(
        padding: EdgeInsets.only(bottom: Dimensions.getHeight(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                    child: AppTexts.mediumText(
                        text: title,
                        color: AppColors.lightFontColor,
                        fontWeight: FontWeight.bold)),
                isRequired
                    ? AppTexts.largeText(text: '*', color: AppColors.red)
                    : const SizedBox.shrink(),
              ],
            ),
            SizedBox(
              height: Dimensions.getHeight(12),
            ),
            AppButtons.dropdownBtn(
              title: title,
              initialItem: initialItem,
              type: VisaInfo,
              items: parts,
              onChanged: (info) {
                info as VisaInfo?;
                onChanged?.call(info);
              },
              validator: validator,
            ),
            SizedBox(
              height: !isCountrySelected ? Dimensions.getHeight(12) : 0,
            ),
            !isCountrySelected
                ? Row(
                    children: [
                      SizedBox(
                        width: Dimensions.getWidth(10),
                      ),
                      AppTexts.smallText(
                        text: 'filedCanNotBeEmptyTxt'.tr,
                        color: AppColors.red,
                      )
                    ],
                  )
                : const SizedBox.shrink(),
          ],
        ),
      );

  static Widget filePicker({
    bool isRequired = false,
    required String title,
    String? filePath,
    ValueChanged<String>? onUploadDocument,
  }) =>
      Padding(
        padding: EdgeInsets.only(bottom: Dimensions.getHeight(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                    child: AppTexts.mediumText(
                        text: title,
                        color: AppColors.lightFontColor,
                        fontWeight: FontWeight.bold)),
                isRequired
                    ? AppTexts.largeText(text: '*', color: AppColors.red)
                    : const SizedBox.shrink(),
              ],
            ),
            SizedBox(
              height: Dimensions.getHeight(12),
            ),
            SizedBox(
                width: Get.width * 0.3,
                child: AppButtons.textBtnWithStrokeOnly(
                    text: 'Upload',
                    onTap: () {
                      AppBottomSheets.imageSourceChooserWithFile(
                          showFilePicker: true,
                          onTapCam: (imgSrc) {
                            AppPickers.imagePicker(imgSrc: imgSrc)
                                .then((imgPath) {
                              if (imgPath != null) {
                                onUploadDocument?.call(imgPath);
                              }
                            });
                          },
                          onTapGallery: (imgSrc) {
                            AppPickers.imagePicker(imgSrc: imgSrc)
                                .then((imgPath) {
                              if (imgPath != null) {
                                onUploadDocument?.call(imgPath);
                              }
                            });
                          },
                          onTapFile: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['pdf'],
                            );

                            if (result != null) {
                              onUploadDocument?.call(result.files.single.path!);
                            }
                          });
                    })),
            SizedBox(
              height: Dimensions.getHeight(
                  filePath == null || filePath.isEmpty ? 0 : 6),
            ),
            filePath == null || filePath.isEmpty
                ? const SizedBox.shrink()
                : AppTexts.smallText(text: filePath)
          ],
        ),
      );

  static Widget datePicker({
    bool isRequired = false,
    required String title,
    required String selectedDate,
    ValueChanged<String>? onTap,
  }) =>
      Padding(
        padding: EdgeInsets.only(bottom: Dimensions.getHeight(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                    child: AppTexts.mediumText(
                        text: title,
                        color: AppColors.lightFontColor,
                        fontWeight: FontWeight.bold)),
                isRequired
                    ? AppTexts.largeText(text: '*', color: AppColors.red)
                    : const SizedBox.shrink(),
              ],
            ),
            SizedBox(
              height: Dimensions.getHeight(12),
            ),
            GestureDetector(
              onTap: () {
                AppPickers.datePicker(
                  initialDate: selectedDate.isNotEmpty
                      ? DateTime.parse(selectedDate)
                      : null,
                ).then((dateTime) {
                  if (dateTime != null) {
                    final date =
                        AppConversions.formatDateTimeToYearMonthDay(dateTime);
                    onTap?.call(date);
                  }
                });
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.getWidth(10),
                    vertical: Dimensions.getHeight(20)),
                decoration: BoxDecoration(
                  color: AppColors.textFieldColor,
                  borderRadius: BorderRadius.circular(Dimensions.getWidth(10)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: AppTexts.smallText(
                          text: selectedDate.isEmpty
                              ? 'yyyy-mm-dd'
                              : selectedDate,
                          color: selectedDate.isEmpty
                              ? AppColors.extraLightFontColor
                              : AppColors.baseFontColor,
                          fontSize: Dimensions.mFontSize14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: Dimensions.getWidth(8),
                    ),
                    AppIconWidgets.svgAssetIcon(
                        iconPath: AppSvgIcons.calender,
                        size: Dimensions.getHeight(18))
                  ],
                ),
              ),
            ),
          ],
        ),
      );  static Widget datePicker2030({
    bool isRequired = false,
    required String title,
    required String selectedDate,
    ValueChanged<String>? onTap,
  }) =>
      Padding(
        padding: EdgeInsets.only(bottom: Dimensions.getHeight(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                    child: AppTexts.mediumText(
                        text: title,
                        color: AppColors.lightFontColor,
                        fontWeight: FontWeight.bold)),
                isRequired
                    ? AppTexts.largeText(text: '*', color: AppColors.red)
                    : const SizedBox.shrink(),
              ],
            ),
            SizedBox(
              height: Dimensions.getHeight(12),
            ),
            GestureDetector(
              onTap: () {
                AppPickers.datePicker2030(
                  initialDate: selectedDate.isNotEmpty
                      ? DateTime.parse(selectedDate)
                      : null,
                ).then((dateTime) {
                  if (dateTime != null) {
                    final date =
                        AppConversions.formatDateTimeToYearMonthDay(dateTime);
                    onTap?.call(date);
                  }
                });
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.getWidth(10),
                    vertical: Dimensions.getHeight(20)),
                decoration: BoxDecoration(
                  color: AppColors.textFieldColor,
                  borderRadius: BorderRadius.circular(Dimensions.getWidth(10)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: AppTexts.smallText(
                          text: selectedDate.isEmpty
                              ? 'yyyy-mm-dd'
                              : selectedDate,
                          color: selectedDate.isEmpty
                              ? AppColors.extraLightFontColor
                              : AppColors.baseFontColor,
                          fontSize: Dimensions.mFontSize14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: Dimensions.getWidth(8),
                    ),
                    AppIconWidgets.svgAssetIcon(
                        iconPath: AppSvgIcons.calender,
                        size: Dimensions.getHeight(18))
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  static filterVehicleDateTimePicker({
    String? selectedDate,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Dimensions.getWidth(10)),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColorLight),
            borderRadius: BorderRadius.circular(Dimensions.getWidth(8))),
        child: Row(
          children: [
            Expanded(
                child: AppTexts.smallText(
                    text: selectedDate == null || selectedDate.isEmpty
                        ? 'yyyy-m-dd'
                        : selectedDate)),
            SizedBox(
              width: Dimensions.getWidth(10),
            ),
            AppIconWidgets.svgAssetIcon(
                iconPath: AppSvgIcons.calender, size: Dimensions.getHeight(14))
          ],
        ),
      ),
    );
  }

  static filterVehicleYearPicker({
    String? selectedDate,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Dimensions.getWidth(10)),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColorLight),
            borderRadius: BorderRadius.circular(Dimensions.getWidth(8))),
        child: Row(
          children: [
            Expanded(
                child: AppTexts.smallText(
                    text: selectedDate == null || selectedDate.isEmpty
                        ? ''
                        : selectedDate)),
            SizedBox(
              width: Dimensions.getWidth(10),
            ),
            AppIconWidgets.svgAssetIcon(
                iconPath: AppSvgIcons.arrowDown, size: Dimensions.getHeight(8))
          ],
        ),
      ),
    );
  }
}
