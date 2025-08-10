class MemberDashboardInfo {
  dynamic totalDepositAmount;
  dynamic totalBalanceAmount;
  dynamic totalPaymentDue;
  dynamic availableBiddingLimit;
  dynamic paddleDepositAmount;
  Notifications? notifications;
  String? globalMessage;

  MemberDashboardInfo(
      {this.totalDepositAmount,
      this.totalBalanceAmount,
      this.totalPaymentDue,
      this.paddleDepositAmount,
      this.availableBiddingLimit,
      this.notifications,
      this.globalMessage});

  MemberDashboardInfo.fromJson(Map<String, dynamic> json) {
    totalDepositAmount = json['total_deposit_amount'];
    paddleDepositAmount = json['paddle_deposit_amount'];
    totalBalanceAmount = json['total_balance_amount'];
    totalPaymentDue = json['total_payment_due'];
    availableBiddingLimit = json['available_bidding_limit'];
    notifications = json['notifications'] != null
        ? Notifications.fromJson(json['notifications'])
        : null;
    globalMessage = json['global_message'];
  }
}

class Notifications {
  int? unreadNotifications;

  Notifications({this.unreadNotifications});

  Notifications.fromJson(Map<String, dynamic> json) {
    unreadNotifications = json['unread_notifications'];
  }
}
