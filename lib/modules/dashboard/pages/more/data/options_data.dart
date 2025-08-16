import 'package:gulf_car_auction/settings/settings.dart';

class MorePageOptions {
  final String _iconSvgPath;
  final String _title;
  final dynamic _optionName;

  MorePageOptions(this._iconSvgPath, this._title, this._optionName);

  String get iconSvgPath => _iconSvgPath;

  String get title => _title;

  get optionName => _optionName;

  static List<MorePageOptions> accountOptions = [
    MorePageOptions(
        AppSvgIcons.myProfile, 'My Profile', MAccountOptions.myProfile),
    MorePageOptions(
        AppSvgIcons.documents, 'My Documents', MAccountOptions.myDocuments),
    MorePageOptions(
        AppSvgIcons.watchList, 'Watchlist', MAccountOptions.watchList),
  ];

  static List<MorePageOptions> bidStatusOptions = [
    MorePageOptions(AppSvgIcons.lotsWon, 'Vehicles Won', MBidStatusOptions.vehiclesWon),
    MorePageOptions(
        AppSvgIcons.lotsLoss, 'Vehicles Lost', MBidStatusOptions.vehiclesLoss),
    MorePageOptions(AppSvgIcons.vehiclesOnApproval, 'Vehicles On Approval',
        MBidStatusOptions.vehiclesOnApproval),
    MorePageOptions(AppSvgIcons.myBid, 'My Prebids', MBidStatusOptions.preBid),

  ];

  static List<MorePageOptions> auctionsOptions = [
    MorePageOptions(AppSvgIcons.todaysAuction, 'Today\'s Auction',
        MAuctionsOptions.todaysAuction),
    MorePageOptions(
        AppSvgIcons.joinAuction, 'Join Auction', MAuctionsOptions.joinAuction),
    MorePageOptions(AppSvgIcons.auctionCalender, 'Auction Calender',
        MAuctionsOptions.auctionCalender),
  ];

  static List<MorePageOptions> sellMyCarOptions = [
    MorePageOptions(
        AppSvgIcons.menuName, 'Pending', MSellMyCarOptions.pendingVehicle),
    MorePageOptions(
        AppSvgIcons.menuName, 'Document', MSellMyCarOptions.documentStatus),
    MorePageOptions(
        AppSvgIcons.menuName, 'In Stock', MSellMyCarOptions.inStock),
    MorePageOptions(
        AppSvgIcons.menuName, 'In Auction', MSellMyCarOptions.inAuction),
    MorePageOptions(AppSvgIcons.menuName, 'Sold', MSellMyCarOptions.soldVehicle),
    MorePageOptions(
        AppSvgIcons.menuName, 'Unsold', MSellMyCarOptions.unsoldVehicle),
    MorePageOptions(AppSvgIcons.menuName, 'On Approv..',
        MSellMyCarOptions.sellingApprovalVehicle),
    MorePageOptions(AppSvgIcons.menuName, 'Return',
        MSellMyCarOptions.returnVehicle),
    MorePageOptions(
        AppSvgIcons.menuName, 'Rejected', MSellMyCarOptions.rejectedVehicle),
    MorePageOptions(
        AppSvgIcons.menuName, 'All Vehicle', MSellMyCarOptions.allVehicle),
  ];

  static List<MorePageOptions> paymentOptions = [
    MorePageOptions(
        AppSvgIcons.paymentDue, 'My Account', MPaymentOptions.myAccount),
    MorePageOptions(
        AppSvgIcons.paymentDue, 'Payment Due', MPaymentOptions.paymentDue),
    MorePageOptions(AppSvgIcons.paymentHistory, 'Payment History',
        MPaymentOptions.paymentHistory),
    MorePageOptions(AppSvgIcons.depositAccount, 'Deposit Account',
        MPaymentOptions.depositAccount),
    // MorePageOptions(AppSvgIcons.onlineAccount, 'Online Account',
    //     MPaymentOptions.onlineAccount),
    // MorePageOptions(AppSvgIcons.bookedVehicleDue, 'Booked Vehicle Due',
    //     MPaymentOptions.bookedVehicleDue),
    // MorePageOptions(AppSvgIcons.bookedPaymentHistory, 'Booked Payment History',
    //     MPaymentOptions.bookedPaymentHistory),
  ];

  static List<MorePageOptions> moreOptions = [
    MorePageOptions(AppSvgIcons.car, 'Buy Now', MMoreOptions.buyNow),
    MorePageOptions(AppSvgIcons.menuName, 'Downloads', MMoreOptions.downloads),
    MorePageOptions(AppSvgIcons.menuName, 'Career', MMoreOptions.career),
    MorePageOptions(AppSvgIcons.menuName, 'Contact', MMoreOptions.contact),
  ];
}
