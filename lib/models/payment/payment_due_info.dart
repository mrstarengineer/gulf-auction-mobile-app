import '../meta/meta.dart';

class PaymentDueInfo {
  List<PaymentDueData>? data;
  Meta? meta;

  PaymentDueInfo({this.data, this.meta});

  PaymentDueInfo.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PaymentDueData>[];
      json['data'].forEach((v) {
        data!.add(PaymentDueData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentDueData {
  int? id;
  int? buyerId;
  String? buyerName;
  String? buyerContact;
  String? sellerName;
  int? sellerMemberId;
  int? buyerMemberId;
  int? vehicleId;
  String? vehicleTitle;
  String? issueDate;
  String? issueDateFormatted;
  String? invoiceNumber;
  String? vin;
  String? dueDate;
  String? dueDateFormatted;
  String? paymentDate;
  dynamic subTotal;
  dynamic discount;
  dynamic amount;
  String? type;
  String? note;
  String? accountType;
  dynamic totalAmount;
  dynamic paidAmount;
  dynamic vatAmount;
  dynamic dueAmount;
  int? status;
  String? statusName;
  String? colorClass;
  String? auctionAt;

  PaymentDueData(
      {this.id,
      this.buyerId,
      this.buyerName,
      this.paymentDate,
      this.vin,
      this.amount,
      this.buyerContact,
      this.sellerName,
      this.sellerMemberId,
      this.buyerMemberId,
      this.vehicleId,
      this.vehicleTitle,
      this.issueDate,
      this.issueDateFormatted,
      this.invoiceNumber,
      this.dueDate,
      this.dueDateFormatted,
      this.subTotal,
      this.discount,
      this.type,
      this.note,
      this.totalAmount,
      this.paidAmount,
      this.vatAmount,
      this.dueAmount,
      this.status,
      this.statusName,
      this.accountType,
      this.colorClass,
      this.auctionAt,
});

  PaymentDueData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    buyerId = json['buyer_id'];
    buyerName = json['buyer_name'];
    buyerContact = json['buyer_contact'];
    sellerName = json['seller_name'];
    sellerMemberId = json['seller_member_id'];
    buyerMemberId = json['buyer_member_id'];
    vehicleId = json['vehicle_id'];
    vehicleTitle = json['vehicle_title'];
    issueDate = json['issue_date'];
    amount = json['amount'];
    issueDateFormatted = json['issue_date_formatted'];
    invoiceNumber = json['invoice_number'];
    paymentDate = json['payment_date'];
    accountType = json['account_type'];
    vin = json['vin'];
    dueDate = json['due_date'];
    dueDateFormatted = json['due_date_formatted'];
    subTotal = json['sub_total'];
    discount = json['discount'];
    type = json['type'];
    note = json['note'];
    totalAmount = json['total_amount'];
    paidAmount = json['paid_amount'];
    vatAmount = json['vat_amount'];
    dueAmount = json['due_amount'];
    status = json['status'];
    statusName = json['status_name'];
    colorClass = json['color_class'];
    auctionAt = json['auction_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['buyer_id'] = buyerId;
    data['buyer_name'] = buyerName;
    data['buyer_contact'] = buyerContact;
    data['seller_name'] = sellerName;
    data['seller_member_id'] = sellerMemberId;
    data['buyer_member_id'] = buyerMemberId;
    data['vehicle_id'] = vehicleId;
    data['vehicle_title'] = vehicleTitle;
    data['issue_date'] = issueDate;
    data['issue_date_formatted'] = issueDateFormatted;
    data['invoice_number'] = invoiceNumber;
    data['due_date'] = dueDate;
    data['due_date_formatted'] = dueDateFormatted;
    data['sub_total'] = subTotal;
    data['discount'] = discount;
    data['type'] = type;
    data['note'] = note;
    data['total_amount'] = totalAmount;
    data['paid_amount'] = paidAmount;
    data['vat_amount'] = vatAmount;
    data['due_amount'] = dueAmount;
    data['status'] = status;
    data['status_name'] = statusName;
    data['color_class'] = colorClass;
    data['auction_at'] = auctionAt;
    return data;
  }
}
