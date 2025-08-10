import 'package:gulf_car_auction/models/models.dart';

class AuctionView {
  int? _totalParticipants;
  AuctionDetail? _auctionDetail;
  BidInfo? _bidInfo;
  VehicleDetail? _vehicleDetail;
  MBidDetail? _bidDetail;
  UpcomingVehicles? _upcomingVehicles;
  int? _totalRemainingItems;

  AuctionView(
      {int? totalParticipants,
      AuctionDetail? auctionDetail,
      BidInfo? bidInfo,
      MBidDetail? bidDetail,
      VehicleDetail? vehicleDetail,
      UpcomingVehicles? upcomingVehicles,
      int? totalRemainingItems}) {
    if (totalParticipants != null) {
      _totalParticipants = totalParticipants;
    }
    if (bidDetail != null) {
      _bidDetail = bidDetail;
    }
    if (auctionDetail != null) {
      _auctionDetail = auctionDetail;
    }
    if (bidInfo != null) {
      _bidInfo = bidInfo;
    }
    if (vehicleDetail != null) {
      _vehicleDetail = vehicleDetail;
    }
    if (upcomingVehicles != null) {
      _upcomingVehicles = upcomingVehicles;
    }
    if (totalRemainingItems != null) {
      _totalRemainingItems = totalRemainingItems;
    }
  }

  int? get totalParticipants => _totalParticipants;

  set totalParticipants(int? totalParticipants) =>
      _totalParticipants = totalParticipants;

  AuctionDetail? get auctionDetail => _auctionDetail;

  MBidDetail? get bidDetail => _bidDetail;

  set auctionDetail(AuctionDetail? auctionDetail) =>
      _auctionDetail = auctionDetail;

  set bidDetail(MBidDetail? bidDetail) => _bidDetail = bidDetail;

  BidInfo? get bidInfo => _bidInfo;

  set bidInfo(BidInfo? bidInfo) => _bidInfo = bidInfo;

  VehicleDetail? get vehicleDetail => _vehicleDetail;

  set vehicleDetail(VehicleDetail? vehicleDetail) =>
      _vehicleDetail = vehicleDetail;

  UpcomingVehicles? get upcomingVehicles => _upcomingVehicles;

  set upcomingVehicles(UpcomingVehicles? upcomingVehicles) =>
      _upcomingVehicles = upcomingVehicles;

  int? get totalRemainingItems => _totalRemainingItems;

  set totalRemainingItems(int? totalRemainingItems) =>
      _totalRemainingItems = totalRemainingItems;

  AuctionView.fromJson(Map<String, dynamic> json) {
    _totalParticipants = json['total_participants'];
    _auctionDetail = json['auction_detail'] != null
        ? AuctionDetail.fromJson(json['auction_detail'])
        : null;
    _bidInfo =
        json['bid_info'] != null ? BidInfo.fromJson(json['bid_info']) : null;
    _bidDetail = json['bid_detail'] != null
        ? MBidDetail.fromJson(json['bid_detail'])
        : null;
    _vehicleDetail = json['vehicle_detail'] != null
        ? VehicleDetail.fromJson(json['vehicle_detail'])
        : null;
    _upcomingVehicles = json['upcoming_vehicles'] != null &&
            json['upcoming_vehicles'].toString() != '[]'
        ? UpcomingVehicles.fromJson(json['upcoming_vehicles'])
        : null;
    // _totalRemainingItems = json['total_remaining_items'];
  }
}

class AuctionDetail {
  dynamic _id;
  String? _title;
  int? _status;
  String? _auctionAt;
  int? _auctionAtInMilliseconds;
  int? _timeLeftSec;
  String? _auctionType;

  AuctionDetail({
    dynamic id,
    String? title,
    int? status,
    String? auctionType,
    String? auctionAt,
    int? auctionAtInMilliseconds,
    int? timeLeftSec,
  }) {
    if (title != null) {
      _title = title;
    }
    if (auctionType != null) {
      _auctionType = auctionType;
    }
    if (id != null) {
      _id = id;
    }
    if (status != null) {
      _status = status;
    }
    if (auctionAt != null) {
      _auctionAt = auctionAt;
    }
    if (auctionAtInMilliseconds != null) {
      _auctionAtInMilliseconds = auctionAtInMilliseconds;
    }
    if (timeLeftSec != null) {
      _timeLeftSec = timeLeftSec;
    }
  }

  String? get title => _title;

  set title(String? title) => _title = title;

  dynamic get id => _id;

  set id(dynamic id) => _id = id;

  String? get auctionType => _auctionType;

  set auctionType(String? auctionType) => _auctionType = auctionType;

  int? get status => _status;

  set status(int? status) => _status = status;

  String? get auctionAt => _auctionAt;

  set auctionAt(String? auctionAt) => _auctionAt = auctionAt;

  int? get auctionAtInMilliseconds => _auctionAtInMilliseconds;

  set auctionAtInMilliseconds(int? auctionAtInMilliseconds) =>
      _auctionAtInMilliseconds = auctionAtInMilliseconds;

  int? get timeLeftSec => _timeLeftSec;

  set timeLeftSec(int? timeLeftSec) => _timeLeftSec = timeLeftSec;

  AuctionDetail.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _status = json['status'];
    _auctionAt = json['auction_at'];
    _auctionAtInMilliseconds = json['auction_at_in_milliseconds'];
    _timeLeftSec = json['time_left_sec'];
    _auctionType = json['auction_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['title'] = _title;
    data['status'] = _status;
    data['auction_at'] = _auctionAt;
    data['auction_at_in_milliseconds'] = _auctionAtInMilliseconds;
    data['time_left_sec'] = _timeLeftSec;
    return data;
  }
}

class MBidDetail {
  int? userId;
  int? amount;

  MBidDetail({
    int? mUserId,
    int? mAmount,
  }) {
    if (mUserId != null) {
      amount = mUserId;
    }
    if (mAmount != null) {
      amount = mAmount;
    }
  }

  MBidDetail.fromJson(Map<String, dynamic> json) {
    amount = json['amount'] ?? 0;
    userId = json['user_id'] ?? 0;
  }
}

class VehicleDetail {
  int? _id;
  String? _thumbnailUrl;
  List<VehicleImages>? _vehicleImages;
  String? _year;
  String? _make;
  String? _model;
  String? _lotNumber;
  int? _itemNumber;
  String? _serial;
  String? _itemNumberStr;
  String? _location;
  String? _vin;
  String? _documentType;
  int? _odometer;
  String? _odometerType;
  int? _reserveAmount;
  dynamic _retailValue;
  String? _color;
  String? _primaryDamage;
  String? _secondaryDamage;
  String? _bodyStyle;
  String? _engineType;
  String? _remainingTime;
  String? _cylinder;
  String? _bidStatusName;
  String? _drive;
  bool? _eligibleForBidding;
  bool? _watched;
  int? _currentBidAmount;
  int? _myMaxBid;
  int? isGolden;
  int? _maxMinimumBid;
  int? _startBidAmount;
  int? _minimumBid;
  bool? _isExpanded;

  VehicleDetail({
    int? id,
    int? mIsGolden,
    String? thumbnailUrl,
    List<VehicleImages>? vehicleImages,
    String? year,
    String? make,
    String? model,
    String? lotNumber,
    String? documentType,
    int? itemNumber,
    String? serial,
    String? itemNumberStr,
    String? location,
    String? vin,
    String? odometerType,
    int? odometer,
    int? reserveAmount,
    dynamic retailValue,
    String? color,
    String? primaryDamage,
    String? engineType,
    String? cylinder,
    String? bidStatusName,
    String? remainingTime,
    String? secondaryDamage,
    String? bodyStyle,
    String? drive,
    bool? eligibleForBidding,
    bool? watched,
    int? currentBidAmount,
    int? myMaxBid,
    int? maxMinimumBid,
    int? startBidAmount,
    int? minimumBid,
    bool? isExpanded,
  }) {
    if (id != null) {
      _id = id;
    }
    if (mIsGolden != null) {
      isGolden = mIsGolden;
    }
    if (odometerType != null) {
      _odometerType = odometerType;
    }
    if (reserveAmount != null) {
      _reserveAmount = reserveAmount;
    }
    if (documentType != null) {
      _documentType = documentType;
    }
    if (thumbnailUrl != null) {
      _thumbnailUrl = thumbnailUrl;
    }
    if (vehicleImages != null) {
      _vehicleImages = vehicleImages;
    }
    if (year != null) {
      _year = year;
    }
    if (remainingTime != null) {
      _remainingTime = remainingTime;
    }
    if (make != null) {
      _make = make;
    }
    if (model != null) {
      _model = model;
    }
    if (lotNumber != null) {
      _lotNumber = lotNumber;
    }
    if (itemNumber != null) {
      _itemNumber = itemNumber;
    }
    if (serial != null) {
      _serial = serial;
    }
    if (location != null) {
      _location = location;
    }
    if (itemNumberStr != null) {
      _itemNumberStr = itemNumberStr;
    }
    if (vin != null) {
      _vin = vin;
    }
    if (odometer != null) {
      _odometer = odometer;
    }
    if (retailValue != null) {
      _retailValue = retailValue;
    }
    if (color != null) {
      _color = color;
    }
    if (primaryDamage != null) {
      _primaryDamage = primaryDamage;
    }
    if (engineType != null) {
      _engineType = engineType;
    }
    if (cylinder != null) {
      _cylinder = cylinder;
    }
    if (bidStatusName != null) {
      _bidStatusName = bidStatusName;
    }
    if (drive != null) {
      _drive = drive;
    }
    if (secondaryDamage != null) {
      _secondaryDamage = secondaryDamage;
    }
    if (bodyStyle != null) {
      _bodyStyle = bodyStyle;
    }
    if (eligibleForBidding != null) {
      _eligibleForBidding = eligibleForBidding;
    }
    if (watched != null) {
      _watched = watched;
    }
    if (myMaxBid != null) {
      _myMaxBid = myMaxBid;
    }
    if (maxMinimumBid != null) {
      _maxMinimumBid = maxMinimumBid;
    }
    if (minimumBid != null) {
      _minimumBid = minimumBid;
    }
    if (startBidAmount != null) {
      _startBidAmount = startBidAmount;
    }

    if (currentBidAmount != null) {
      _currentBidAmount = currentBidAmount;
    }
    if (isExpanded != null) {
      _isExpanded = isExpanded;
    }
  }

  int? get id => _id;

  set id(int? id) => _id = id;

  String? get thumbnailUrl => _thumbnailUrl;

  set thumbnailUrl(String? thumbnailUrl) => _thumbnailUrl = thumbnailUrl;

  String? get remainingTime => _remainingTime;

  set remainingTime(String? remainingTime) => _remainingTime = remainingTime;

  List<VehicleImages>? get vehicleImages => _vehicleImages;

  set vehicleImages(List<VehicleImages>? vehicleImages) =>
      _vehicleImages = vehicleImages;

  String? get year => _year;

  set year(String? year) => _year = year;

  String? get make => _make;

  set make(String? make) => _make = make;

  String? get model => _model;

  set model(String? model) => _model = model;

  String? get documentType => _documentType;

  set documentType(String? documentType) => _documentType = documentType;

  String? get lotNumber => _lotNumber;

  set lotNumber(String? lotNumber) => _lotNumber = lotNumber;

  int? get itemNumber => _itemNumber;

  set itemNumber(int? itemNumber) => _itemNumber = itemNumber;

  int? get reserveAmount => _reserveAmount;

  set reserveAmount(int? reserveAmount) => _reserveAmount = reserveAmount;

  String? get serial => _serial;

  set serial(String? serial) => _serial = serial;

  String? get location => _location;

  set location(String? location) => _location = location;

  String? get itemNumberStr => _itemNumberStr;

  set itemNumberStr(String? itemNumberStr) => _itemNumberStr = location;

  String? get vin => _vin;

  set vin(String? vin) => _vin = vin;

  int? get odometer => _odometer;

  String? get odometerType => _odometerType;

  set odometer(int? odometer) => _odometer = odometer;

  set odometerType(String? odometerType) => _odometerType = odometerType;

  dynamic get retailValue => _retailValue;

  set retailValue(dynamic retailValue) => _retailValue = retailValue;

  String? get color => _color;

  set color(String? color) => _color = color;

  String? get primaryDamage => _primaryDamage;

  set primaryDamage(String? primaryDamage) => _primaryDamage = primaryDamage;

  String? get engineType => _engineType;

  set engineType(String? engineType) => _engineType = engineType;

  String? get cylinder => _cylinder;

  set cylinder(String? cylinder) => _cylinder = cylinder;

  String? get bidStatusName => _bidStatusName;

  set bidStatusName(String? bidStatusName) => _bidStatusName = bidStatusName;

  String? get drive => _drive;

  set drive(String? drive) => _drive = drive;

  String? get secondaryDamage => _secondaryDamage;

  set secondaryDamage(String? value) {
    _secondaryDamage = value;
  }

  String? get bodyStyle => _bodyStyle;

  set bodyStyle(String? value) {
    _bodyStyle = value;
  }

  bool? get eligibleForBidding => _eligibleForBidding;

  set eligibleForBidding(bool? value) {
    _eligibleForBidding = value;
  }

  bool? get watched => _watched;

  set watched(bool? value) {
    _watched = value;
  }

  int? get myMaxBid => _myMaxBid;

  set myMaxBid(int? myMaxBid) => _myMaxBid = myMaxBid;

  int? get maxMinimumBid => _maxMinimumBid;

  set maxMinimumBid(int? maxMinimumBid) => _maxMinimumBid = maxMinimumBid;

  int? get minimumBid => _minimumBid;

  set minimumBid(int? minimumBid) => _minimumBid = minimumBid;

  int? get currentBidAmount => _currentBidAmount;

  set currentBidAmount(int? currentBidAmount) =>
      _currentBidAmount = currentBidAmount;

  int? get startBidAmount => _startBidAmount;

  set startBidAmount(int? startBidAmount) => _startBidAmount = startBidAmount;

  bool? get isExpanded => _isExpanded;

  set isExpanded(bool? value) {
    _isExpanded = value;
  }

  VehicleDetail.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _thumbnailUrl = json['thumbnail_url'];
    if (json['vehicle_images'] != null) {
      _vehicleImages = <VehicleImages>[];
      json['vehicle_images'].forEach((v) {
        _vehicleImages!.add(VehicleImages.fromJson(v));
      });
    }
    _year = json['year'];
    isGolden = json['is_golden'];
    _make = json['make'];
    _documentType = json['document_type'];
    _model = json['model'];
    _lotNumber = json['lot_number'];
    _itemNumber = json['item_number'];
    _serial = json['serial'];
    _itemNumberStr = json['item_number_str'];
    _location = json['location'];
    _vin = json['vin'];
    _odometer = json['odometer'];
    odometerType = json['odometer_type'];
    _retailValue = json['retail_value'];
    _reserveAmount = json['reserve_amount'];
    _color = json['color'];
    _primaryDamage = json['primary_damage'];
    _secondaryDamage = json['secondary_damage'];
    _bodyStyle = json['body_style'];
    _engineType = json['engine_type'];
    _cylinder = json['cylinder'];
    _bidStatusName = json['bid_status_name'];
    _drive = json['drive'];
    _eligibleForBidding = json['eligible_for_bidding'];
    _watched = json['watched'];
    _myMaxBid = json['my_max_bid'];
    _maxMinimumBid = json['max_minimum_bid'];
    _minimumBid = json['minimum_bid'];
    _startBidAmount = json['start_bid_amount'];
    _currentBidAmount = json['current_bid_amount'];
    _remainingTime = json['remaining_time'];
    _isExpanded = false;
  }
}

class UpcomingVehicles {
  Map<String, VehicleDetail>? _upcomingVehicleDetailList;

  UpcomingVehicles(Map<String, VehicleDetail>? upcomingVehicleDetailList) {
    if (upcomingVehicleDetailList != null) {
      _upcomingVehicleDetailList = upcomingVehicleDetailList;
    }
  }

  Map<String, VehicleDetail>? get upcomingVehicleDetailList =>
      _upcomingVehicleDetailList;

  set upcomingVehicleDetailList(Map<String, VehicleDetail>? vehicleDetail) =>
      _upcomingVehicleDetailList = vehicleDetail;

  UpcomingVehicles.fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      _upcomingVehicleDetailList = <String, VehicleDetail>{};
      json.forEach((key, value) {
        Map<String, VehicleDetail> map = {
          key: VehicleDetail.fromJson(value),
        };
        _upcomingVehicleDetailList!.addAll(map);
      });
    }
  }
}
