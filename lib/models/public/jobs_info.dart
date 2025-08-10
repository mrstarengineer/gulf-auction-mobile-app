class JobsInfo {
  int? id;
  String? jobTitle;
  String? jobLocation;
  String? applicationDeadline;
  String? applicationDeadlineFormatted;
  String? description;
  dynamic attachment;
  int? status;
  String? statusName;
  String? createdAt;

  JobsInfo(
      {this.id,
        this.jobTitle,
        this.jobLocation,
        this.applicationDeadline,
        this.applicationDeadlineFormatted,
        this.description,
        this.attachment,
        this.status,
        this.statusName,
        this.createdAt});

  JobsInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobTitle = json['job_title'];
    jobLocation = json['job_location'];
    applicationDeadline = json['application_deadline'];
    applicationDeadlineFormatted = json['application_deadline_formatted'];
    description = json['description'];
    attachment = json['attachment'];
    status = json['status'];
    statusName = json['status_name'];
    createdAt = json['created_at'];
  }
}