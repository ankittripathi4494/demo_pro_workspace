class UserGroupResonseModel {
  String? status;
  String? response;
  String? message;
  List<UserGroupResonseData>? data;

  UserGroupResonseModel({this.status, this.response, this.message, this.data});

  UserGroupResonseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    response = json["response"];
    message = json["message"];
    data = json["data"] == null
        ? null
        : (json["data"] as List)
            .map((e) => UserGroupResonseData.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["response"] = response;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class UserGroupResonseData {
  String? id;
  String? userId;
  String? businessId;
  String? name;
  String? mobile;
  String? description;
  String? createdBy;
  String? createdOn;
  String? updatedOn;
  String? updatedBy;

  UserGroupResonseData(
      {this.id,
      this.userId,
      this.businessId,
      this.name,
      this.mobile,
      this.description,
      this.createdBy,
      this.createdOn,
      this.updatedOn,
      this.updatedBy});

  UserGroupResonseData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    businessId = json["business_id"];
    name = json["name"];
    mobile = json["mobile"];
    description = json["description"];
    createdBy = json["created_by"];
    createdOn = json["created_on"];
    updatedOn = json["updated_on"];
    updatedBy = json["updated_by"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["user_id"] = userId;
    _data["business_id"] = businessId;
    _data["name"] = name;
    _data["mobile"] = mobile;
    _data["description"] = description;
    _data["created_by"] = createdBy;
    _data["created_on"] = createdOn;
    _data["updated_on"] = updatedOn;
    _data["updated_by"] = updatedBy;
    return _data;
  }
}
