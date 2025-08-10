class UserInfo {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? primaryPhone;
  String? primaryPhoneCode;
  dynamic alternatePhone;
  dynamic alternatePhoneCode;
  int? type;
  String? accountTypeName;
  dynamic companyName;
  String? username;
  String? email;
  dynamic stateId;
  dynamic stateName;
  dynamic cityId;
  dynamic cityName;
  dynamic zipCode;
  String? address;
  int? countryId;
  String? countryName;
  int? approveForBidding;
  String? approveForBiddingName;
  int? role;
  String? roleName;
  bool? status;
  String? statusName;
  String? profilePhoto;
  bool? requiredDocuments;

  UserInfo(
      {this.id,
        this.name,
        this.firstName,
        this.lastName,
        this.primaryPhone,
        this.primaryPhoneCode,
        this.alternatePhone,
        this.alternatePhoneCode,
        this.type,
        this.accountTypeName,
        this.companyName,
        this.username,
        this.email,
        this.stateId,
        this.stateName,
        this.cityId,
        this.cityName,
        this.zipCode,
        this.address,
        this.countryId,
        this.countryName,
        this.approveForBidding,
        this.approveForBiddingName,
        this.role,
        this.roleName,
        this.status,
        this.statusName,
        this.profilePhoto,
        this.requiredDocuments});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    primaryPhone = json['primary_phone'];
    primaryPhoneCode = json['primary_phone_code'];
    alternatePhone = json['alternate_phone'];
    alternatePhoneCode = json['alternate_phone_code'];
    type = json['type'];
    accountTypeName = json['account_type_name'];
    companyName = json['company_name'];
    username = json['username'];
    email = json['email'];
    stateId = json['state_id'];
    stateName = json['state_name'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    zipCode = json['zip_code'];
    address = json['address'];
    countryId = json['country_id'];
    countryName = json['country_name'];
    approveForBidding = json['approve_for_bidding'];
    approveForBiddingName = json['approve_for_bidding_name'];
    role = json['role'];
    roleName = json['role_name'];
    status = json['status'];
    statusName = json['status_name'];
    profilePhoto = json['profile_photo'];
    requiredDocuments = json['required_documents'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['primary_phone'] = primaryPhone;
    data['primary_phone_code'] = primaryPhoneCode;
    data['alternate_phone'] = alternatePhone;
    data['alternate_phone_code'] = alternatePhoneCode;
    data['type'] = type;
    data['account_type_name'] = accountTypeName;
    data['company_name'] = companyName;
    data['username'] = username;
    data['email'] = email;
    data['state_id'] = stateId;
    data['state_name'] = stateName;
    data['city_id'] = cityId;
    data['city_name'] = cityName;
    data['zip_code'] = zipCode;
    data['address'] = address;
    data['country_id'] = countryId;
    data['country_name'] = countryName;
    data['approve_for_bidding'] = approveForBidding;
    data['approve_for_bidding_name'] = approveForBiddingName;
    data['role'] = role;
    data['role_name'] = roleName;
    data['status'] = status;
    data['status_name'] = statusName;
    data['profile_photo'] = profilePhoto;
    data['required_documents'] = requiredDocuments;
    return data;
  }
}