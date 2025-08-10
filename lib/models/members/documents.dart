
class Documents {
  String? title;
  String? type;
  String? url;
  String? expireDate;
  String? refNumber;
  int? countryId;

  Documents(
      {this.title,
        this.type,
        this.url,
        this.expireDate,
        this.refNumber,
        this.countryId});

  Documents.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    type = json['type'] ?? '';
    url = json['url'] ?? '';
    expireDate = json['expire_date'] ?? '';
    refNumber = json['ref_number'] ?? '';
    countryId = json['country_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['title'] = title;
    data['type'] = type;
    data['url'] = url;
    data['expire_date'] = expireDate;
    data['ref_number'] = refNumber;
    data['country_id'] = countryId;
    return data;
  }
}