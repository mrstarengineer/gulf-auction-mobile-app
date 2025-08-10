class VehicleImages {
  String? url;
  String? thumbnailUrl;

  VehicleImages({url, thumbnailUrl});

  VehicleImages.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    thumbnailUrl = json['thumbnail_url'];
  }
}