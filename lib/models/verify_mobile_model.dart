class VerifyMobileModel {
  Data? data;
  bool? status;
  String? msg;

  VerifyMobileModel({this.data, this.status, this.msg});

  VerifyMobileModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    data['msg'] = this.msg;
    return data;
  }
}

class Data {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic uniqueId;
  dynamic mobile;
  dynamic userType;
  dynamic emailVerified;
  dynamic mobileVerified;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic token;

  Data(
      {this.id,
        this.name,
        this.email,
        this.uniqueId,
        this.mobile,
        this.userType,
        this.emailVerified,
        this.mobileVerified,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    uniqueId = json['unique_id'];
    mobile = json['mobile'];
    userType = json['user_type'];
    emailVerified = json['email_verified'];
    mobileVerified = json['mobile_verified'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['unique_id'] = this.uniqueId;
    data['mobile'] = this.mobile;
    data['user_type'] = this.userType;
    data['email_verified'] = this.emailVerified;
    data['mobile_verified'] = this.mobileVerified;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['token'] = this.token;
    return data;
  }
}