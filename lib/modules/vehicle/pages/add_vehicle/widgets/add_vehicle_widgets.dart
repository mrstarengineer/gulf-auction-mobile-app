import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/extensions/extensions.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/utils.dart';

class AddVehicleWidgets {
  AddVehicleWidgets._();

  static Widget body(
    BuildContext context, {
    Key? formKey,
    bool isEditVehicle = false,
    List<VehiclePartInfo>? makes,
    ValueChanged<VehiclePartInfo?>? onChangedMake,
    List<VehiclePartInfo>? models,
    ValueChanged<VehiclePartInfo?>? onChangedModels,
    List<VehiclePartInfo>? bodyStyles,
    ValueChanged<VehiclePartInfo?>? onChangedBodyStyles,
    List<VehiclePartInfo>? engineType,
    ValueChanged<VehiclePartInfo?>? onChangedEngineType,
    List<VehiclePartInfo>? fuelType,
    ValueChanged<VehiclePartInfo?>? onChangedFuelType,
    List<VehiclePartInfo>? driveTrains,
    ValueChanged<VehiclePartInfo?>? onChangedDriveTrains,
    List<VehiclePartInfo>? transmission,
    ValueChanged<VehiclePartInfo?>? onChangedTransmission,
    // List<VehiclePartInfo>? cylinder,
    ValueChanged<VehiclePartInfo?>? onChangedCylinder,
    List<VehiclePartInfo>? primaryDamage,
    ValueChanged<VehiclePartInfo?>? onChangedPrimaryDamage,
    List<VehiclePartInfo>? secondaryDamage,
    ValueChanged<VehiclePartInfo?>? onChangedSecondaryDamage,
    List<VehiclePartInfo>? colors,
    ValueChanged<VehiclePartInfo?>? onChangedColors,
    List<VehiclePartInfo>? mileageType,
    ValueChanged<VehiclePartInfo?>? onChangedMileageType,
    List<VehiclePartInfo>? highlight,
    ValueChanged<VehiclePartInfo?>? onChangedHighlight,
    // List<VehiclePartInfo>? vehicleCategory,
    ValueChanged<VehiclePartInfo?>? onChangedVehicleCategory,
    // List<VehiclePartInfo>? saleTypes,
    // ValueChanged<VehiclePartInfo?>? onChangedSaleType,
    // List<VehiclePartInfo>? saleExecutive,
    // ValueChanged<VehiclePartInfo?>? onChangedSaleExecutiveType,
    TextEditingController? vinTextController,
    TextEditingController? yearTextController,
    TextEditingController? odometerTextController,
    TextEditingController? priceTextController,
    TextEditingController? sellingPriceTextController,
    TextEditingController? reservePriceTextController,
    TextEditingController? trimTextController,
    VoidCallback? onTapAutoFill,
    required bool termsAndConditionsAgreed,
    ValueChanged<bool?>? onChangeTermsAndConditionsAgreed,
    VoidCallback? onTapSubmit,
    VoidCallback? onTapRemoveDocument,
    ValueChanged<String>? onTapRemovePhoto,
    ValueChanged<String>? onUploadPhoto,
    ValueChanged<String>? onUploadDocument,
    ValueChanged<String>? onTapPreview,
    ValueChanged<MVehicleHasKeys>? onChangeHasKeys,
    ValueChanged<MVehicleDocumentType>? onChangeDocumentType,
    ValueChanged<MVehicleOdometerType>? onChangeOdometerType,
    ValueChanged<MVehiclePlanType>? onChangePlanType,
    ValueChanged<MVehicleHasKeys>? onChangePassingTestType,
    required List<String> vehiclePhotos,
    required String documentPhoto,
    required MVehicleHasKeys hasKeys,
    required MVehicleDocumentType documentType,
    required MVehicleOdometerType odometerType,
    required MVehiclePlanType plan,
    required MVehicleHasKeys passingTest,
    required VoidCallback onTapTermsAndConditions,
    int? selectedBodyStyleId,
    int? selectedEngineTypeId,
    int? selectedFuelTypeId,
    // int? selectedSaleExecutiveTypeId,
    int? selectedDriveTrainId,
    int? selectedTransmissionId,
    int? selectedCylinderId,
    int? selectedPrimaryDamageId,
    int? selectedSecondaryDamageId,
    int? selectedColorId,
    int? selectedMileageTypeId,
    int? selectedHighlightId,
    int? selectedId,
    int? selectedCategoryId,
    int? selectedSaleTypeId,
    int? selectedMakeId,
    int? selectedModelId,
    // required ValueChanged<int?> onChangedSaleType
  }) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // VIN
          AppTextFields.textFieldWithTitle(
              controller: vinTextController,
              title: 'VIN',
              hintText: 'Enter Vin Number',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'filedCanNotBeEmptyTxt'.tr;
                }
                return null;
              }),

          // AUTO FILL
          SizedBox(
              width: context.screenWidth * 0.25,
              child: AppButtons.textBtnWithStrokeOnly(
                  onTap: onTapAutoFill,
                  text: 'Auto Fill',
                  radius: Dimensions.getWidth(100),
                  padding: Dimensions.getHeight(8),
                  fontSize: Dimensions.getHeight(14))),
          SizedBox(
            height: Dimensions.getHeight(17),
          ),

          // YEAR
          AppTextFields.textFieldWithTitle(
              keyboardType: TextInputType.number,
              title: 'Year',
              controller: yearTextController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'filedCanNotBeEmptyTxt'.tr;
                }
                return null;
              }),

          // MAKE
          AppPickersButtons.vehiclePartPicker(
              title: 'Make',
              initialItem: selectedMakeId != 0
                  ? makes?.where((e) => e.id == selectedMakeId).singleOrNull
                  : null,
              parts: makes ?? [],
              onChanged: onChangedMake,
              validator: (value) {
                if (value == null) {
                  return 'filedCanNotBeEmptyTxt'.tr;
                }
                return null;
              }),

          // MODELS
          AppPickersButtons.vehiclePartPicker(
              title: 'Model',
              initialItem: selectedModelId != 0
                  ? models?.where((e) => e.id == selectedModelId).singleOrNull
                  : null,
              parts: models ?? [],
              onChanged: onChangedModels,
              validator: (value) {
                if (value == null) {
                  return 'filedCanNotBeEmptyTxt'.tr;
                }
                return null;
              }),

          // Trim
          AppTextFields.textFieldWithTitle(
              title: 'Trim',
              keyboardType: TextInputType.text,
              controller: trimTextController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'filedCanNotBeEmptyTxt'.tr;
                }
                return null;
              }),

          // BODY STYLES
          AppPickersButtons.vehiclePartPicker(
              title: 'Body Style',
              parts: bodyStyles ?? [],
              initialItem: selectedBodyStyleId != 0
                  ? bodyStyles
                      ?.where((e) => e.id == selectedBodyStyleId)
                      .singleOrNull
                  : null,
              onChanged: onChangedBodyStyles,
              validator: (bodyStyle) {
                if (bodyStyle == null) {
                  return 'filedCanNotBeEmptyTxt'.tr;
                }
                return null;
              }),

          // ENGINE TYPE
          AppPickersButtons.vehiclePartPicker(
              title: 'Engine Type',
              parts: engineType ?? [],
              initialItem: selectedEngineTypeId != 0
                  ? engineType
                      ?.where((e) => e.id == selectedEngineTypeId)
                      .singleOrNull
                  : null,
              onChanged: onChangedEngineType,
              validator: (value) {
                if (value == null) {
                  return 'filedCanNotBeEmptyTxt'.tr;
                }
                return null;
              }),

          // Fuel Type
          AppPickersButtons.vehiclePartPicker(
              title: 'Fuel Type',
              parts: fuelType ?? [],
              initialItem: selectedFuelTypeId != 0
                  ? fuelType
                      ?.where((e) => e.id == selectedFuelTypeId)
                      .singleOrNull
                  : null,
              onChanged: onChangedFuelType,
              validator: (value) {
                if (value == null) {
                  return 'filedCanNotBeEmptyTxt'.tr;
                }
                return null;
              }),

          // Drive Train
          AppPickersButtons.vehiclePartPicker(
              title: 'Drive Train',
              parts: driveTrains ?? [],
              initialItem: selectedDriveTrainId != 0
                  ? driveTrains
                      ?.where((e) => e.id == selectedDriveTrainId)
                      .singleOrNull
                  : null,
              onChanged: onChangedDriveTrains,
              validator: (value) {
                if (value == null) {
                  return 'filedCanNotBeEmptyTxt'.tr;
                }
                return null;
              }),

          // Transmission
          AppPickersButtons.vehiclePartPicker(
              title: 'Transmission',
              parts: transmission ?? [],
              initialItem: selectedTransmissionId != 0
                  ? transmission
                      ?.where((e) => e.id == selectedTransmissionId)
                      .singleOrNull
                  : null,
              onChanged: onChangedTransmission,
              validator: (value) {
                if (value == null) {
                  return 'filedCanNotBeEmptyTxt'.tr;
                }
                return null;
              }),

          // Cylinder
          // AppPickersButtons.vehiclePartPicker(
          //     title: 'Cylinder',
          //     parts: cylinder ?? [],
          //     initialItem: selectedCylinderId != 0
          //         ? cylinder
          //             ?.where((e) => e.id == selectedCylinderId)
          //             .singleOrNull
          //         : null,
          //     onChanged: onChangedCylinder,
          //     validator: (value) {
          //       if (value == null) {
          //         return 'filedCanNotBeEmptyTxt'.tr;
          //       }
          //       return null;
          //     }),

          // Primary Damage
          AppPickersButtons.vehiclePartPicker(
              title: 'Primary Damage',
              parts: primaryDamage ?? [],
              initialItem: selectedPrimaryDamageId != 0
                  ? primaryDamage
                      ?.where((e) => e.id == selectedPrimaryDamageId)
                      .singleOrNull
                  : null,
              onChanged: onChangedPrimaryDamage,
              validator: (value) {
                if (value == null) {
                  return 'filedCanNotBeEmptyTxt'.tr;
                }
                return null;
              }),

          // Secondary Damage
          AppPickersButtons.vehiclePartPicker(
              title: 'Secondary Damage',
              parts: secondaryDamage ?? [],
              initialItem: selectedSecondaryDamageId != 0
                  ? secondaryDamage
                      ?.where((e) => e.id == selectedSecondaryDamageId)
                      .singleOrNull
                  : null,
              onChanged: onChangedSecondaryDamage,
              validator: (value) {
                if (value == null) {
                  return 'filedCanNotBeEmptyTxt'.tr;
                }
                return null;
              }),

          _odometerTypeBtns(
              selectedValue: odometerType,
              onChanged: (value) {
                onChangeOdometerType?.call(value);
              }),

          SizedBox(
            height: Dimensions.getHeight(10),
          ),

          // Odometer
          AppTextFields.textFieldWithTitle(
              title: 'Odometer',
              keyboardType: TextInputType.number,
              controller: odometerTextController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'filedCanNotBeEmptyTxt'.tr;
                }
                return null;
              }),

          // ODOMETER TYPE

          // Color
          AppPickersButtons.vehiclePartPicker(
              title: 'Color',
              parts: colors ?? [],
              initialItem: selectedColorId != 0
                  ? colors?.where((e) => e.id == selectedColorId).singleOrNull
                  : null,
              onChanged: onChangedColors,
              validator: (value) {
                if (value == null) {
                  return 'filedCanNotBeEmptyTxt'.tr;
                }
                return null;
              }),

          // Mileage Type
          AppPickersButtons.vehiclePartPicker(
              title: 'Mileage Type',
              parts: mileageType ?? [],
              initialItem: selectedMileageTypeId != 0
                  ? mileageType
                      ?.where((e) => e.id == selectedMileageTypeId)
                      .singleOrNull
                  : null,
              onChanged: onChangedMileageType,
              validator: (value) {
                if (value == null) {
                  return 'filedCanNotBeEmptyTxt'.tr;
                }
                return null;
              }),

          // Highlight
          AppPickersButtons.vehiclePartPicker(
              title: 'Highlight',
              parts: highlight ?? [],
              initialItem: selectedHighlightId != 0
                  ? highlight
                      ?.where((e) => e.id == selectedHighlightId)
                      .singleOrNull
                  : null,
              onChanged: onChangedHighlight,
              validator: (value) {
                if (value == null) {
                  return 'filedCanNotBeEmptyTxt'.tr;
                }
                return null;
              }),

          // Vehicle Category
          // AppPickersButtons.vehiclePartPicker(
          //     title: 'Vehicle Category',
          //     parts: vehicleCategory ?? [],
          //     initialItem: selectedCategoryId != 0
          //         ? vehicleCategory
          //             ?.where((e) => e.id == selectedCategoryId)
          //             .singleOrNull
          //         : null,
          //     onChanged: onChangedVehicleCategory,
          //     validator: (value) {
          //       if (value == null) {
          //         return 'filedCanNotBeEmptyTxt'.tr;
          //       }
          //       return null;
          //     }),

          // Sales Executive
          // AppPickersButtons.vehiclePartPicker(
          //     title: 'Sales Executive',
          //     parts: saleExecutive ?? [],
          //     initialItem: selectedSaleExecutiveTypeId != 0
          //         ? saleExecutive
          //             ?.where((e) => e.id == selectedSaleExecutiveTypeId)
          //             .singleOrNull
          //         : null,
          //     onChanged: (mData) {
          //       onChangedSaleType(mData?.id ?? 0);
          //     },
          //     validator: (value) {
          //       if (value == null) {
          //         return 'filedCanNotBeEmptyTxt'.tr;
          //       }
          //       return null;
          //     }),

          // STARTING BID AMOUNT
          // if (selectedCategoryId == 1)
          //   AppTextFields.textFieldWithTitle(
          //       keyboardType: TextInputType.number,
          //       title: 'Price',
          //       hintText: 'Enter Amount',
          //       controller: priceTextController,
          //       validator: (value) {
          //         if (value == null || value.isEmpty) {
          //           return 'filedCanNotBeEmptyTxt'.tr;
          //         }
          //         return null;
          //       }),

          // Sale Type
          // if (selectedCategoryId == 1)
          //   AppPickersButtons.vehiclePartPicker(
          //       title: 'Sale Type',
          //       parts: saleTypes ?? [],
          //       initialItem: selectedSaleTypeId != 0
          //           ? saleTypes
          //               ?.where((e) => e.id == selectedSaleTypeId)
          //               .singleOrNull
          //           : null,
          //       onChanged: onChangedSaleType,
          //       validator: (value) {
          //         if (value == null) {
          //           return 'filedCanNotBeEmptyTxt'.tr;
          //         }
          //         return null;
          //       }),

          // // SELLING PRICE
          // if (selectedCategoryId == 2)
          //   AppTextFields.textFieldWithTitle(
          //       keyboardType: TextInputType.number,
          //       title: 'Selling Price',
          //       hintText: 'Enter Price',
          //       controller: sellingPriceTextController,
          //       validator: (value) {
          //         if (value == null) {
          //           return 'filedCanNotBeEmptyTxt'.tr;
          //         }
          //         return null;
          //       }),

          // Reserve Price
          //  if (selectedSaleTypeId == 2)
          AppTextFields.textFieldWithTitle(
              keyboardType: TextInputType.number,
              title: 'Reserve Price',
              controller: reservePriceTextController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'filedCanNotBeEmptyTxt'.tr;
                }
                return null;
              }),

          // KEYS
          _keysSelectionBtns(
              selectedValue: hasKeys,
              onChanged: (value) {
                onChangeHasKeys?.call(value);
              }),
          SizedBox(
            height: Dimensions.getHeight(10),
          ),
          // PLAN
          _planTypeBtns(
              selectedValue: plan,
              onChanged: (value) {
                onChangePlanType?.call(value);
              }),
          SizedBox(
            height: Dimensions.getHeight(10),
          ),
          //PASSING TEST
          _passingTestBtns(
              selectedValue: passingTest,
              onChanged: (value) {
                onChangePassingTestType?.call(value);
              }),

          SizedBox(
            height: Dimensions.getHeight(10),
          ),

          // Vehicle Photos
          AppTexts.mediumText(
              text: 'Vehicle Photos',
              color: AppColors.lightFontColor,
              fontWeight: FontWeight.bold),
          SizedBox(
            height: Dimensions.getHeight(10),
          ),
          _cameraBtn(
              onTap: () => AppBottomSheets.imageSourceChooserWithFile(
                      onTapCam: (imgSrc) {
                    AppPickers.imagePicker(imgSrc: imgSrc).then((imgPath) {
                      if (imgPath != null) {
                        onUploadPhoto?.call(imgPath);
                      }
                    });
                  }, onTapGallery: (imgSrc) {
                    AppPickers.imagePicker(imgSrc: imgSrc).then((imgPath) {
                      if (imgPath != null) {
                        onUploadPhoto?.call(imgPath);
                      }
                    });
                  })),

          SizedBox(
            height: Dimensions.getHeight(vehiclePhotos.isEmpty ? 0 : 10),
          ),

          // Photos
          Wrap(
            spacing:
                Dimensions.getWidth(22), // Horizontal space between widgets
            runSpacing: Dimensions.getHeight(22),
            children: List.generate(vehiclePhotos.length, (index) {
              final imgUrl = vehiclePhotos[index];
              return _photoCard(
                  imgUrl: imgUrl,
                  onTapPreview: () {
                    onTapPreview?.call(imgUrl);
                  },
                  onTapRemove: () {
                    onTapRemovePhoto?.call(imgUrl);
                  });
            }),
          ),

          SizedBox(
            height: Dimensions.getHeight(24),
          ),

          // DOCUMENT
          _documentTypeBtns(
              selectedValue: documentType,
              onChanged: (value) {
                onChangeDocumentType?.call(value);
              }),
          SizedBox(
            height: Dimensions.getHeight(10),
          ),
          _cameraBtn(
              note: '[Note : accept only jpg,jpeg,png,pdf.]',
              onTap: () => AppBottomSheets.imageSourceChooserWithFile(
                  showFilePicker: true,
                  onTapCam: (imgSrc) {
                    AppPickers.imagePicker(imgSrc: imgSrc).then((imgPath) {
                      if (imgPath != null) {
                        onUploadDocument?.call(imgPath);
                      }
                    });
                  },
                  onTapGallery: (imgSrc) {
                    AppPickers.imagePicker(imgSrc: imgSrc).then((imgPath) {
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
                  })),

          SizedBox(
            height: Dimensions.getHeight(documentPhoto.isNotEmpty ? 10 : 0),
          ),

          // DOCUMENT
          if (documentPhoto.isNotEmpty)
            _linkWithPreviewBtn(
                documentPhoto: documentPhoto,
                onTapPreview: () {
                  onTapPreview?.call(documentPhoto);
                }),

          SizedBox(
            height: Dimensions.getHeight(10),
          ),

          // Terms & Conditions
          Row(
            children: [
              AppButtons.checkBox(
                  value: termsAndConditionsAgreed,
                  onChanged: onChangeTermsAndConditionsAgreed),
              Expanded(
                child: AppButtons.textButton(
                    text: 'Terms & Conditions', onTap: onTapTermsAndConditions),
              ),
            ],
          ),

          SizedBox(
            height: Dimensions.getHeight(10),
          ),

          // SUBMIT
          Center(
              child: Container(
            width: context.screenWidth * 0.4,
            padding: EdgeInsets.all(Dimensions.getHeight(14)),
            child: AppButtons.btnWithBg(
              onTap: termsAndConditionsAgreed ? onTapSubmit : null,
              text: isEditVehicle ? 'Update' : 'Submit',
              radius: Dimensions.getWidth(100),
              bgColor: termsAndConditionsAgreed
                  ? AppColors.primaryColor
                  : AppColors.grey,
            ),
          ))
        ],
      ),
    );
  }
}

Widget _keysSelectionBtns(
    {bool isRequired = false,
    required MVehicleHasKeys selectedValue,
    ValueChanged<MVehicleHasKeys>? onChanged}) {
  return Column(
    children: [
      Row(
        children: [
          Flexible(
              child: AppTexts.mediumText(
                  text: 'Keys',
                  color: AppColors.lightFontColor,
                  fontWeight: FontWeight.bold)),
          isRequired
              ? AppTexts.largeText(text: '*', color: AppColors.red)
              : const SizedBox.shrink()
        ],
      ),
      SizedBox(
        height: Dimensions.getHeight(12),
      ),
      Row(
        children: [
          Row(
            children: [
              AppButtons.radioButton(
                  value: MVehicleHasKeys.yes,
                  selectedValue: selectedValue,
                  onChanged: (value) {
                    onChanged?.call(value);
                  }),
              AppTexts.smallText(text: 'Yes'),
            ],
          ),
          SizedBox(
            width: Dimensions.getWidth(12),
          ),
          Row(
            children: [
              AppButtons.radioButton(
                  value: MVehicleHasKeys.no,
                  selectedValue: selectedValue,
                  onChanged: (value) {
                    onChanged?.call(value);
                  }),
              AppTexts.smallText(text: 'No'),
            ],
          ),
        ],
      )
    ],
  );
}

Widget _documentTypeBtns(
    {bool isRequired = false,
    required MVehicleDocumentType selectedValue,
    ValueChanged<MVehicleDocumentType>? onChanged}) {
  return Column(
    children: [
      Row(
        children: [
          Flexible(
              child: AppTexts.mediumText(
                  text: 'VCC/Hayaza Document',
                  color: AppColors.lightFontColor,
                  fontWeight: FontWeight.bold)),
          isRequired
              ? AppTexts.largeText(text: '*', color: AppColors.red)
              : const SizedBox.shrink()
        ],
      ),
      SizedBox(
        height: Dimensions.getHeight(12),
      ),
      Row(
        children: [
          Row(
            children: [
              AppButtons.radioButton(
                  value: MVehicleDocumentType.vcc,
                  selectedValue: selectedValue,
                  onChanged: (value) {
                    onChanged?.call(MVehicleDocumentType.vcc);
                  }),
              AppTexts.smallText(text: 'VCC'),
            ],
          ),
          SizedBox(
            width: Dimensions.getWidth(12),
          ),
          Row(
            children: [
              AppButtons.radioButton(
                  value: MVehicleDocumentType.hayaza,
                  selectedValue: selectedValue,
                  onChanged: (value) {
                    onChanged?.call(MVehicleDocumentType.hayaza);
                  }),
              AppTexts.smallText(text: 'Hayaza / Mulkiya'),
            ],
          ),
        ],
      )
    ],
  );
}

Widget _odometerTypeBtns(
    {bool isRequired = false,
    required MVehicleOdometerType selectedValue,
    ValueChanged<MVehicleOdometerType>? onChanged}) {
  return Column(
    children: [
      Row(
        children: [
          Flexible(
              child: AppTexts.mediumText(
                  text: 'Odometer Type',
                  color: AppColors.lightFontColor,
                  fontWeight: FontWeight.bold)),
          isRequired
              ? AppTexts.largeText(text: '*', color: AppColors.red)
              : const SizedBox.shrink()
        ],
      ),
      SizedBox(
        height: Dimensions.getHeight(12),
      ),
      Row(
        children: [
          Row(
            children: [
              AppButtons.radioButton(
                  value: MVehicleOdometerType.km,
                  selectedValue: selectedValue,
                  onChanged: (value) {
                    onChanged?.call(MVehicleOdometerType.km);
                  }),
              AppTexts.smallText(text: 'Kilometer'),
            ],
          ),
          SizedBox(
            width: Dimensions.getWidth(12),
          ),
          Row(
            children: [
              AppButtons.radioButton(
                  value: MVehicleOdometerType.mi,
                  selectedValue: selectedValue,
                  onChanged: (value) {
                    onChanged?.call(MVehicleOdometerType.mi);
                  }),
              AppTexts.smallText(text: 'Miles'),
            ],
          ),
        ],
      )
    ],
  );
}

Widget _planTypeBtns(
    {bool isRequired = false,
    required MVehiclePlanType selectedValue,
    ValueChanged<MVehiclePlanType>? onChanged}) {
  return Column(
    children: [
      Row(
        children: [
          Flexible(
              child: AppTexts.mediumText(
                  text: 'Plan',
                  color: AppColors.lightFontColor,
                  fontWeight: FontWeight.bold)),
          isRequired
              ? AppTexts.largeText(text: '*', color: AppColors.red)
              : const SizedBox.shrink()
        ],
      ),
      SizedBox(
        height: Dimensions.getWidth(12),
      ),
      Row(
        children: [
          Row(
            children: [
              AppButtons.radioButton(
                  value: MVehiclePlanType.standard,
                  selectedValue: selectedValue,
                  onChanged: (value) {
                    onChanged?.call(MVehiclePlanType.standard);
                  }),
              AppTexts.smallText(text: 'Standard'),
            ],
          ),
          SizedBox(
            width: Dimensions.getWidth(12),
          ),
          Row(
            children: [
              AppButtons.radioButton(
                  value: MVehiclePlanType.premium,
                  selectedValue: selectedValue,
                  onChanged: (value) {
                    onChanged?.call(MVehiclePlanType.premium);
                  }),
              AppTexts.smallText(text: 'Premium'),
            ],
          ),
        ],
      )
    ],
  );
}

Widget _passingTestBtns(
    {bool isRequired = false,
    required MVehicleHasKeys selectedValue,
    ValueChanged<MVehicleHasKeys>? onChanged}) {
  return Column(
    children: [
      Row(
        children: [
          Flexible(
              child: AppTexts.mediumText(
                  text: 'Passing Test',
                  color: AppColors.lightFontColor,
                  fontWeight: FontWeight.bold)),
          isRequired
              ? AppTexts.largeText(text: '*', color: AppColors.red)
              : const SizedBox.shrink()
        ],
      ),
      SizedBox(
        height: Dimensions.getWidth(12),
      ),
      Row(
        children: [
          Row(
            children: [
              AppButtons.radioButton(
                  value: MVehicleHasKeys.yes,
                  selectedValue: selectedValue,
                  onChanged: (value) {
                    onChanged?.call(MVehicleHasKeys.yes);
                  }),
              AppTexts.smallText(text: 'Yes'),
            ],
          ),
          SizedBox(
            width: Dimensions.getHeight(12),
          ),
          Row(
            children: [
              AppButtons.radioButton(
                  value: MVehicleHasKeys.no,
                  selectedValue: selectedValue,
                  onChanged: (value) {
                    onChanged?.call(MVehicleHasKeys.no);
                  }),
              AppTexts.smallText(text: 'No'),
            ],
          ),
        ],
      )
    ],
  );
}

Widget _linkWithPreviewBtn(
    {required String documentPhoto, VoidCallback? onTapPreview}) {
  return Row(
    children: [
      Expanded(child: AppTexts.smallText(text: documentPhoto)),
      AppButtons.textButton(text: 'Preview', onTap: onTapPreview)
    ],
  );
}

Widget _photoCard(
    {required String imgUrl,
    VoidCallback? onTapRemove,
    VoidCallback? onTapPreview}) {
  return SizedBox(
    width: Dimensions.getHeight(90),
    height: Dimensions.getHeight(90),
    child: Stack(
      children: [
        Positioned(
          bottom: 0,
          child: GestureDetector(
            onTap: onTapPreview,
            child: Container(
              width: Dimensions.getHeight(80),
              height: Dimensions.getHeight(80),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.getHeight(10)),
                  image: DecorationImage(
                      image: NetworkImage(
                        imgUrl,
                      ),
                      fit: BoxFit.cover)),
            ),
          ),
        ),
        Positioned(
            top: 0,
            right: 0,
            child: AppButtons.iconButtonWithBg(
                icon: Icons.close, onTap: onTapRemove))
      ],
    ),
  );
}

Widget _cameraBtn({
  VoidCallback? onTap,
  String? note,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: onTap,
        child: DottedBorder(
            color: AppColors.mediumLightGrey,
            dashPattern: const [3, 2],
            radius: Radius.circular(Dimensions.getWidth(8)),
            child: Container(
                height: Dimensions.getHeight(78),
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.getWidth(14),
                    vertical: Dimensions.getHeight(24)),
                width: double.maxFinite,
                child:
                    AppIconWidgets.svgAssetIcon(iconPath: AppSvgIcons.camera))),
      ),
      SizedBox(
        height: Dimensions.getHeight(6),
      ),
      AppTexts.smallText(
          text: note ??
              '[Note : Image dimensions must be 4:3, max width: 2000, max height: 1500, accept only jpg,jpeg,png]',
          overflow: TextOverflow.visible,
          color: AppColors.grey)
    ],
  );
}
