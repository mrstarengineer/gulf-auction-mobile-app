import 'package:get/get.dart';
import 'package:gulf_car_auction/models/vehicle/vehicle_images.dart';
import '../meta/meta.dart';

class VehicleInfo {
  RxList<VehicleData>? data = <VehicleData>[].obs;
  Meta? meta;

  VehicleInfo({data, meta});

  VehicleInfo.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <VehicleData>[].obs;  // Initialize as RxList
      json['data'].forEach((v) {
        data?.add(VehicleData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}

class VehicleData {
  int? id;
  String? title;
  String? vin;
  String? thumbnailUrl;
  String? lotNumber;
  String? year;
  int? makeId;
  String? make;
  int? modelId;
  String? model;
  String? color;
  int? categoryId;
  dynamic startBidAmount;
  dynamic currentBidAmount;
  String? currency;
  dynamic nextBidAmount;
  String? bidStatusName;
  int? itemNumber;
  String? serial;
  String? saleName;
  int? auctionYardId;
  String? auctionYardName;
  String? saleDate;
  String? saleTime;
  String? keys;
  dynamic titleCode;
  String? odometer;
  String? mileageType;
  String? highlight;
  String? seller;
  String? primaryDamage;
  String? secondaryDamage;
  dynamic sellingPrice;
  String? bodyStyle;
  dynamic vehicleType;
  String? engineType;
  String? cylinder;
  String? transmission;
  String? drive;
  String? fuelType;
  bool? featured;
  List<VehicleImages>? vehicleImages;
  dynamic note;
  bool? isWatched;
  int? auctionId;
  bool? isUpcoming;
  int? auctionStatus;
  int? auctionType;
  String? remainingTime;

  VehicleData(
      {id,
        title,
        vin,
        thumbnailUrl,
        lotNumber,
        year,
        makeId,
        make,
        modelId,
        model,
        color,
        categoryId,
        startBidAmount,
        currentBidAmount,
        currency,
        nextBidAmount,
        bidStatusName,
        itemNumber,
        serial,
        saleName,
        auctionYardId,
        auctionYardName,
        saleDate,
        saleTime,
        keys,
        titleCode,
        odometer,
        mileageType,
        highlight,
        seller,
        primaryDamage,
        secondaryDamage,
        sellingPrice,
        bodyStyle,
        vehicleType,
        engineType,
        cylinder,
        transmission,
        drive,
        fuelType,
        featured,
        vehicleImages,
        note,
        isWatched,
        auctionId,
        isUpcoming,
        auctionStatus,
        auctionType,
        remainingTime});

  VehicleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    vin = json['vin'];
    thumbnailUrl = json['thumbnail_url'];
    lotNumber = json['lot_number'];
    year = json['year'];
    makeId = json['make_id'];
    make = json['make'];
    modelId = json['model_id'];
    model = json['model'];
    color = json['color'];
    categoryId = json['category_id'];
    startBidAmount = json['start_bid_amount'];
    currentBidAmount = json['current_bid_amount'];
    currency = json['currency'];
    nextBidAmount = json['next_bid_amount'];
    bidStatusName = json['bid_status_name'];
    itemNumber = json['item_number'];
    serial = json['serial'];
    saleName = json['sale_name'];
    auctionYardId = json['auction_yard_id'];
    auctionYardName = json['auction_yard_name'];
    saleDate = json['sale_date'];
    saleTime = json['sale_time'];
    keys = json['keys'];
    titleCode = json['title_code'];
    odometer = json['odometer'];
    mileageType = json['mileage_type'];
    highlight = json['highlight'];
    seller = json['seller'];
    primaryDamage = json['primary_damage'];
    secondaryDamage = json['secondary_damage'];
    sellingPrice = json['selling_price'];
    bodyStyle = json['body_style'];
    vehicleType = json['vehicle_type'];
    engineType = json['engine_type'];
    cylinder = json['cylinder'];
    transmission = json['transmission'];
    drive = json['drive'];
    fuelType = json['fuel_type'];
    featured = json['featured'];
    if (json['vehicle_images'] != null) {
      vehicleImages = <VehicleImages>[];
      json['vehicle_images'].forEach((v) {
        vehicleImages!.add(VehicleImages.fromJson(v));
      });
    }
    note = json['note'];
    isWatched = json['is_watched'];
    auctionId = json['auction_id'];
    isUpcoming = json['is_upcoming'];
    auctionStatus = json['auction_status'];
    auctionType = json['auction_type'];
    remainingTime = json['remaining_time'];
  }

}

