import '../meta/meta.dart';

class PaymentReceiptInfo {
  List<PaymentReceiptData>? data;
  Meta? meta;

  PaymentReceiptInfo({this.data, this.meta});

  PaymentReceiptInfo.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PaymentReceiptData>[];
      json['data'].forEach((v) {
        data!.add( PaymentReceiptData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}

class PaymentReceiptData {
  int? id;
  dynamic userId;
  String? bankName;
  String? amount;
  String? paymentDate;
  String? referenceNumber;
  int? paymentChannel;
  String? note;
  int? status;
  String? attachment;
  String? statusName;
  String? paymentChannelName;

  PaymentReceiptData(
      {this.id,
        this.userId,
        this.bankName,
        this.amount,
        this.paymentDate,
        this.referenceNumber,
        this.paymentChannel,
        this.note,
        this.status,
        this.attachment,
        this.statusName,
        this.paymentChannelName});

  PaymentReceiptData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bankName = json['bank_name'];
    amount = json['amount'];
    paymentDate = json['payment_date'];
    referenceNumber = json['reference_number'];
    paymentChannel = json['payment_channel'];
    note = json['note'];
    status = json['status'];
    attachment = json['attachment'];
    statusName = json['status_name'];
    paymentChannelName = json['payment_channel_name'];
  }
}