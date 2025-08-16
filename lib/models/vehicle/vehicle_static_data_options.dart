class VehicleStaticDataOption {
  List<VehiclePartInfo>? bodyStyles;
  List<VehiclePartInfo>? damages;
  List<VehiclePartInfo>? vehicleTypes;
  List<VehiclePartInfo>? transmission;
  List<VehiclePartInfo>? driveTrains;
  List<VehiclePartInfo>? fuelTypes;
  List<VehiclePartInfo>? mileageType;
  List<VehiclePartInfo>? engineType;
  List<VehiclePartInfo>? cylinders;
  List<VehiclePartInfo>? highlights;
  List<VehiclePartInfo>? colors;
  List<VehiclePartInfo>? saleTypes;
  // List<VehiclePartInfo>? saleExecutive;
  // List<VehiclePartInfo>? categories;

  VehicleStaticDataOption(
      {this.bodyStyles,
      this.damages,
      this.vehicleTypes,
      this.transmission,
      this.driveTrains,
      this.fuelTypes,
      this.mileageType,
      this.engineType,
      this.cylinders,
      this.highlights,
      this.colors,
      this.saleTypes,
      // this.saleExecutive,
      // this.categories
      });

  VehicleStaticDataOption.fromJson(Map<String, dynamic> json) {
    if (json['body_styles'] != null) {
      bodyStyles = <VehiclePartInfo>[];
      json['body_styles'].forEach((v) {
        bodyStyles!.add(VehiclePartInfo.fromJson(v));
      });
    }
    if (json['damages'] != null) {
      damages = <VehiclePartInfo>[];
      json['damages'].forEach((v) {
        damages!.add(VehiclePartInfo.fromJson(v));
      });
    }
    if (json['vehicle_types'] != null) {
      vehicleTypes = <VehiclePartInfo>[];
      json['vehicle_types'].forEach((v) {
        vehicleTypes!.add(VehiclePartInfo.fromJson(v));
      });
    }
    if (json['transmission'] != null) {
      transmission = <VehiclePartInfo>[];
      json['transmission'].forEach((v) {
        transmission!.add(VehiclePartInfo.fromJson(v));
      });
    }
    if (json['drive_trains'] != null) {
      driveTrains = <VehiclePartInfo>[];
      json['drive_trains'].forEach((v) {
        driveTrains!.add(VehiclePartInfo.fromJson(v));
      });
    }
    if (json['fuel_types'] != null) {
      fuelTypes = <VehiclePartInfo>[];
      json['fuel_types'].forEach((v) {
        fuelTypes!.add(VehiclePartInfo.fromJson(v));
      });
    }
    if (json['mileage_type'] != null) {
      mileageType = <VehiclePartInfo>[];
      json['mileage_type'].forEach((v) {
        mileageType!.add(VehiclePartInfo.fromJson(v));
      });
    }
    if (json['engine_type'] != null) {
      engineType = <VehiclePartInfo>[];
      json['engine_type'].forEach((v) {
        engineType!.add(VehiclePartInfo.fromJson(v));
      });
    }
    if (json['cylinders'] != null) {
      cylinders = <VehiclePartInfo>[];
      json['cylinders'].forEach((v) {
        cylinders!.add(VehiclePartInfo.fromJson(v));
      });
    }
    if (json['highlights'] != null) {
      highlights = <VehiclePartInfo>[];
      json['highlights'].forEach((v) {
        highlights!.add(VehiclePartInfo.fromJson(v));
      });
    }
    if (json['colors'] != null) {
      colors = <VehiclePartInfo>[];
      json['colors'].forEach((v) {
        colors!.add(VehiclePartInfo.fromJson(v));
      });
    }
    if (json['sale_types'] != null) {
      saleTypes = <VehiclePartInfo>[];
      json['sale_types'].forEach((v) {
        saleTypes!.add(VehiclePartInfo.fromJson(v));
      });
    }
    // if (json['sales_executive'] != null) {
    //   saleExecutive = <VehiclePartInfo>[];
    //   json['sales_executive'].forEach((v) {
    //     saleExecutive!.add(VehiclePartInfo.fromJson(v));
    //   });
    // }
    // if (json['categories'] != null) {
    //   categories = <VehiclePartInfo>[];
    //   json['categories'].forEach((v) {
    //     categories!.add(VehiclePartInfo.fromJson(v));
    //   });
    // }
  }
}

class VehiclePartInfo {
  int? id;
  String? name;
  dynamic color_code;

  VehiclePartInfo({this.id, this.name});

  @override
  String toString() {
    return name ?? '';
  }

  VehiclePartInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color_code = json['color_code'];
  }
}
