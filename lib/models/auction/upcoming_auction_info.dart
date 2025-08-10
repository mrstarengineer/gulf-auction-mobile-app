class UpcomingAuctionInfo {
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

  UpcomingAuctionInfo(
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

  UpcomingAuctionInfo.fromJson(Map<String, dynamic> json) {
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