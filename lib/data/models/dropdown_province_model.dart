class ProvinceDropdownModel {
  int? id;
  String? nameTh;
  String? nameEn;
  int? geographyId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  ProvinceDropdownModel(
      {this.id,
      this.nameTh,
      this.nameEn,
      this.geographyId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  ProvinceDropdownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameTh = json['name_th'];
    nameEn = json['name_en'];
    geographyId = json['geography_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_th'] = this.nameTh;
    data['name_en'] = this.nameEn;
    data['geography_id'] = this.geographyId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
