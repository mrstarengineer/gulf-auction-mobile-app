import 'package:get/get.dart';
import '../meta/meta.dart';

class NotificationInfo {
  RxList<NotificationData>? data = <NotificationData>[].obs;
  Meta? meta;

  NotificationInfo({data, meta});

  NotificationInfo.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NotificationData>[].obs;  // Initialize as RxList
      json['data'].forEach((v) {
        data?.add(NotificationData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}
class NotificationData {
  int? id;
  String? notifiableType;
  int? notifiableId;
  String? message;
  bool? isRead;
  dynamic readAt;
  String? createdAt;

  NotificationData(
      {this.id,
        this.notifiableType,
        this.notifiableId,
        this.message,
        this.isRead,
        this.readAt,
        this.createdAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notifiableType = json['notifiable_type'];
    notifiableId = json['notifiable_id'];
    message = json['message'];
    isRead = json['is_read'];
    readAt = json['read_at'];
    createdAt = json['created_at'];
  }

}



