class CountryInfo {
  int? id;
  int? value;
  String? shortCode;
  String? name;
  String? label;
  String? dialCode;
  dynamic flagIcon;
  String? flag;

  @override
  String toString() {
    return name ?? '';
  }

  CountryInfo(
      {this.id,
        this.value,
        this.shortCode,
        this.name,
        this.label,
        this.dialCode,
        this.flagIcon,
        this.flag});

  CountryInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    shortCode = json['short_code'];
    name = json['name'];
    label = json['label'];
    dialCode = json['dial_code'];
    flagIcon = json['flag_icon'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;
    data['short_code'] = shortCode;
    data['name'] = name;
    data['label'] = label;
    data['dial_code'] = dialCode;
    data['flag_icon'] = flagIcon;
    data['flag'] = flag;
    return data;
  }
}