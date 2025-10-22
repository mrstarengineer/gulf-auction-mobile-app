import '../vehicle/vehicle_images.dart';

class KAuctionView {
  int? totalParticipants;
  KAuctionDetail? auctionDetail;
  BidInfo? bidInfo;
  MBidDetail? bidDetail;
  KVehicleDetail? vehicleDetail;
  KUpcomingVehicles? upcomingVehicles;
  int? totalRemainingItems;

  KAuctionView(
      {this.totalParticipants,
      this.auctionDetail,
      this.bidInfo,
      this.bidDetail,
      this.vehicleDetail,
      this.upcomingVehicles,
      this.totalRemainingItems});

  KAuctionView.fromJson(Map<String, dynamic> json) {
    totalParticipants = json['total_participants'];
    auctionDetail = json['auction_detail'] != null
        ? KAuctionDetail.fromJson(json['auction_detail'])
        : null;
    bidInfo =
        json['bid_info'] != null ? BidInfo.fromJson(json['bid_info']) : null;
    bidDetail = json['bid_detail'] != null
        ? MBidDetail.fromJson(json['bid_detail'])
        : null;
    vehicleDetail = json['vehicle_detail'] != null
        ? KVehicleDetail.fromJson(json['vehicle_detail'])
        : null;
    upcomingVehicles = json['upcoming_vehicles'] != null &&
            json['upcoming_vehicles'].toString() != '[]'
        ? KUpcomingVehicles.fromJson(json['upcoming_vehicles'])
        : null;
  }
}

class KAuctionDetail {
  dynamic id;
  String? title;
  int? status;
  String? auctionAt;
  int? auctionAtInMilliseconds;
  int? timeLeftSec;

  KAuctionDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
    auctionAt = json['auction_at'];
    auctionAtInMilliseconds = json['auction_at_in_milliseconds'];
    timeLeftSec = json['time_left_sec'];
  }
}

class MBidDetail {
  int? userId;
  dynamic amount;
  String? username;
  String? bidType;

  MBidDetail.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    userId = json['user_id'] ?? 0;
    username = json['username'] ?? '';
    bidType = json['username'] ?? '';
  }
}

class KVehicleDetail {
  int? id;
  String? thumbnailUrl;
  List<VehicleImages>? vehicleImages;
  String? year;
  String? make;
  String? model;
  String? lotNumber;
  int? itemNumber;
  String? serial;
  String? itemNumberStr;
  String? location;
  String? vin;
  String? documentType;
  int? odometer;
  int? saleType;
  String? odometerType;
  int? reserveAmount;
  dynamic retailValue;
  String? color;
  String? primaryDamage;
  String? secondaryDamage;
  String? bodyStyle;
  String? engineType;
  String? remainingTime;
  String? cylinder;
  String? bidStatusName;
  String? drive;
  bool? eligibleForBidding;
  bool? watched;
  int? currentBidAmount;
  int? myMaxBid;
  int? isGolden;
  int? maxMinimumBid;
  int? startBidAmount;
  int? minimumBid;
  bool? isExpanded;

  KVehicleDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumbnailUrl = json['thumbnail_url'];
    if (json['vehicle_images'] != null) {
      vehicleImages = <VehicleImages>[];
      json['vehicle_images'].forEach((v) {
        vehicleImages!.add(VehicleImages.fromJson(v));
      });
    }
    year = json['year'];
    saleType = json['sale_type'];
    isGolden = json['is_golden'];
    make = json['make'];
    documentType = json['document_type'];
    model = json['model'];
    lotNumber = json['lot_number'];
    itemNumber = json['item_number'];
    serial = json['serial'];
    itemNumberStr = json['item_number_str'];
    location = json['location'];
    vin = json['vin'];
    odometer = json['odometer'];
    odometerType = json['odometer_type'];
    retailValue = json['retail_value'];
    reserveAmount = json['reserve_amount'];
    color = json['color'];
    primaryDamage = json['primary_damage'];
    secondaryDamage = json['secondary_damage'];
    bodyStyle = json['body_style'];
    engineType = json['engine_type'];
    cylinder = json['cylinder'];
    bidStatusName = json['bid_status_name'];
    drive = json['drive'];
    eligibleForBidding = json['eligible_for_bidding'];
    watched = json['watched'];
    myMaxBid = json['my_max_bid'];
    maxMinimumBid = json['max_minimum_bid'];
    minimumBid = json['minimum_bid'];
    startBidAmount = json['start_bid_amount'];
    currentBidAmount = json['current_bid_amount'];
    remainingTime = json['remaining_time'];
    isExpanded = false;
  }
}

class KUpcomingVehicles {
  Map<String, KVehicleDetail>? upcomingVehicleDetailList;

  KUpcomingVehicles.fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      upcomingVehicleDetailList = <String, KVehicleDetail>{};
      json.forEach((key, value) {
        upcomingVehicleDetailList![key] = KVehicleDetail.fromJson(value);
      });
    }
  }
}

class KPusherEventData {
  bool? auctionFinished;
  String? currentItem;
  int? winnerUserId;
  int? totalRemainingItems;
  String? nextItem;
  String? event;
  String? type;
  int? isGolden;
  int? reserveAmount;
  String? breakEndTime;
  String? breakTitle;
  String? msg;
  int? interval;
  String? totalParticipants;
  BidInfo? bidInfo;
  BidDetail? bidDetail;

  KPusherEventData(
      {this.auctionFinished,
      this.winnerUserId,
      this.currentItem,
      this.totalRemainingItems,
      this.nextItem,
      this.event,
      this.isGolden,
      this.reserveAmount,
      this.type,
      this.breakEndTime,
      this.breakTitle,
      this.msg,
      this.interval,
      this.totalParticipants});

  KPusherEventData.fromJson(
      Map<String, dynamic> json, KPusherEventData containerData) {
    auctionFinished = json['auction_finished'];
    winnerUserId = json['winner_user_id'];
    currentItem = json['current_item'];
    totalRemainingItems = json['total_remaining_items'];
    nextItem = json['next_item'];
    event = json['event'];
    isGolden = json['is_golden'];
    reserveAmount = json['reserve_amount'];
    type = json['type'];
    breakEndTime = json['break_ended_at'];
    breakTitle = json['break_title'];
    msg = json['msg'];
    interval = json['interval'];
    totalParticipants = json['total_participants'];

    if (event == 'BONUS_TIME') {
      bidInfo = containerData.bidInfo;
    } else {
      bidInfo =
          json['bid_info'] != null ? BidInfo.fromJson(json['bid_info']) : null;
    }

    bidDetail = json['bid_detail'] != null
        ? BidDetail.fromJson(json['bid_detail'])
        : null;
  }
}

class BidInfo {
  String? currentItem;
  int? itemNumber;
  int? bidIncrement;
  int? minimumBidAmount;
  int? nextBidAmount;

  BidInfo.fromJson(Map<String, dynamic> json) {
    currentItem = json['current_item'];
    itemNumber = json['item_number'];
    bidIncrement = json['bid_increment'];
    minimumBidAmount = json['minimum_bid_amount'];
    nextBidAmount = json['next_bid_amount'];
  }
}

class BidDetail {
  String? country;
  String? flag;
  String? bidType;
  dynamic amount;
  int? userId;
  List<PreviousBids>? previousBids;

  BidDetail.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    flag = json['flag'];
    bidType = json['bid_type'];
    amount = json['amount'];
    userId = json['user_id'];
    if (json['previous_bids'] != null) {
      previousBids = <PreviousBids>[];
      json['previous_bids'].forEach((v) {
        previousBids!.add(PreviousBids.fromJson(v));
      });
    }
  }
}

class PreviousBids {
  String? country;
  String? flag;
  dynamic amount;

  PreviousBids.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    flag = json['flag'];
    amount = json['amount'];
  }
}
