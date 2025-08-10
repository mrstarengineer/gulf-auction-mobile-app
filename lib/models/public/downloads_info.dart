class DownloadsInfo {
  int? id;
  String? title;
  String? description;
  String? photo;
  String? attachment;
  int? status;
  String? statusName;
  String? createdAt;

  DownloadsInfo(
      {this.id,
        this.title,
        this.description,
        this.photo,
        this.attachment,
        this.status,
        this.statusName,
        this.createdAt});

  DownloadsInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    photo = json['photo'];
    attachment = json['attachment'];
    status = json['status'];
    statusName = json['status_name'];
    createdAt = json['created_at'];
  }

}