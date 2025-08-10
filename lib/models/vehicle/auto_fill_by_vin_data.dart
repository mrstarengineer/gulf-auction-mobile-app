class AutoFillByVinData {
  bool? success;
  int? makeId;
  String? makeName;
  int? modelId;
  String? modelName;
  int? year;

  AutoFillByVinData(
      {this.success,
        this.makeId,
        this.makeName,
        this.modelId,
        this.modelName,
        this.year});

  AutoFillByVinData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    makeId = json['make_id'];
    makeName = json['make_name'];
    modelId = json['model_id'];
    modelName = json['model_name'];
    year = json['year'];
  }
}