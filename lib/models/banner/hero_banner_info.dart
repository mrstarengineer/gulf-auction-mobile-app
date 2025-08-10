class HeroBannerInfo {
  int? id;
  String? url;

  HeroBannerInfo(
      {this.id,
        this.url,});

  HeroBannerInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['banner_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['banner_url'] = url;
    return data;
  }
}