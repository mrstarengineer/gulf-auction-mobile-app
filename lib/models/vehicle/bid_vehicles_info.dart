import 'package:gulf_car_auction/models/meta/meta.dart';

class BidVehiclesInfo {
  List<BidVehicleData>? data;
  Meta? meta;

  BidVehiclesInfo({data, meta});

  BidVehiclesInfo.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BidVehicleData>[];
      json['data'].forEach((v) {
        data!.add(BidVehicleData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}

class BidVehicleData {
  int? id;
  String? thumbnailUrl;
  String? vin;
  int? vehicleId;
  String? auctionAt;
  String? title;
  int? currentBidAmount;
  String? note;
  String? saleDate;
  String? bidStatusName;
  dynamic sellingPrice;
  dynamic myMaxBid;

  BidVehicleData({
    this.id,
    this.thumbnailUrl,
    this.vin,
    this.vehicleId,
    this.auctionAt,
    this.title,
    this.currentBidAmount,
    this.note,
    this.saleDate,
    this.sellingPrice,
    this.myMaxBid,
  });

  BidVehicleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumbnailUrl = json['thumbnail_url'];
    vin = json['vin'];
    bidStatusName = json['bid_status_name'];
    vehicleId = json['vehicle_id'];
    sellingPrice = json['selling_price'];
    auctionAt = json['auction_at'];
    title = json['title'];
    currentBidAmount = json['current_bid_amount'];
    myMaxBid = json['my_max_bid'];
    note = json['note'];
    saleDate = json['sale_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['thumbnail_url'] = thumbnailUrl;
    data['vin'] = vin;
    data['vehicle_id'] = vehicleId;
    data['auction_at'] = auctionAt;
    data['title'] = title;
    data['current_bid_amount'] = currentBidAmount;
    data['note'] = note;
    return data;
  }
}
