
class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  dynamic perPage;
  int? to;
  int? total;

  Meta(
      {currentPage,
        from,
        lastPage,
        links,
        path,
        perPage,
        to,
        total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

}
