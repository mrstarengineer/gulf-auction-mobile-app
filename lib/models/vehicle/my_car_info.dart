import 'package:gulf_car_auction/models/models.dart';

class MyCarInfo {
  int? id;
  String? vin;
  String? lotNumber;
  String? thumbnailUrl;
  String? year;
  int? makeId;
  String? make;
  int? vehicleModelId;
  String? model;
  int? colorId;
  String? color;
  int? status;
  String? statusName;
  dynamic note;
  dynamic keys;
  String? keysName;
  int? retailValue;
  int? sellingPrice;
  int? reserveAmount;
  int? startBidAmount;
  int? odometer;
  int? saleType;
  String? saleTypeName;
  String? trim;
  dynamic titleCodeId;
  dynamic titleCode;
  dynamic mileageTypeId;
  dynamic mileageType;
  dynamic highlightId;
  dynamic highlight;
  int? categoryId;
  String? categoryName;
  int? sellerId;
  dynamic commission;
  String? seller;
  int? primaryDamageId;
  dynamic primaryDamage;
  int? secondaryDamageId;
  dynamic secondaryDamage;
  int? bodyStyleId;
  dynamic bodyStyle;
  dynamic vehicleTypeId;
  dynamic vehicleType;
  int? engineTypeId;
  String? engineType;
  int? cylinderId;
  String? cylinder;
  int? transmissionId;
  String? transmission;
  int? driveTrainId;
  String? driveTrain;
  int? fuelTypeId;
  int? salesExecutiveId;
  String? fuelType;
  dynamic rejectionNote;
  FileUrls? fileUrls;
  List<VehicleImages>? vehicleImages;
  List<CounterOffers>? counterOffers;
  SellerDetail? sellerDetail;
  int? auctionId;
  String? createdAt;
  bool? showHandedOverButton;
  String? paymentStatus;
  dynamic vccDocument;
  dynamic gatepassGeneratedDate;
  int? runs;
  Auction? auction;

  MyCarInfo(
      {this.id,
      this.vin,
      this.lotNumber,
      this.thumbnailUrl,
      this.salesExecutiveId,
      this.year,
      this.makeId,
      this.make,
      this.vehicleModelId,
      this.model,
      this.colorId,
      this.color,
      this.trim,
      this.status,
      this.statusName,
      this.note,
      this.keys,
      this.keysName,
      this.retailValue,
      this.sellingPrice,
      this.reserveAmount,
      this.startBidAmount,
      this.odometer,
      this.saleType,
      this.saleTypeName,
      this.titleCodeId,
      this.titleCode,
      this.mileageTypeId,
      this.mileageType,
      this.highlightId,
      this.highlight,
      this.categoryId,
      this.categoryName,
      this.sellerId,
      this.commission,
      this.seller,
      this.primaryDamageId,
      this.primaryDamage,
      this.secondaryDamageId,
      this.secondaryDamage,
      this.bodyStyleId,
      this.bodyStyle,
      this.vehicleTypeId,
      this.vehicleType,
      this.engineTypeId,
      this.engineType,
      this.cylinderId,
      this.cylinder,
      this.transmissionId,
      this.transmission,
      this.driveTrainId,
      this.driveTrain,
      this.fuelTypeId,
      this.fuelType,
      this.rejectionNote,
      this.fileUrls,
      this.vehicleImages,
      this.counterOffers,
      this.sellerDetail,
      this.auctionId,
      this.createdAt,
      this.showHandedOverButton,
      this.paymentStatus,
      this.vccDocument,
      this.gatepassGeneratedDate,
      this.runs,
      this.auction});

  MyCarInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vin = json['vin'];
    lotNumber = json['lot_number'];
    thumbnailUrl = json['thumbnail_url'];
    year = json['year'];
    makeId = json['make_id'];
    make = json['make'];
    vehicleModelId = json['vehicle_model_id'];
    model = json['model'];
    colorId = json['color_id'];
    color = json['color'];
    status = json['status'];
    statusName = json['status_name'];
    note = json['note'];
    keys = json['keys'];
    keysName = json['keys_name'];
    retailValue = json['retail_value'];
    sellingPrice = json['selling_price'];
    reserveAmount = json['reserve_amount'];
    startBidAmount = json['start_bid_amount'];
    odometer = json['odometer'];
    saleType = json['sale_type'];
    saleTypeName = json['sale_type_name'];
    titleCodeId = json['title_code_id'];
    titleCode = json['title_code'];
    mileageTypeId = json['mileage_type_id'];
    mileageType = json['mileage_type'];
    highlightId = json['highlight_id'];
    highlight = json['highlight'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    salesExecutiveId = json['sales_executive_id'];
    sellerId = json['seller_id'];
    commission = json['commission'];
    seller = json['seller'];
    trim = json['trim'];
    primaryDamageId = json['primary_damage_id'];
    primaryDamage = json['primary_damage'];
    secondaryDamageId = json['secondary_damage_id'];
    secondaryDamage = json['secondary_damage'];
    bodyStyleId = json['body_style_id'];
    bodyStyle = json['body_style'];
    vehicleTypeId = json['vehicle_type_id'];
    vehicleType = json['vehicle_type'];
    engineTypeId = json['engine_type_id'];
    engineType = json['engine_type'];
    cylinderId = json['cylinder_id'];
    cylinder = json['cylinder'];
    transmissionId = json['transmission_id'];
    transmission = json['transmission'];
    driveTrainId = json['drive_train_id'];
    driveTrain = json['drive_train'];
    fuelTypeId = json['fuel_type_id'];
    fuelType = json['fuel_type'];
    rejectionNote = json['rejection_note'];
    fileUrls =
        json['file_urls'] != null ? FileUrls.fromJson(json['file_urls']) : null;
    if (json['vehicle_images'] != null) {
      vehicleImages = <VehicleImages>[];
      json['vehicle_images'].forEach((v) {
        vehicleImages!.add(VehicleImages.fromJson(v));
      });
    }
    if (json['counter_offers'] != null) {
      counterOffers = <CounterOffers>[];
      json['counter_offers'].forEach((v) {
        counterOffers!.add(CounterOffers.fromJson(v));
      });
    }
    sellerDetail = json['seller_detail'] != null
        ? SellerDetail.fromJson(json['seller_detail'])
        : null;
    auctionId = json['auction_id'];
    createdAt = json['created_at'];
    showHandedOverButton = json['show_handed_over_button'];
    paymentStatus = json['payment_status'];
    vccDocument = json['vcc_document'];
    gatepassGeneratedDate = json['gatepass_generated_date'];
    runs = json['runs'];
    auction =
        json['auction'] != null ? Auction.fromJson(json['auction']) : null;
  }
}

class CounterOffers {
  int? id;
  int? vehicleId;
  int? sellerId;
  int? adminId;
  int? counterAmount;
  String? note;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? adminName;
  String? sellerName;
  Admin? admin;
  dynamic seller;

  CounterOffers(
      {this.id,
      this.vehicleId,
      this.sellerId,
      this.adminId,
      this.counterAmount,
      this.note,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.adminName,
      this.sellerName,
      this.admin,
      this.seller});

  CounterOffers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleId = json['vehicle_id'];
    sellerId = json['seller_id'];
    adminId = json['admin_id'];
    counterAmount = json['counter_amount'];
    note = json['note'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    adminName = json['admin_name'];
    sellerName = json['seller_name'];
    admin = json['admin'] != null ? Admin.fromJson(json['admin']) : null;
    seller = json['seller'];
  }
}

class Admin {
  int? id;
  String? name;
  String? username;
  String? email;
  int? status;
  int? role;
  String? updatedAt;
  String? profilePhoto;
  Admin(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.status,
      this.role,
      this.updatedAt,
      this.profilePhoto,});

  Admin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    status = json['status'];
    role = json['role'];
    updatedAt = json['updated_at'];
    profilePhoto = json['profile_photo'];
  }
}

class SellerDetail {
  int? id;
  int? userId;
  String? firstName;
  String? lastName;
  String? fullName;
  String? username;
  String? email;
  dynamic companyName;
  int? type;
  String? primaryPhone;
  String? primaryPhoneCode;
  int? countryId;
  String? countryName;
  bool? status;
  String? statusName;
  dynamic socialMedia;

  SellerDetail(
      {this.id,
      this.userId,
      this.firstName,
      this.lastName,
      this.fullName,
      this.username,
      this.email,
      this.companyName,
      this.type,
      this.primaryPhone,
      this.primaryPhoneCode,
      this.countryId,
      this.countryName,
      this.status,
      this.statusName,
      this.socialMedia});

  SellerDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = json['full_name'];
    username = json['username'];
    email = json['email'];
    companyName = json['company_name'];
    type = json['type'];
    primaryPhone = json['primary_phone'];
    primaryPhoneCode = json['primary_phone_code'];
    countryId = json['country_id'];
    countryName = json['country_name'];
    status = json['status'];
    statusName = json['status_name'];
    socialMedia = json['social_media'];
  }
}

class Auction {
  int? id;
  int? totalVehicles;
  String? locationName;
  String? auctionYardName;
  String? auctionAt;
  int? status;
  String? statusName;
  int? auctionType;
  String? auctionTypeName;
  bool? showLiveStreamButton;

  Auction(
      {this.id,
      this.totalVehicles,
      this.locationName,
      this.auctionYardName,
      this.auctionAt,
      this.status,
      this.statusName,
      this.auctionType,
      this.auctionTypeName,
      this.showLiveStreamButton});

  Auction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalVehicles = json['total_vehicles'];
    locationName = json['location_name'];
    auctionYardName = json['auction_yard_name'];
    auctionAt = json['auction_at'];
    status = json['status'];
    statusName = json['status_name'];
    auctionType = json['auction_type'];
    auctionTypeName = json['auction_type_name'];
    showLiveStreamButton = json['show_live_stream_button'];
  }
}
