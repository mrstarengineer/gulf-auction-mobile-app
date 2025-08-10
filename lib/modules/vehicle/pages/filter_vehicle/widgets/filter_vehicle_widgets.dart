import 'package:flutter/material.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/modules/vehicle/pages/filter_vehicle/filter_vehicle.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/utils.dart';

class FilterVehicleWidgets {
  FilterVehicleWidgets._();

  static Widget submitButton(
      {VoidCallback? onTapBack,
      VoidCallback? onTapReset,
      required String title,
      bool isFav = false,
      ValueChanged<bool>? onTapFav}) {
    return SizedBox(
      height: Dimensions.getWidth(55),
      width: Dimensions.getWidth(55),
      child: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: onTapBack,
        child: AppTexts.smallText(
          text: 'Apply',
          color: AppColors.white,
        ),
      ),
    );
  }

  static Widget optionTitles({
    Map<String, dynamic>?
        filterDataMap, // Use List<dynamic> to handle dynamic types
    required int selectedIndex,
    ValueChanged<int>? onTap,
  }) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: List.generate(
          filterDataMap == null ? 0 : filterDataMap.keys.length,
          (index) {
            String key = filterDataMap!.keys.elementAt(index);
            var value = filterDataMap.values.elementAt(index);
            int count = 0;

            if (value is List) {
              count = value.where((item) => item.checked).length;
            }

            return GestureDetector(
              onTap: () {
                onTap?.call(index);
              },
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.getWidth(10),
                  vertical: Dimensions.getHeight(20),
                ),
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? AppColors.primaryColorLight
                      : Colors.transparent,
                  border: Border(
                    bottom: BorderSide(
                      color: selectedIndex == index
                          ? AppColors.primaryColorLight
                          : AppColors.lightGrey,
                    ),
                    top: BorderSide(
                      color: selectedIndex == index
                          ? AppColors.primaryColorLight
                          : AppColors.lightGrey,
                    ),
                    right: BorderSide(
                      color: selectedIndex == index
                          ? AppColors.red
                          : AppColors.lightGrey,
                      width: selectedIndex == index ? 3 : 1,
                    ),
                  ),
                ),
                child: AppTexts.smallText(
                  text: '$key ${count > 0 ? '($count)' : ''}',
                  // Show count if > 0
                  color: selectedIndex == index
                      ? AppColors.redFontColor
                      : AppColors.baseFontColor,
                  overflow: TextOverflow.visible,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.left,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static Widget optionValueField({
    Map<String, dynamic>? filterDataMap,
    required int selectedIndex,
    required FilterVehicleController filterVehicleController,
    TextEditingController? startController,
    TextEditingController? endController,
  }) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.getHeight(12)),
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: (() {
            if (filterDataMap?.keys.elementAt(selectedIndex) ==
                    MFilterOptions.odometer.value ||
                filterDataMap?.keys.elementAt(selectedIndex) ==
                    MFilterOptions.startBidAmount.value) {
              var value = filterDataMap?.values.elementAt(selectedIndex);
              int startValue = value.minSelected;
              int endValue =
                  value.maxSelected == 0 ? value.max : value.maxSelected;
              startController?.text = startValue.toString();
              endController?.text = endValue.toString();
              return Column(
                children: [
                  // AppTexts.smallText(
                  //     text:
                  //         '${value.minSelected} - ${value.maxSelected == 0 ? value.max : value.maxSelected}'),
                  // AppSlider.rangeSlider(
                  //     currentRangeValue: RangeValues(
                  //         value.minSelected.toDouble(),
                  //         (value.maxSelected == 0
                  //                 ? value.max
                  //                 : value.maxSelected)
                  //             .toDouble()),
                  //     max: value.max.toDouble(),
                  //     divisions: value.max,
                  //     onChanged: (range) {
                  //       if (filterDataMap?.keys.elementAt(selectedIndex) ==
                  //           MFilterOptions.odometer.value) {
                  //         filterVehicleController.odometer =
                  //             '${range.start.round()}-${range.end.round()}';
                  //       } else {
                  //         filterVehicleController.startBidAmount =
                  //             '${range.start.round()}-${range.end.round()}';
                  //       }
                  //       value.minSelected = range.start.round();
                  //       value.maxSelected = range.end.round();
                  //     }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AppTextFields.textFieldWithTitle(
                          title: 'Start',
                          controller: startController,
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            final num = int.tryParse(text ?? '0') ?? startValue;
                            if (num <= endValue &&
                                num >= 0 &&
                                num <= value.max) {
                              startValue = num;
                              value.minSelected = startValue;
                              if (filterDataMap?.keys
                                      .elementAt(selectedIndex) ==
                                  MFilterOptions.odometer.value) {
                                filterVehicleController.odometer =
                                    '${startValue.round()}-${endValue.round()}';
                              } else {
                                filterVehicleController.startBidAmount =
                                    '${startValue.round()}-${endValue.round()}';
                              }
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: AppTextFields.textFieldWithTitle(
                          title: 'End',
                          controller: endController,
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            final num = int.tryParse(text ?? '0') ?? endValue;
                            if (num >= startValue && num <= value.max) {
                              endValue = num;
                              value.maxSelected = endValue;

                              if (filterDataMap?.keys
                                      .elementAt(selectedIndex) ==
                                  MFilterOptions.odometer.value) {
                                filterVehicleController.odometer =
                                    '${startValue.round()}-${endValue.round()}';
                              } else {
                                filterVehicleController.startBidAmount =
                                    '${startValue.round()}-${endValue.round()}';
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else if (filterDataMap?.keys.elementAt(selectedIndex) ==
                MFilterOptions.saleDate.value) {
              var value = filterDataMap?.values.elementAt(selectedIndex);
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 1, child: AppTexts.smallText(text: 'From :')),
                      SizedBox(
                        width: Dimensions.getWidth(10),
                      ),
                      Expanded(
                          flex: 4,
                          child: AppPickersButtons.filterVehicleDateTimePicker(
                              selectedDate: value.startSelected,
                              onTap: () {
                                AppPickers.datePicker().then((dateTime) {
                                  if (dateTime != null) {
                                    if (value.endSelected == null ||
                                        value.endSelected.isEmpty) {
                                      value.startSelected =
                                          AppConversions.formatDateTime20241230(
                                              dateTime);
                                      value.endSelected =
                                          AppConversions.formatDateTime20241230(
                                              DateTime.now());
                                      filterVehicleController.saleDate =
                                          '${value.startSelected}to${value.endSelected}';
                                    } else {
                                      String endSelectedFormatted =
                                          AppConversions.formatDateToISO8601(
                                              value.endSelected);
                                      DateTime endDate =
                                          DateTime.parse(endSelectedFormatted);
                                      if (dateTime.isAfter(endDate)) {
                                        AppToasts.shortToast(
                                            Strings.enterValidDate);
                                      } else {
                                        value.startSelected = AppConversions
                                            .formatDateTime20241230(dateTime);
                                        filterVehicleController.saleDate =
                                            '${value.startSelected}to${value.endSelected}';
                                      }
                                    }
                                  }
                                });
                              }))
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.getHeight(10),
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1, child: AppTexts.smallText(text: 'To :')),
                      SizedBox(
                        width: Dimensions.getWidth(10),
                      ),
                      Expanded(
                          flex: 4,
                          child: AppPickersButtons.filterVehicleDateTimePicker(
                              selectedDate: value.endSelected,
                              onTap: () {
                                AppPickers.datePicker().then((dateTime) {
                                  if (dateTime != null) {
                                    if (value.startSelected == null ||
                                        value.startSelected.isEmpty) {
                                      value.startSelected =
                                          AppConversions.formatDateTime20241230(
                                              DateTime(dateTime.year - 1));
                                      value.endSelected =
                                          AppConversions.formatDateTime20241230(
                                              dateTime);
                                      filterVehicleController.saleDate =
                                          '${value.startSelected}to${value.endSelected}';
                                    } else {
                                      String startSelectedFormatted =
                                          AppConversions.formatDateToISO8601(
                                              value.startSelected);
                                      DateTime startDate = DateTime.parse(
                                          startSelectedFormatted);
                                      if (dateTime.isBefore(startDate)) {
                                        AppToasts.shortToast(
                                            Strings.enterValidDate);
                                      } else {
                                        value.endSelected = AppConversions
                                            .formatDateTime20241230(dateTime);
                                        filterVehicleController.saleDate =
                                            '${value.startSelected}to${value.endSelected}';
                                      }
                                    }
                                  }
                                });
                              }))
                    ],
                  ),
                ],
              );
            } else if (filterDataMap?.keys.elementAt(selectedIndex) ==
                MFilterOptions.year.value) {
              var value = filterDataMap?.values.elementAt(selectedIndex);
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 1, child: AppTexts.smallText(text: 'From :')),
                      SizedBox(
                        width: Dimensions.getWidth(10),
                      ),
                      Expanded(
                          flex: 4,
                          child: AppPickersButtons.filterVehicleYearPicker(
                              selectedDate:
                                  '${value.startSelected == null || value.startSelected == 0 ? '-' : value.startSelected}',
                              onTap: () {
                                AppPickers.yearPicker(
                                        currentYear: DateTime.now().year)
                                    .then((year) {
                                  if (year != null) {
                                    if (value.endSelected == null ||
                                        value.endSelected == 0) {
                                      value.startSelected = year;
                                      value.endSelected = DateTime.now().year;
                                      filterVehicleController.year =
                                          '${value.startSelected}-${value.endSelected}';
                                    } else {
                                      if (year > value.endSelected) {
                                        AppToasts.shortToast(
                                            Strings.enterValidDate);
                                      } else {
                                        value.startSelected = year;
                                        filterVehicleController.year =
                                            '${value.startSelected}-${value.endSelected}';
                                      }
                                    }
                                  }
                                });
                              }))
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.getHeight(10),
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1, child: AppTexts.smallText(text: 'To :')),
                      SizedBox(
                        width: Dimensions.getWidth(10),
                      ),
                      Expanded(
                          flex: 4,
                          child: AppPickersButtons.filterVehicleYearPicker(
                              selectedDate:
                                  '${value.endSelected == null || value.endSelected == 0 ? '-' : value.endSelected}',
                              onTap: () {
                                AppPickers.yearPicker(
                                        currentYear: DateTime.now().year)
                                    .then((year) {
                                  if (year != null) {
                                    if (value.startSelected == null ||
                                        value.startSelected == 0) {
                                      value.endSelected = year;
                                      value.startSelected = year - 5;
                                      filterVehicleController.year =
                                          '${value.startSelected}-${value.endSelected}';
                                    } else {
                                      if (year < value.startSelected) {
                                        AppToasts.shortToast(
                                            Strings.enterValidDate);
                                      } else {
                                        value.endSelected = year;
                                        filterVehicleController.year =
                                            '${value.startSelected}-${value.endSelected}';
                                      }
                                    }
                                  }
                                });
                              }))
                    ],
                  ),
                ],
              );
            } else {
              return Column(
                  children: List.generate(
                      filterDataMap == null
                          ? 0
                          : filterDataMap.values
                              .elementAt(selectedIndex)
                              .length, (index) {
                var value =
                    filterDataMap?.values.elementAt(selectedIndex)[index];
                var isTypeNewlyAddedVehicle =
                    filterDataMap?.keys.elementAt(selectedIndex) ==
                        MFilterOptions.newlyAddedVehicles.value;
                var isTypeFuelTypes =
                    filterDataMap?.keys.elementAt(selectedIndex) ==
                        MFilterOptions.fuelTypes.value;
                var isTypeDriveTrains =
                    filterDataMap?.keys.elementAt(selectedIndex) ==
                        MFilterOptions.driveTrains.value;
                var isTypeCylinders =
                    filterDataMap?.keys.elementAt(selectedIndex) ==
                        MFilterOptions.cylinders.value;
                var isTypeBodyStyles =
                    filterDataMap?.keys.elementAt(selectedIndex) ==
                        MFilterOptions.bodyStyles.value;
                var isTypeTransmissions =
                    filterDataMap?.keys.elementAt(selectedIndex) ==
                        MFilterOptions.transmissions.value;
                var isTypeMakes =
                    filterDataMap?.keys.elementAt(selectedIndex) ==
                        MFilterOptions.makes.value;
                var isTypeModels =
                    filterDataMap?.keys.elementAt(selectedIndex) ==
                        MFilterOptions.models.value;
                var isTypeEngineTypes =
                    filterDataMap?.keys.elementAt(selectedIndex) ==
                        MFilterOptions.engineTypes.value;
                var isTypeColors =
                    filterDataMap?.keys.elementAt(selectedIndex) ==
                        MFilterOptions.colors.value;
                return Container(
                  margin: EdgeInsets.only(bottom: Dimensions.getHeight(5)),
                  child: Row(
                    children: [
                      AppButtons.checkBox(
                        value: value.checked,
                        onChanged: (bool? isChecked) {
                          if (isChecked != null) {
                            if (!isChecked) {
                              if (isTypeNewlyAddedVehicle) {
                                filterVehicleController.newlyAddedVehicle = '';
                              } else if (isTypeFuelTypes) {
                                filterVehicleController.fuelTypes
                                    .remove(value.id);
                              } else if (isTypeDriveTrains) {
                                filterVehicleController.driveTrains
                                    .remove(value.id);
                              } else if (isTypeCylinders) {
                                filterVehicleController.cylinders
                                    .remove(value.id);
                              } else if (isTypeBodyStyles) {
                                filterVehicleController.bodyStyles
                                    .remove(value.id);
                              } else if (isTypeTransmissions) {
                                filterVehicleController.transmissions
                                    .remove(value.id);
                              } else if (isTypeMakes) {
                                filterVehicleController.makes.remove(value.id);
                              } else if (isTypeModels) {
                                filterVehicleController.models.remove(value.id);
                              } else if (isTypeEngineTypes) {
                                filterVehicleController.engineTypes
                                    .remove(value.id);
                              } else if (isTypeColors) {
                                filterVehicleController.colors.remove(value.id);
                              }
                            } else {
                              if (isTypeNewlyAddedVehicle) {
                                filterVehicleController.newlyAddedVehicle =
                                    value.key;
                              } else if (isTypeFuelTypes) {
                                filterVehicleController.fuelTypes.add(value.id);
                              } else if (isTypeCylinders) {
                                filterVehicleController.cylinders.add(value.id);
                              } else if (isTypeBodyStyles) {
                                filterVehicleController.bodyStyles
                                    .add(value.id);
                              } else if (isTypeTransmissions) {
                                filterVehicleController.transmissions
                                    .add(value.id);
                              } else if (isTypeMakes) {
                                filterVehicleController.makes.add(value.id);
                              } else if (isTypeModels) {
                                filterVehicleController.models.add(value.id);
                              } else if (isTypeEngineTypes) {
                                filterVehicleController.engineTypes
                                    .add(value.id);
                              } else if (isTypeColors) {
                                filterVehicleController.colors.add(value.id);
                              }
                            }

                            value.checked = isChecked;

                            if (isTypeNewlyAddedVehicle) {
                              for (var otherItem in filterDataMap?.values
                                      .elementAt(selectedIndex) ??
                                  []) {
                                if (otherItem != value) {
                                  otherItem.checked = false;
                                }
                              }
                            }
                          }
                        },
                      ),
                      Expanded(
                        child: AppTexts.smallText(
                            text:
                                '${isTypeNewlyAddedVehicle ? value.label : value.name}',
                            overflow: TextOverflow.visible),
                      ),
                      isTypeColors
                          ? Container(
                              width: Dimensions.getWidth(40),
                              height: Dimensions.getHeight(20),
                              decoration: BoxDecoration(
                                  color: value.color_code == null
                                      ? AppColors.primaryColor
                                      : HexColor.fromHex(value.color_code),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.getHeight(2))),
                            )
                          : const SizedBox.shrink()
                    ],
                  ),
                );
              }));
            }
          }())),
    );
  }
}
