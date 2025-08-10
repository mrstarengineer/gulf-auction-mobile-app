import 'package:gulf_car_auction/models/meta/meta.dart';

class MyAllCarsInfo {
  List<MyAllCarsData>? data;
  Meta? meta;

  MyAllCarsInfo({this.data, this.meta});

  MyAllCarsInfo.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MyAllCarsData>[];
      json['data'].forEach((v) {
        data!.add(MyAllCarsData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

}

class MyAllCarsData {
  int? id;
  String? title;
  String? vin;
  String? thumbnailUrl;
  String? lotNumber;
  String? year;
  String? make;
  String? model;
  String? color;
  int? status;
  String? categoryName;
  String? statusName;
  String? keys;
  dynamic titleCode;
  int? odometer;
  dynamic mileageType;
  dynamic highlight;
  String? seller;
  String? soldDate;
  dynamic buyerName;
  dynamic primaryDamage;
  dynamic secondaryDamage;
  int? sellingPrice;
  int? startBidAmount;
  dynamic bodyStyle;
  dynamic counterAmount;
  dynamic lastBidAmount;
  dynamic reserveAmount;
  dynamic vehicleType;
  String? engineType;
  String? cylinder;
  String? transmission;
  String? drive;
  String? fuelType;
  bool? featured;
  dynamic note;
  int? auctionId;
  int? docApproved;
  int? docReceived;
  int? serial;
  String? auctionName;
  int? runs;

  MyAllCarsData(
      {this.id,
        this.title,
        this.vin,
        this.thumbnailUrl,
        this.lotNumber,
        this.year,
        this.make,
        this.model,
        this.color,
        this.status,
        this.serial,
        this.soldDate,
        this.categoryName,
        this.statusName,
        this.docReceived,
        this.keys,
        this.titleCode,
        this.docApproved,
        this.odometer,
        this.mileageType,
        this.highlight,
        this.seller,
        this.lastBidAmount,
        this.buyerName,
        this.primaryDamage,
        this.secondaryDamage,
        this.sellingPrice,
        this.reserveAmount,
        this.startBidAmount,
        this.bodyStyle,
        this.vehicleType,
        this.engineType,
        this.cylinder,
        this.transmission,
        this.drive,
        this.fuelType,
        this.featured,
        this.note,
        this.auctionId,
        this.auctionName,
        this.counterAmount,
        this.runs});

  MyAllCarsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    vin = json['vin'];
    thumbnailUrl = json['thumbnail_url'];
    lotNumber = json['lot_number'];
    year = json['year'];
    make = json['make'];
    model = json['model'];
    color = json['color'];
    status = json['status'];
    docApproved = json['doc_approved'];
    categoryName = json['category_name'];
    soldDate = json['sold_date'];
    statusName = json['status_name'];
    keys = json['keys'];
    titleCode = json['title_code'];
    reserveAmount = json['reserve_amount'];
    docReceived = json['doc_received'];
    odometer = json['odometer'];
    counterAmount = json['counter_amount'];
    mileageType = json['mileage_type'];
    highlight = json['highlight'];
    seller = json['seller'];
    buyerName = json['buyer_name'];
    primaryDamage = json['primary_damage'];
    secondaryDamage = json['secondary_damage'];
    sellingPrice = json['selling_price'];
    startBidAmount = json['start_bid_amount'];
    bodyStyle = json['body_style'];
    vehicleType = json['vehicle_type'];
    engineType = json['engine_type'];
    cylinder = json['cylinder'];
    transmission = json['transmission'];
    drive = json['drive'];
    serial = json['serial'];
    fuelType = json['fuel_type'];
    featured = json['featured'];
    lastBidAmount = json['last_bid_amount'];
    note = json['note'];
    auctionId = json['auction_id'];
    auctionName = json['auction_name'];
    runs = json['runs'];
  }

}
