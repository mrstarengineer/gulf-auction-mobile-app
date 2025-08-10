class AuctionListInfo {
  int? totalAuctions;
  List<Auctions>? liveAuctions;
  List<Auctions>? laterToday;

  AuctionListInfo({this.totalAuctions, this.liveAuctions, this.laterToday});

  AuctionListInfo.fromJson(Map<String, dynamic> json) {
    totalAuctions = json['total_auctions'];
    if (json['live_auctions'] != null) {
      liveAuctions = <Auctions>[];
      json['live_auctions'].forEach((v) {
        liveAuctions!.add(Auctions.fromJson(v));
      });
    }
    if (json['later_today'] != null) {
      laterToday = <Auctions>[];
      json['later_today'].forEach((v) {
        laterToday!.add(Auctions.fromJson(v));
      });
    }
  }

}

class Auctions {
  int? id;
  int? totalVehicles;
  String? locationName;
  String? auctionYardName;
  String? auctionYardBanner;
  String? auctionAt;
  String? auctionAtFormatted;
  int? auctionType;
  String? auctionTypeName;
  String? catalogUrl;
  String? auctionTime;
  String? timeLeft;
  int? status;
  String? statusName;

  Auctions(
      {this.id,
        this.totalVehicles,
        this.locationName,
        this.auctionYardName,
        this.auctionYardBanner,
        this.auctionAt,
        this.auctionAtFormatted,
        this.auctionType,
        this.auctionTypeName,
        this.catalogUrl,
        this.auctionTime,
        this.timeLeft,
        this.status,
        this.statusName});

  Auctions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalVehicles = json['total_vehicles'];
    locationName = json['location_name'];
    auctionYardName = json['auction_yard_name'];
    auctionYardBanner = json['auction_yard_banner'];
    auctionAt = json['auction_at'];
    auctionAtFormatted = json['auction_at_formatted'];
    auctionType = json['auction_type'];
    auctionTypeName = json['auction_type_name'];
    catalogUrl = json['catalog_url'];
    auctionTime = json['auction_time'];
    timeLeft = json['time_left'];
    status = json['status'];
    statusName = json['status_name'];
  }

}