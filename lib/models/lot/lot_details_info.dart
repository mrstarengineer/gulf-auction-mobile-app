class LotDetailsInfo {
  int? id;
  String? thumbnailUrl;
  String? title;
  String? vin;
  String? lotNumber;
  int? itemNumber;
  String? serial;
  String? bidStatusName;
  int? currentBidAmount;
  int? bidIncrement;
  String? currency;
  String? saleType;
  String? saleTypeHelpText;
  String? saleName;
  int? auctionYardId;
  String? auctionYardName;
  String? saleDate;
  String? saleTime;
  String? color;
  dynamic note;
  String? keysName;
  int? startBidAmount;
  dynamic reserveAmount;
  String? odometer;
  dynamic titleCodeId;
  dynamic titleCode;
  String? mileageType;
  String? highlight;
  String? primaryDamage;
  String? secondaryDamage;
  String? bodyStyle;
  dynamic vehicleType;
  String? engineType;
  String? cylinder;
  String? transmission;
  String? driveTrain;
  String? fuelType;
  List<LotVehicleImages>? vehicleImages;
  int? vehicleStatus;
  int? categoryId;
  String? categoryName;
  dynamic locationId;
  int? auctionId;
  int? auctionType;
  int? auctionStatus;
  String? auctionAt;
  String? auctionCreatedAt;
  String? remainingTime;
  String? updatedAt;
  bool? isWatched;
  String? shareableUrl;
  int? myMaxBid;
  int? maxMinimumBid;
  int? minimumBid;

  LotDetailsInfo(
      {this.id,
        this.thumbnailUrl,
        this.title,
        this.vin,
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
        this.myMaxBid,
        this.maxMinimumBid,
        this.minimumBid});

  LotDetailsInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumbnailUrl = json['thumbnail_url'];
    title = json['title'];
    vin = json['vin'];
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
      vehicleImages = <LotVehicleImages>[];
      json['vehicle_images'].forEach((v) {
        vehicleImages!.add(LotVehicleImages.fromJson(v));
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
    myMaxBid = json['my_max_bid'];
    maxMinimumBid = json['max_minimum_bid'];
    minimumBid = json['minimum_bid'];
  }

}

class LotVehicleImages {
  String? url;
  String? thumbnailUrl;

  LotVehicleImages({this.url, this.thumbnailUrl});

  LotVehicleImages.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    thumbnailUrl = json['thumbnail_url'];
  }


}