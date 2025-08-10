class FileUrls {
  List<String>? photos;

  FileUrls({this.photos});

  FileUrls.fromJson(Map<String, dynamic> json) {
    photos = json['photos'].cast<String>();
  }

}