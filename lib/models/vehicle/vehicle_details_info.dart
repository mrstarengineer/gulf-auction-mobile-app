import 'package:gulf_car_auction/models/vehicle/vehicle_images.dart';

class VehicleDetailsData {
  int? id;
  String? thumbnailUrl;
  String? title;
  String? vin;
  String? vinMask;
  String? lotNumber;
  dynamic itemNumber;
  String? serial;
  String? bidStatusName;
  int? currentBidAmount;
  int? bidIncrement;
  String? currency;
  String? saleType;
  String? saleTypeHelpText;
  dynamic saleName;
  dynamic auctionYardId;
  dynamic auctionYardName;
  String? saleDate;
  String? saleTime;
  String? color;
  dynamic note;
  String? keysName;
  dynamic startBidAmount;
  dynamic reserveAmount;
  String? odometer;
  dynamic titleCodeId;
  dynamic titleCode;
  String? mileageType;
  String? highlight;
  dynamic primaryDamage;
  dynamic secondaryDamage;
  dynamic bodyStyle;
  dynamic vehicleType;
  String? engineType;
  String? cylinder;
  String? transmission;
  String? driveTrain;
  String? fuelType;
  List<VehicleImages>? vehicleImages;
  int? vehicleStatus;
  int? categoryId;
  String? categoryName;
  dynamic locationId;
  dynamic auctionId;
  dynamic auctionType;
  dynamic auctionStatus;
  String? auctionAt;
  String? auctionCreatedAt;
  String? remainingTime;
  String? updatedAt;
  bool? isWatched;
  String? shareableUrl;
  bool? eligible;
  int? myMaxBid;
  int? sellingPrice;
  int? maxMinimumBid;
  int? minimumBid;

  VehicleDetailsData(
      {this.id,
        this.thumbnailUrl,
        this.title,
        this.vin,
        this.vinMask,
        this.lotNumber,
        this.itemNumber,
        this.serial,
        this.bidStatusName,
        this.currentBidAmount,
        this.bidIncrement,
        this.currency,
        this.saleType,
        this.saleTypeHelpText,
        this.saleName,
        this.auctionYardId,
        this.auctionYardName,
        this.saleDate,
        this.saleTime,
        this.color,
        this.note,
        this.keysName,
        this.startBidAmount,
        this.reserveAmount,
        this.odometer,
        this.titleCodeId,
        this.titleCode,
        this.mileageType,
        this.highlight,
        this.primaryDamage,
        this.secondaryDamage,
        this.bodyStyle,
        this.vehicleType,
        this.engineType,
        this.cylinder,
        this.transmission,
        this.driveTrain,
        this.fuelType,
        this.vehicleImages,
        this.vehicleStatus,
        this.categoryId,
        this.categoryName,
        this.locationId,
        this.auctionId,
        this.auctionType,
        this.auctionStatus,
        this.auctionAt,
        this.auctionCreatedAt,
        this.remainingTime,
        this.updatedAt,
        this.isWatched,
        this.shareableUrl,
        this.eligible,
        this.myMaxBid,
        this.sellingPrice,
        this.maxMinimumBid,
        this.minimumBid});

  VehicleDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumbnailUrl = json['thumbnail_url'];
    title = json['title'];
    vin = json['vin'];
    vinMask = json['vin_mask'];
    lotNumber = json['lot_number'];
    itemNumber = json['item_number'];
    serial = json['serial'];
    bidStatusName = json['bid_status_name'];
    currentBidAmount = json['current_bid_amount'];
    bidIncrement = json['bid_increment'];
    currency = json['currency'];
    saleType = json['sale_type'];
    saleTypeHelpText = json['sale_type_help_text'];
    saleName = json['sale_name'];
    auctionYardId = json['auction_yard_id'];
    auctionYardName = json['auction_yard_name'];
    saleDate = json['sale_date'];
    saleTime = json['sale_time'];
    color = json['color'];
    note = json['note'];
    keysName = json['keys_name'];
    startBidAmount = json['start_bid_amount'];
    reserveAmount = json['reserve_amount'];
    odometer = json['odometer'];
    titleCodeId = json['title_code_id'];
    titleCode = json['title_code'];
    mileageType = json['mileage_type'];
    highlight = json['highlight'];
    primaryDamage = json['primary_damage'];
    secondaryDamage = json['secondary_damage'];
    bodyStyle = json['body_style'];
    vehicleType = json['vehicle_type'];
    engineType = json['engine_type'];
    cylinder = json['cylinder'];
    transmission = json['transmission'];
    driveTrain = json['drive_train'];
    fuelType = json['fuel_type'];
    if (json['vehicle_images'] != null) {
      vehicleImages = <VehicleImages>[];
      json['vehicle_images'].forEach((v) {
        vehicleImages!.add(VehicleImages.fromJson(v));
      });
    }
    vehicleStatus = json['vehicle_status'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    locationId = json['location_id'];
    auctionId = json['auction_id'];
    auctionType = json['auction_type'];
    auctionStatus = json['auction_status'];
    auctionAt = json['auction_at'];
    auctionCreatedAt = json['auction_created_at'];
    remainingTime = json['remaining_time'];
    updatedAt = json['updated_at'];
    isWatched = json['is_watched'];
    shareableUrl = json['shareable_url'];
    eligible = json['eligible'];
    myMaxBid = json['my_max_bid'];
    sellingPrice = json['selling_price'];
    maxMinimumBid = json['max_minimum_bid'];
    minimumBid = json['minimum_bid'];
  }
}
