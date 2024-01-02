class LoginModel {
  Data? data;
  bool? status;
  String? msg;

  LoginModel({this.data, this.status, this.msg});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  String? email;
  String? uniqueId;
  String? mobile;
 dynamic dob;
 dynamic gender;
 dynamic profileImage;
  String? userType;
 dynamic soGoogle;
 dynamic soFacebook;
 dynamic emailOtp;
 dynamic mobileOtp;
 dynamic fcmtoken;
  bool? emailVerified;
  bool? mobileVerified;
  String? latitude;
  String? longitude;
  String? address;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? token;

  Data(
      {this.id,
        this.name,
        this.email,
        this.uniqueId,
        this.mobile,
        this.dob,
        this.gender,
        this.profileImage,
        this.userType,
        this.soGoogle,
        this.soFacebook,
        this.emailOtp,
        this.mobileOtp,
        this.fcmtoken,
        this.emailVerified,
        this.mobileVerified,
        this.latitude,
        this.longitude,
        this.address,
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
    dob = json['dob'];
    gender = json['gender'];
    profileImage = json['profile_image'];
    userType = json['user_type'];
    soGoogle = json['so_google'];
    soFacebook = json['so_facebook'];
    emailOtp = json['email_otp'];
    mobileOtp = json['mobile_otp'];
    fcmtoken = json['fcmtoken'];
    emailVerified = json['email_verified'];
    mobileVerified = json['mobile_verified'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
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
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['profile_image'] = this.profileImage;
    data['user_type'] = this.userType;
    data['so_google'] = this.soGoogle;
    data['so_facebook'] = this.soFacebook;
    data['email_otp'] = this.emailOtp;
    data['mobile_otp'] = this.mobileOtp;
    data['fcmtoken'] = this.fcmtoken;
    data['email_verified'] = this.emailVerified;
    data['mobile_verified'] = this.mobileVerified;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['token'] = this.token;
    return data;
  }
}
