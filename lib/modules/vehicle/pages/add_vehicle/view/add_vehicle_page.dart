import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/models/vehicle/my_car_info.dart';
import 'package:gulf_car_auction/modules/sell_my_car/sell_my_car.dart';
import 'package:gulf_car_auction/modules/vehicle/pages/add_vehicle/add_vehicle.dart';
import 'package:gulf_car_auction/routes/routes.dart';

import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/utils.dart';

import '../../../../../global/global.dart';

class AddVehiclePage extends StatefulWidget {
  const AddVehiclePage({super.key});

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  final addVehicleController = Get.find<AddVehicleController>();
  final formKey = GlobalKey<FormState>();
  final MyCarInfo? editVehicleInfoData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBar(title: 'Add Vehicle'),
      body: Obx(() {
        if (addVehicleController.isLoading) {
          return AppLoaders.loaderWithText();
        } else {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(Dimensions.getHeight(14)),
              child: AddVehicleWidgets.body(context,
                  onChangedSaleType: (id) {
                    addVehicleController.setSelectedSaleExecutiveId = id;
                  },
                  formKey: formKey,
                  isEditVehicle: editVehicleInfoData != null,
                  hasKeys: addVehicleController.hasKeys,
                  priceTextController: addVehicleController.priceTextController,
                  sellingPriceTextController:
                      addVehicleController.sellingPriceTextController,
                  vinTextController: addVehicleController.vinTextController,
                  yearTextController: addVehicleController.yearTextController,
                  // reservePriceTextController:
                  //     addVehicleController.reservePriceTextController,
                  odometerTextController:
                      addVehicleController.odometerTextController,
                  trimTextController: addVehicleController.trimTextController,
                  termsAndConditionsAgreed:
                      addVehicleController.termsAndConditionsAgreed,
                  onChangeTermsAndConditionsAgreed:
                      addVehicleController.updateTermsAndConditionsAgreed,
                  makes: addVehicleController.make,
                  // saleTypes:
                  //     addVehicleController.vehicleStaticDataOptions?.saleTypes,
                  saleExecutive: addVehicleController
                      .vehicleStaticDataOptions?.saleExecutive,
                  selectedSaleExecutiveTypeId:
                      addVehicleController.selectedSaleExecutiveId,
                  models: addVehicleController.models,
                  bodyStyles:
                      addVehicleController.vehicleStaticDataOptions?.bodyStyles,
                  engineType:
                      addVehicleController.vehicleStaticDataOptions?.engineType,
                  fuelType:
                      addVehicleController.vehicleStaticDataOptions?.fuelTypes,
                  driveTrains: addVehicleController
                      .vehicleStaticDataOptions?.driveTrains,
                  transmission: addVehicleController
                      .vehicleStaticDataOptions?.transmission,
                  cylinder:
                      addVehicleController.vehicleStaticDataOptions?.cylinders,
                  primaryDamage:
                      addVehicleController.vehicleStaticDataOptions?.damages,
                  secondaryDamage:
                      addVehicleController.vehicleStaticDataOptions?.damages,
                  colors: addVehicleController.vehicleStaticDataOptions?.colors,
                  mileageType: addVehicleController
                      .vehicleStaticDataOptions?.mileageType,
                  highlight:
                      addVehicleController.vehicleStaticDataOptions?.highlights,
                  vehicleCategory:
                      addVehicleController.vehicleStaticDataOptions?.categories,
                  vehiclePhotos: addVehicleController.vehiclePhotos,
                  documentPhoto: addVehicleController.vccDocument,
                  selectedMakeId: addVehicleController.selectedMake,
                  selectedModelId: addVehicleController.selectedModel,
                  selectedBodyStyleId: addVehicleController.selectedBodyStyle,
                  selectedEngineTypeId: addVehicleController.selectedEngineType,
                  selectedFuelTypeId: addVehicleController.selectedFuelType,
                  selectedDriveTrainId: addVehicleController.selectedDriveTrain,
                  selectedTransmissionId:
                      addVehicleController.selectedTransmission,
                  selectedCylinderId: addVehicleController.selectedCylinder,
                  selectedPrimaryDamageId:
                      addVehicleController.selectedPrimaryDamage,
                  selectedSecondaryDamageId:
                      addVehicleController.selectedSecondaryDamage,
                  selectedColorId: addVehicleController.selectedColor,
                  selectedMileageTypeId:
                      addVehicleController.selectedMileageType,
                  selectedHighlightId: addVehicleController.selectedHighlight,
                  selectedCategoryId: addVehicleController.selectedCategory,
                  selectedSaleTypeId: addVehicleController.selectedSaleType,
                  documentType: addVehicleController.documentType,
                  onChangeDocumentType: (value) {
                    addVehicleController.documentType = value;
                  },
                  onChangeHasKeys: (value) {
                    addVehicleController.hasKeys = value;
                  },
                  onChangedMake: (make) {
                    addVehicleController.fetchModel(makeId: '${make?.id}');
                    addVehicleController.selectedMake = make?.id ?? 0;
                  },
                  onChangedModels: (models) {
                    addVehicleController.selectedModel = models?.id ?? 0;
                  },
                  onChangedBodyStyles: (bodyStyle) {
                    addVehicleController.selectedBodyStyle = bodyStyle?.id ?? 0;
                  },
                  onChangedEngineType: (engineType) {
                    addVehicleController.selectedEngineType =
                        engineType?.id ?? 0;
                  },
                  onChangedFuelType: (fuelType) {
                    addVehicleController.selectedFuelType = fuelType?.id ?? 0;
                  },
                  onChangedDriveTrains: (driveTrain) {
                    addVehicleController.selectedDriveTrain =
                        driveTrain?.id ?? 0;
                  },
                  onChangedTransmission: (transmission) {
                    addVehicleController.selectedTransmission =
                        transmission?.id ?? 0;
                  },
                  onChangedCylinder: (transmission) {
                    addVehicleController.selectedCylinder =
                        transmission?.id ?? 0;
                  },
                  onChangedPrimaryDamage: (damage) {
                    addVehicleController.selectedPrimaryDamage =
                        damage?.id ?? 0;
                  },
                  onChangedSecondaryDamage: (damage) {
                    addVehicleController.selectedSecondaryDamage =
                        damage?.id ?? 0;
                  },
                  onChangedColors: (color) {
                    addVehicleController.selectedColor = color?.id ?? 0;
                  },
                  onChangedMileageType: (mileageType) {
                    addVehicleController.selectedMileageType =
                        mileageType?.id ?? 0;
                  },
                  onChangedHighlight: (highlights) {
                    addVehicleController.selectedHighlight =
                        highlights?.id ?? 0;
                  },
                  onChangedSaleExecutiveType: (salesExecutive) {},
                  onChangedVehicleCategory: (category) {
                    // if (category?.id == 2) {
                    //   addVehicleController.reservePriceTextController.clear();
                    //   addVehicleController.selectedSaleType = 0;
                    // }
                    addVehicleController.selectedCategory = category?.id ?? 0;
                  },
                  // onChangedSaleType: (sellType) {
                  //   addVehicleController.selectedSaleType = sellType?.id ?? 0;
                  // },
                  onTapAutoFill: () {
                    if (addVehicleController.vinTextController.text.length <
                        17) {
                      AppToasts.shortToast(Strings.vinCharWarningText);
                    } else {
                      context.showLoaderOverlay;
                      addVehicleController.autoFillByVin().then((response) {
                        if (response.isSuccess) {
                          addVehicleController
                              .fetchModel(
                                  makeId:
                                      '${addVehicleController.selectedMake}')
                              .then((modelResponse) {
                            context.hideLoaderOverlay;
                            if (modelResponse.isSuccess) {
                              addVehicleController.selectedModel =
                                  addVehicleController
                                      .autoFillByVinData?.modelId;
                            } else {
                              AppToasts.shortToast(response.message);
                            }
                          });
                        } else {
                          context.hideLoaderOverlay;
                        }
                      });
                    }
                  },
                  onUploadPhoto: (imgPath) {
                    context.showLoaderOverlay;
                    addVehicleController
                        .uploadPhotoOrDocument(imgPath: imgPath)
                        .then((response) {
                      context.hideLoaderOverlay;
                      if (!response.isSuccess) {
                        AppToasts.shortToast(response.message);
                      }
                    });
                  },
                  onUploadDocument: (imgPath) {
                    context.showLoaderOverlay;
                    addVehicleController
                        .uploadPhotoOrDocument(imgPath: imgPath, isPhoto: false)
                        .then((response) {
                      context.hideLoaderOverlay;
                      if (!response.isSuccess) {
                        AppToasts.shortToast(response.message);
                      }
                    });
                  },
                  onTapRemovePhoto: (imgPath) {
                    addVehicleController.vehiclePhotos
                        .removeWhere((e) => e == imgPath);
                  },
                  onTapRemoveDocument: () {
                    addVehicleController.vccDocument = '';
                  },
                  onTapPreview: (url) {
                    final extension = getFileExtension(url);
                    if (extension == 'jpg' ||
                        extension == 'png' ||
                        extension == 'pdf') {
                      Get.toNamed(AppRoutes.filesPreview, arguments: url);
                    } else {
                      AppToasts.shortToast(Strings.unsupportedFileFormat);
                    }
                  },
                  onTapSubmit: () {
                    if (formKey.currentState!.validate()) {
                      if (addVehicleController.vehiclePhotos.isEmpty) {
                        AppToasts.shortToast(Strings.addVehiclePhotoWarningTxt);
                      } else if (addVehicleController.vccDocument.isEmpty) {
                        AppToasts.shortToast(
                            Strings.addVehicleDocumentWarningTxt);
                      } else if (!addVehicleController
                          .termsAndConditionsAgreed) {
                        AppToasts.shortToast(
                            'termsAgreementAddVehicleWarningTxt'.tr);
                      } else {
                        context.showLoaderOverlay;
                        if (editVehicleInfoData != null) {
                          addVehicleController
                              .editVehicle(vehicleId: editVehicleInfoData!.id)
                              .then((response) async {
                            if (response.isSuccess) {
                              await Get.find<SellMyCarController>()
                                  .fetchVehicles(
                                      pageType: MSellMyCarOptions.allVehicle);
                              context.hideLoaderOverlay;
                              Get.back();
                            } else {
                              context.hideLoaderOverlay;
                            }
                            AppToasts.shortToast(response.message);
                          });
                        } else {
                          addVehicleController.createVehicle().then((response) {
                            context.hideLoaderOverlay;
                            if (response.isSuccess) {
                              Get.back();
                            }
                            AppToasts.shortToast(response.message);
                          });
                        }
                      }
                    }
                  },
                  onTapTermsAndConditions: () {
                    Get.toNamed(AppRoutes.websPreview,
                        arguments: Environment.baseApiUrlV1 +
                            ApiEndpoints.termsAndConditions);
                  }),
            ),
          );
        }
      }),
    );
  }
}
