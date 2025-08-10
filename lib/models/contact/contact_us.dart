class ContactModel {
  String? address;
  String? lat;
  String? lon;
  List<String>? mobiles;
  List<String>? landlines;
  String? email;
  String? tollFree;
  Map<String, String>? openingHours;

  ContactModel({
    this.address,
    this.mobiles,
    this.landlines,
    this.email,
    this.lat,
    this.lon,
    this.tollFree,
    this.openingHours,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      address: json['address'],
      mobiles: List<String>.from(json['mobiles']),
      landlines: List<String>.from(json['landlines']),
      email: json['email'],
      lat: json['lat'],
      lon: json['lon'],
      tollFree: json['tollFree'],
      openingHours: Map<String, String>.from(json['openingHours']),
    );
  }
}
