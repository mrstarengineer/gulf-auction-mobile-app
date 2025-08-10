class BalanceSummaryInfo {
  String? title;
  int? amount;

  BalanceSummaryInfo({this.title, this.amount});

  BalanceSummaryInfo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    amount = json['amount'];
  }
}