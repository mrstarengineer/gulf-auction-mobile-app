class PusherEventData {
  bool? _auctionFinished;
  String? _currentItem;
  int? _winnerUserId;
  int? _totalRemainingItems;
  String? _nextItem;
  String? _event;
  String? _type;
  int? _isGolden;
  int? _reserveAmount;
  String? _breakEndTime;
  String? _breakTitle;
  String? _msg;
  int? _interval;
  String? _totalParticipants;
  BidInfo? _bidInfo;
  BidDetail? _bidDetail;

  PusherEventData(
      {bool? auctionFinished,
      String? currentItem,
      int? totalRemainingItems,
      String? nextItem,
      String? itemNumber,
      int? reserveAmount,
      String? event,
      String? msg,
      int? interval,
      int? isGolden,
      int? winnerUserId,
      String? totalParticipants,
      String? type,
      String? breakEndTime,
      String? breakTitle,
      BidInfo? bidInfo,
      BidDetail? bidDetail}) {
    if (type != null) {
      _type = type;
    }
    if (reserveAmount != null) {
      _reserveAmount = reserveAmount;
    }
    if (breakEndTime != null) {
      _breakEndTime = breakEndTime;
    }
    if (breakTitle != null) {
      _breakTitle = breakTitle;
    }
    if (isGolden != null) {
      _isGolden = isGolden;
    }
    if (auctionFinished != null) {
      _auctionFinished = auctionFinished;
    }
    if (currentItem != null) {
      _currentItem = currentItem;
    }
    if (totalRemainingItems != null) {
      _totalRemainingItems = totalRemainingItems;
    }
    if (nextItem != null) {
      _nextItem = nextItem;
    }
    if (event != null) {
      _event = event;
    }
    if (msg != null) {
      _msg = msg;
    }
    if (interval != null) {
      _interval = interval;
    }
    if (totalParticipants != null) {
      _totalParticipants = totalParticipants;
    }
    if (bidInfo != null) {
      _bidInfo = bidInfo;
    }
    if (bidDetail != null) {
      _bidDetail = bidDetail;
    }
    if (winnerUserId != null) {
      _winnerUserId = winnerUserId;
    }
  }

  bool? get auctionFinished => _auctionFinished;

  set auctionFinished(bool? auctionFinished) =>
      _auctionFinished = auctionFinished;

  String? get currentItem => _currentItem;

  set currentItem(String? currentItem) => _currentItem = currentItem;

  String? get breakTitle => _breakTitle;

  set breakTitle(String? breakTitle) => _breakTitle = breakTitle;

  String? get type => _type;

  set type(String? type) => _type = type;

  String? get breakEndTime => _breakEndTime;

  set breakEndTime(String? breakEndTime) => _breakEndTime = breakEndTime;

  int? get totalRemainingItems => _totalRemainingItems;

  set totalRemainingItems(int? totalRemainingItems) =>
      _totalRemainingItems = totalRemainingItems;

  String? get nextItem => _nextItem;

  set nextItem(String? nextItem) => _nextItem = nextItem;

  String? get event => _event;

  set event(String? event) => _event = event;

  String? get msg => _msg;

  set msg(String? msg) => _msg = msg;

  int? get interval => _interval;

  set interval(int? interval) => _interval = interval;

  int? get winnerUserId => _winnerUserId;

  set winnerUserId(int? winnerUserId) => _winnerUserId = winnerUserId;

  int? get reserveAmount => _reserveAmount;

  set reserveAmount(int? reserveAmount) => _reserveAmount = reserveAmount;

  int? get isGolden => _isGolden;

  set isGolden(int? isGolden) => _isGolden = isGolden;

  String? get totalParticipants => _totalParticipants;

  set totalParticipants(String? totalParticipants) =>
      _totalParticipants = totalParticipants;

  BidInfo? get bidInfo => _bidInfo;

  set bidInfo(BidInfo? bidInfo) => _bidInfo = bidInfo;

  BidDetail? get bidDetail => _bidDetail;

  set bidDetail(BidDetail? bidDetail) => _bidDetail = bidDetail;

  PusherEventData.fromJson(
      Map<String, dynamic> json, PusherEventData containerData) {
    _auctionFinished = json['auction_finished'];
    _winnerUserId = json['winner_user_id'];
    _currentItem = json['current_item'];
    _totalRemainingItems = json['total_remaining_items'];
    _nextItem = json['next_item'];
    _event = json['event'];
    _isGolden = json['is_golden'];
    _reserveAmount = json['reserve_amount'];
    type = json['type'];
    breakEndTime = json['break_ended_at'];
    breakTitle = json['break_title'];
    _msg = json['msg'];
    _interval = json['interval'];
    _totalParticipants = json['total_participants'];
    if (_event != null && _event == 'BONUS_TIME') {
      _bidInfo = containerData.bidInfo;
    } else {
      _bidInfo =
          json['bid_info'] != null ? BidInfo.fromJson(json['bid_info']) : null;
    }

    _bidDetail = json['bid_detail'] != null
        ? BidDetail.fromJson(json['bid_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['auction_finished'] = _auctionFinished;
    data['current_item'] = _currentItem;
    data['total_remaining_items'] = _totalRemainingItems;
    data['next_item'] = _nextItem;
    data['event'] = _event;
    data['msg'] = _msg;
    data['interval'] = _interval;
    data['total_participants'] = _totalParticipants;
    if (_bidInfo != null) {
      data['bid_info'] = _bidInfo!.toJson();
    }
    if (_bidDetail != null) {
      data['bid_detail'] = _bidDetail!.toJson();
    }
    return data;
  }
}

class BidInfo {
  String? _currentItem;
  int? _itemNumber;
  int? _bidIncrement;
  int? _minimumBidAmount;
  int? _nextBidAmount;

  BidInfo(
      {String? currentItem,
      int? itemNumber,
      int? bidIncrement,
      int? minimumBidAmount,
      int? nextBidAmount}) {
    if (currentItem != null) {
      _currentItem = currentItem;
    }
    if (itemNumber != null) {
      _itemNumber = itemNumber;
    }
    if (bidIncrement != null) {
      _bidIncrement = bidIncrement;
    }
    if (minimumBidAmount != null) {
      _minimumBidAmount = minimumBidAmount;
    }
    if (nextBidAmount != null) {
      _nextBidAmount = nextBidAmount;
    }
  }

  String? get currentItem => _currentItem;

  set currentItem(String? currentItem) => _currentItem = currentItem;

  int? get itemNumber => _itemNumber;

  set itemNumber(int? itemNumber) => _itemNumber = itemNumber;

  int? get bidIncrement => _bidIncrement;

  set bidIncrement(int? bidIncrement) => _bidIncrement = bidIncrement;

  int? get minimumBidAmount => _minimumBidAmount;

  set minimumBidAmount(int? minimumBidAmount) =>
      _minimumBidAmount = minimumBidAmount;

  int? get nextBidAmount => _nextBidAmount;

  set nextBidAmount(int? nextBidAmount) => _nextBidAmount = nextBidAmount;

  BidInfo.fromJson(Map<String, dynamic> json) {
    _currentItem = json['current_item'];
    _itemNumber = json['item_number'];
    _bidIncrement = json['bid_increment'];
    _minimumBidAmount = json['minimum_bid_amount'];
    _nextBidAmount = json['next_bid_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_item'] = _currentItem;
    data['item_number'] = _itemNumber;
    data['bid_increment'] = _bidIncrement;
    data['minimum_bid_amount'] = _minimumBidAmount;
    data['next_bid_amount'] = _nextBidAmount;
    return data;
  }
}

class BidDetail {
  String? _country;
  String? _flag;
  dynamic _amount;
  int? _userId;
  List<PreviousBids>? _previousBids;

  BidDetail(
      {String? country,
        String? flag,
        dynamic amount,
        int? userId,
        List<PreviousBids>? previousBids}) {
    if (country != null) {
      _country = country;
    }
    if (flag != null) {
      _flag = flag;
    }
    if (amount != null) {
      _amount = amount;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (previousBids != null) {
      _previousBids = previousBids;
    }
  }

  String? get country => _country;

  set country(String? country) => _country = country;

  String? get flag => _flag;

  set flag(String? flag) => _flag = flag;

  dynamic get amount => _amount;

  set amount(dynamic amount) => _amount = amount;

  int? get userId => _userId;

  set userId(int? userId) => _userId = userId;

  List<PreviousBids>? get previousBids => _previousBids;

  set previousBids(List<PreviousBids>? previousBids) =>
      _previousBids = previousBids;

  BidDetail.fromJson(Map<String, dynamic> json) {
    _country = json['country'];
    _flag = json['flag'];
    _amount = json['amount'];
    _userId = json['user_id'];
    if (json['previous_bids'] != null) {
      _previousBids = <PreviousBids>[];
      json['previous_bids'].forEach((v) {
        _previousBids!.add(PreviousBids.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = _country;
    data['flag'] = _flag;
    data['amount'] = _amount;
    data['user_id'] = _userId;
    if (_previousBids != null) {
      data['previous_bids'] = _previousBids!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PreviousBids {
  String? _country;
  String? _flag;
  dynamic _amount;

  PreviousBids({String? country, String? flag, dynamic amount}) {
    if (country != null) {
      _country = country;
    }
    if (flag != null) {
      _flag = flag;
    }
    if (amount != null) {
      _amount = amount;
    }
  }

  String? get country => _country;

  set country(String? country) => _country = country;

  String? get flag => _flag;

  set flag(String? flag) => _flag = flag;

  dynamic get amount => _amount;

  set amount(dynamic amount) => _amount = amount;

  PreviousBids.fromJson(Map<String, dynamic> json) {
    _country = json['country'];
    _flag = json['flag'];
    _amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = _country;
    data['flag'] = _flag;
    data['amount'] = _amount;
    return data;
  }
}
