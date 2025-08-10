import 'package:get/get.dart';
import 'package:gulf_car_auction/settings/settings.dart';

class FilterVehicleData {
  final List<NewlyAddedVehicle>? newlyAddedVehicles;
  final AmountRange? odometer;
  final AmountRange? startBidAmount;
  final YearRange? year;
  final DateRange? saleDate;
  final List<FuelType>? fuelTypes;
  final List<DriveTrain>? driveTrains;
  final List<Cylinder>? cylinders;
  final List<BodyStyle>? bodyStyles;
  final List<Transmission>? transmissions;
  final List<Make>? makes;
  final List<Model>? models;
  final List<EngineType>? engineTypes;
  final List<Color>? colors;
  final String? vinLot;

  FilterVehicleData({
    this.newlyAddedVehicles,
    this.odometer,
    this.startBidAmount,
    this.year,
    this.saleDate,
    this.fuelTypes,
    this.driveTrains,
    this.cylinders,
    this.bodyStyles,
    this.transmissions,
    this.makes,
    this.models,
    this.engineTypes,
    this.colors,
    this.vinLot,
  });

  factory FilterVehicleData.fromJson(Map<String, dynamic> json) {
    return FilterVehicleData(
      newlyAddedVehicles: (json['newly_added_vehicles'] as List<dynamic>?)
          ?.map((e) => NewlyAddedVehicle.fromJson(e))
          .toList(),
      odometer: json['odometer'] != null
          ? AmountRange.fromJson(json['odometer'])
          : null,
      startBidAmount: json['start_bid_amount'] != null
          ? AmountRange.fromJson(json['start_bid_amount'])
          : null,
      year: json['year'] != null ? YearRange.fromJson(json['year']) : null,
      saleDate: json['sale_date'] != null
          ? DateRange.fromJson(json['sale_date'])
          : null,
      fuelTypes: (json['fuel_types'] as List<dynamic>?)
          ?.map((e) => FuelType.fromJson(e))
          .toList(),
      driveTrains: (json['drive_trains'] as List<dynamic>?)
          ?.map((e) => DriveTrain.fromJson(e))
          .toList(),
      cylinders: (json['cylinders'] as List<dynamic>?)
          ?.map((e) => Cylinder.fromJson(e))
          .toList(),
      bodyStyles: (json['body_styles'] as List<dynamic>?)
          ?.map((e) => BodyStyle.fromJson(e))
          .toList(),
      transmissions: (json['transmissions'] as List<dynamic>?)
          ?.map((e) => Transmission.fromJson(e))
          .toList(),
      makes: (json['makes'] as List<dynamic>?)
          ?.map((e) => Make.fromJson(e))
          .toList(),
      models: (json['models'] as List<dynamic>?)
          ?.map((e) => Model.fromJson(e))
          .toList(),
      engineTypes: (json['engine_types'] as List<dynamic>?)
          ?.map((e) => EngineType.fromJson(e))
          .toList(),
      colors: (json['colors'] as List<dynamic>?)
          ?.map((e) => Color.fromJson(e))
          .toList(),
      vinLot: json['vin_lot'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      MFilterOptions.newlyAddedVehicles.value: newlyAddedVehicles,
      MFilterOptions.odometer.value: odometer,
      MFilterOptions.startBidAmount.value: startBidAmount,
      MFilterOptions.year.value: year,
      MFilterOptions.saleDate.value: saleDate,
      MFilterOptions.fuelTypes.value: fuelTypes,
      MFilterOptions.driveTrains.value: driveTrains,
      MFilterOptions.cylinders.value: cylinders,
      MFilterOptions.bodyStyles.value: bodyStyles,
      MFilterOptions.transmissions.value: transmissions,
      MFilterOptions.makes.value: makes,
      MFilterOptions.models.value: models,
      MFilterOptions.engineTypes.value: engineTypes,
      MFilterOptions.colors.value: colors,
    };
  }
}

class NewlyAddedVehicle {
  final String? key;
  final String? label;
  final String? name;
  final bool? isSelected;
  final RxBool _checked;

  NewlyAddedVehicle({
    this.key,
    this.label,
    this.name,
    this.isSelected,
    bool checked = false,
  }) : _checked = checked.obs;

  factory NewlyAddedVehicle.fromJson(Map<String, dynamic> json) {
    return NewlyAddedVehicle(
      key: json['key'] as String?,
      label: json['label'] as String?,
      name: json['name'] as String?,
      isSelected: json['is_selected'] as bool?,
      checked: json['checked'] as bool? ?? false,
    );
  }

  bool get checked => _checked.value;

  set checked(bool value) => _checked.value = value;
}

class AmountRange {
  final int? min;
  final int? max;
  final RxInt _minSelected;
  final RxInt _maxSelected;

  AmountRange({
    this.min,
    this.max,
    int minSelected = 0,
    int maxSelected = 0,
  })  : _minSelected = minSelected.obs,
        _maxSelected = maxSelected.obs;

  factory AmountRange.fromJson(Map<String, dynamic> json) {
    return AmountRange(
      min: json['min'] as int?,
      max: json['max'] as int?,
      minSelected: json['min_selected'] as int? ?? 0,
      maxSelected: json['max_selected'] as int? ?? 0,
    );
  }

  int get minSelected => _minSelected.value;

  set minSelected(int value) => _minSelected.value = value;

  int get maxSelected => _maxSelected.value;

  set maxSelected(int value) => _maxSelected.value = value;
}

class YearRange {
  final int? start;
  final int? end;
  final RxInt _startSelected;
  final RxInt _endSelected;

  YearRange({
    this.start,
    this.end,
    int startSelected = 0,
    int endSelected = 0,
  })  : _startSelected = startSelected.obs,
        _endSelected = endSelected.obs;

  factory YearRange.fromJson(Map<String, dynamic> json) {
    return YearRange(
      start: json['start'] as int?,
      end: json['end'] as int?,
      startSelected: json['start_selected'] as int? ?? 0,
      endSelected: json['end_selected'] as int? ?? 0,
    );
  }

  int get startSelected => _startSelected.value;

  set startSelected(int value) => _startSelected.value = value;

  int get endSelected => _endSelected.value;

  set endSelected(int value) => _endSelected.value = value;
}

class DateRange {
  final String? start;
  final String? end;
  final RxString _startSelected;
  final RxString _endSelected;

  DateRange({
    this.start,
    this.end,
    String startSelected = '',
    String endSelected = '',
  })  : _startSelected = startSelected.obs,
        _endSelected = endSelected.obs;

  factory DateRange.fromJson(Map<String, dynamic> json) {
    return DateRange(
      start: json['start'] as String?,
      end: json['end'] as String?,
      startSelected: json['start_selected'] as String? ?? '',
      endSelected: json['end_selected'] as String? ?? '',
    );
  }

  String get startSelected => _startSelected.value;

  set startSelected(String value) => _startSelected.value = value;

  String get endSelected => _endSelected.value;

  set endSelected(String value) => _endSelected.value = value;
}

class FuelType {
  final int? id;
  final String? name;
  final int? count;
  final RxBool _checked;

  FuelType({
    this.id,
    this.name,
    this.count,
    bool checked = false,
  }) : _checked = checked.obs;

  factory FuelType.fromJson(Map<String, dynamic> json) {
    return FuelType(
      id: json['id'] as int?,
      name: json['name'] as String?,
      count: json['count'] as int?,
      checked: json['checked'] as bool? ?? false,
    );
  }

  bool get checked => _checked.value;

  set checked(bool value) => _checked.value = value;
}

class DriveTrain {
  final int? id;
  final String? name;
  final int? count;
  final RxBool _checked;

  DriveTrain({
    this.id,
    this.name,
    this.count,
    bool checked = false,
  }) : _checked = checked.obs;

  factory DriveTrain.fromJson(Map<String, dynamic> json) {
    return DriveTrain(
      id: json['id'] as int?,
      name: json['name'] as String?,
      count: json['count'] as int?,
      checked: json['checked'] as bool? ?? false,
    );
  }

  bool get checked => _checked.value;

  set checked(bool value) => _checked.value = value;
}

class Cylinder {
  final int? id;
  final String? name;
  final int? count;
  final RxBool _checked;

  Cylinder({
    this.id,
    this.name,
    this.count,
    bool checked = false,
  }) : _checked = checked.obs;

  factory Cylinder.fromJson(Map<String, dynamic> json) {
    return Cylinder(
      id: json['id'] as int?,
      name: json['name'] as String?,
      count: json['count'] as int?,
      checked: json['checked'] as bool? ?? false,
    );
  }

  bool get checked => _checked.value;

  set checked(bool value) => _checked.value = value;
}

class BodyStyle {
  final int? id;
  final String? name;
  final int? count;
  final RxBool _checked;

  BodyStyle({
    this.id,
    this.name,
    this.count,
    bool checked = false,
  }) : _checked = checked.obs;

  factory BodyStyle.fromJson(Map<String, dynamic> json) {
    return BodyStyle(
      id: json['id'] as int?,
      name: json['name'] as String?,
      count: json['count'] as int?,
      checked: json['checked'] as bool? ?? false,
    );
  }

  bool get checked => _checked.value;

  set checked(bool value) => _checked.value = value;
}

class Transmission {
  final int? id;
  final String? name;
  final int? count;
  final RxBool _checked;

  Transmission({
    this.id,
    this.name,
    this.count,
    bool checked = false,
  }) : _checked = checked.obs;

  factory Transmission.fromJson(Map<String, dynamic> json) {
    return Transmission(
      id: json['id'] as int?,
      name: json['name'] as String?,
      count: json['count'] as int?,
      checked: json['checked'] as bool? ?? false,
    );
  }

  bool get checked => _checked.value;

  set checked(bool value) => _checked.value = value;
}

class Make {
  final int? id;
  final String? name;
  final int? count;
  final RxBool _checked;

  Make({
    this.id,
    this.name,
    this.count,
    bool checked = false,
  }) : _checked = checked.obs;

  factory Make.fromJson(Map<String, dynamic> json) {
    return Make(
      id: json['id'] as int?,
      name: json['name'] as String?,
      count: json['count'] as int?,
      checked: json['checked'] as bool? ?? false,
    );
  }

  bool get checked => _checked.value;

  set checked(bool value) => _checked.value = value;
}

class Model {
  final int? id;
  final String? name;
  final int? count;
  final RxBool _checked;

  Model({
    this.id,
    this.name,
    this.count,
    bool checked = false,
  }) : _checked = checked.obs;

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      id: json['id'] as int?,
      name: json['name'] as String?,
      count: json['count'] as int?,
      checked: json['checked'] as bool? ?? false,
    );
  }

  bool get checked => _checked.value;

  set checked(bool value) => _checked.value = value;
}

class EngineType {
  final int? id;
  final String? name;
  final int? count;
  final RxBool _checked;

  EngineType({
    this.id,
    this.name,
    this.count,
    bool checked = false,
  }) : _checked = checked.obs;

  factory EngineType.fromJson(Map<String, dynamic> json) {
    return EngineType(
      id: json['id'] as int?,
      name: json['name'] as String?,
      count: json['count'] as int?,
      checked: json['checked'] as bool? ?? false,
    );
  }

  bool get checked => _checked.value;

  set checked(bool value) => _checked.value = value;
}

class Color {
  final int? id;
  final String? name;
  final String? color_code;
  final int? count;
  final RxBool _checked;

  Color({
    this.id,
    this.name,
    this.color_code,
    this.count,
    bool checked = false,
  }) : _checked = checked.obs;

  factory Color.fromJson(Map<String, dynamic> json) {
    return Color(
      id: json['id'] as int?,
      name: json['name'] as String?,
      color_code: json['color_code'] as String?,
      count: json['count'] as int?,
      checked: json['checked'] as bool? ?? false,
    );
  }

  bool get checked => _checked.value;

  set checked(bool value) => _checked.value = value;
}
