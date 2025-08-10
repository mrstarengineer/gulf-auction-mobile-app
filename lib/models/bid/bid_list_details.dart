import '../models.dart';

class BidListDetailsData {
  int? id;
  String? vin;
  String? lotNumber;
  String? thumbnailUrl;
  String? year;
  String? plan;
  int? makeId;
  String? make;
  int? vehicleModelId;
  String? model;
  int? colorId;
  String? color;
  int? status;
  String? statusName;
  int? keys;
  String? keysName;
  int? retailValue;
  int? sellingPrice;
  int? startBidAmount;
  int? odometer;
  int? saleType;
  String? saleTypeName;
  int? mileageTypeId;
  String? mileageType;
  int? highlightId;
  String? highlight;
  int? categoryId;
  String? categoryName;
  int? sellerId;
  int? commission;
  String? seller;
  int? primaryDamageId;
  String? primaryDamage;
  int? secondaryDamageId;
  String? secondaryDamage;
  String? isActiveName;
  int? bodyStyleId;
  String? bodyStyle;
  int? engineTypeId;
  String? engineType;
  int? cylinderId;
  String? cylinder;
  int? transmissionId;
  String? transmission;
  int? driveTrainId;
  String? driveTrain;
  int? fuelTypeId;
  String? fuelType;
  String? rejectionNote;
  FileUrls? fileUrls;
  List<VehicleImages>? vehicleImages;
  SellerDetail? sellerDetail;
  int? auctionId;
  String? createdAt;
  bool? showHandedOverButton;
  String? paymentStatus;
  String? documentType;
  int? runs;
  int? docApproved;
  int? docReceived;
  bool? docApproveBtnShow;
  bool? docReceivedBtnShow;
  bool? inspectionPermission;
  bool? gatePassPermissions;
  List<History>? history;

  BidListDetailsData(
      {this.id,
        this.vin,
        this.lotNumber,
        this.thumbnailUrl,
        this.year,
        this.plan,
        this.makeId,
        this.make,
        this.vehicleModelId,
        this.model,
        this.colorId,
        this.color,
        this.status,
        this.statusName,
        this.keys,
        this.keysName,
        this.retailValue,
        this.sellingPrice,
        this.startBidAmount,
        this.odometer,
        this.saleType,
        this.saleTypeName,
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
        this.isActiveName,
        this.bodyStyleId,
        this.bodyStyle,
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
        this.sellerDetail,
        this.auctionId,
        this.createdAt,
        this.showHandedOverButton,
        this.paymentStatus,
        this.documentType,
        this.runs,
        this.docApproved,
        this.docReceived,
        this.docApproveBtnShow,
        this.docReceivedBtnShow,
        this.inspectionPermission,
        this.gatePassPermissions,
        this.history});

  BidListDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vin = json['vin'];
    lotNumber = json['lot_number'];
    thumbnailUrl = json['thumbnail_url'];
    year = json['year'];
    plan = json['plan'];
    makeId = json['make_id'];
    make = json['make'];
    vehicleModelId = json['vehicle_model_id'];
    model = json['model'];
    colorId = json['color_id'];
    color = json['color'];
    status = json['status'];
    statusName = json['status_name'];
    keys = json['keys'];
    keysName = json['keys_name'];
    retailValue = json['retail_value'];
    sellingPrice = json['selling_price'];
    startBidAmount = json['start_bid_amount'];
    odometer = json['odometer'];
    saleType = json['sale_type'];
    saleTypeName = json['sale_type_name'];
    mileageTypeId = json['mileage_type_id'];
    mileageType = json['mileage_type'];
    highlightId = json['highlight_id'];
    highlight = json['highlight'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    sellerId = json['seller_id'];
    commission = json['commission'];
    seller = json['seller'];
    primaryDamageId = json['primary_damage_id'];
    primaryDamage = json['primary_damage'];
    secondaryDamageId = json['secondary_damage_id'];
    secondaryDamage = json['secondary_damage'];
    isActiveName = json['is_active_name'];
    bodyStyleId = json['body_style_id'];
    bodyStyle = json['body_style'];
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
    fileUrls = json['file_urls'] != null
        ? FileUrls.fromJson(json['file_urls'])
        : null;
    if (json['vehicle_images'] != null) {
      vehicleImages = <VehicleImages>[];
      json['vehicle_images'].forEach((v) {
        vehicleImages!.add(VehicleImages.fromJson(v));
      });
    }
    sellerDetail = json['seller_detail'] != null
        ? SellerDetail.fromJson(json['seller_detail'])
        : null;
    auctionId = json['auction_id'];
    createdAt = json['created_at'];
    showHandedOverButton = json['show_handed_over_button'];
    paymentStatus = json['payment_status'];
    documentType = json['document_type'];
    runs = json['runs'];
    docApproved = json['doc_approved'];
    docReceived = json['doc_received'];
    docApproveBtnShow = json['doc_approve_btn_show'];
    docReceivedBtnShow = json['doc_received_btn_show'];
    inspectionPermission = json['inspection_permission'];
    gatePassPermissions = json['gate_pass_permissions'];
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(History.fromJson(v));
      });
    }
  }
}






class History {
  int? serialNo;
  String? auctionDate;
  int? auctionNumber;
  String? saleType;
  String? saleTypeName;
  String? startBidAmount;
  String? reserveAmount;
  String? currentBidAmount;
  int? status;
  String? statusName;

  History(
      {this.serialNo,
        this.auctionDate,
        this.auctionNumber,
        this.saleType,
        this.saleTypeName,
        this.startBidAmount,
        this.reserveAmount,
        this.currentBidAmount,
        this.status,
        this.statusName});

  History.fromJson(Map<String, dynamic> json) {
    serialNo = json['serial_no'];
    auctionDate = json['auction_date'];
    auctionNumber = json['auction_number'];
    saleType = json['sale_type'];
    saleTypeName = json['sale_type_name'];
    startBidAmount = json['start_bid_amount'];
    reserveAmount = json['reserve_amount'];
    currentBidAmount = json['current_bid_amount'];
    status = json['status'];
    statusName = json['status_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serial_no'] = serialNo;
    data['auction_date'] = auctionDate;
    data['auction_number'] = auctionNumber;
    data['sale_type'] = saleType;
    data['sale_type_name'] = saleTypeName;
    data['start_bid_amount'] = startBidAmount;
    data['reserve_amount'] = reserveAmount;
    data['current_bid_amount'] = currentBidAmount;
    data['status'] = status;
    data['status_name'] = statusName;
    return data;
  }
}
