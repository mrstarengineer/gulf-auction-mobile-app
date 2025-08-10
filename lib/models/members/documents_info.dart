class DocumentsInfo {
  List<Document>? data;
  Map<String, RequiredDocumentType>? requiredDocumentTypes;

  DocumentsInfo({
    this.data,
    this.requiredDocumentTypes,
  });

  factory DocumentsInfo.fromJson(Map<String, dynamic> json) {
    return DocumentsInfo(
      data: List<Document>.from(json['data'].map((x) => Document.fromJson(x))),
      requiredDocumentTypes: json['required_document_types'] is List
          ? null
          : (json['required_document_types'] as Map<String, dynamic>).map(
              (key, value) =>
                  MapEntry(key, RequiredDocumentType.fromJson(value)),
            ),
    );
  }
}

class Document {
  int? id;
  int? userId;
  int? type;
  String? url;
  String? typeName;
  int? countryId;
  String? countryName;
  String? refNumber;
  String? expireDate;
  int? status;
  String? statusName;
  String? uploadedOn;
  String? extension;

  Document({
    this.id,
    this.userId,
    this.type,
    this.url,
    this.typeName,
    this.countryId,
    this.countryName,
    this.refNumber,
    this.expireDate,
    this.status,
    this.statusName,
    this.uploadedOn,
    this.extension,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      userId: json['user_id'],
      type: json['type'],
      url: json['url'],
      typeName: json['type_name'],
      countryId: json['country_id'],
      countryName: json['country_name'],
      refNumber: json['ref_number'],
      expireDate: json['expire_date'],
      status: json['status'],
      statusName: json['status_name'],
      uploadedOn: json['uploaded_on'],
      extension: json['extension'],
    );
  }
}

class RequiredDocumentType {
  String? title;
  String? refNumberLabel;

  RequiredDocumentType({
    this.title,
    this.refNumberLabel,
  });

  factory RequiredDocumentType.fromJson(Map<String, dynamic> json) {
    return RequiredDocumentType(
      title: json['title'],
      refNumberLabel: json['ref_number_label'],
    );
  }
}
