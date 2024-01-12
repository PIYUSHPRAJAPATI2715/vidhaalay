class LoginStudentModel {
  Data? data;
  bool? status;
  String? msg;

  LoginStudentModel({this.data, this.status, this.msg});

  LoginStudentModel.fromJson(Map<String, dynamic> json) {
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
  String? dob;
  String? gender;
  String? profileImage;
  int? classId;
  int? schoolId;
  Null? userType;
  Null? emailOtp;
  Null? mobileOtp;
  bool? emailVerified;
  String? deviceType;
  String? fcmtoken;
  int? status;
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
        this.classId,
        this.schoolId,
        this.userType,
        this.emailOtp,
        this.mobileOtp,
        this.emailVerified,
        this.deviceType,
        this.fcmtoken,
        this.status,
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
    classId = json['class_id'];
    schoolId = json['school_id'];
    userType = json['user_type'];
    emailOtp = json['email_otp'];
    mobileOtp = json['mobile_otp'];
    emailVerified = json['email_verified'];
    deviceType = json['device_type'];
    fcmtoken = json['fcmtoken'];
    status = json['status'];
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
    data['class_id'] = this.classId;
    data['school_id'] = this.schoolId;
    data['user_type'] = this.userType;
    data['email_otp'] = this.emailOtp;
    data['mobile_otp'] = this.mobileOtp;
    data['email_verified'] = this.emailVerified;
    data['device_type'] = this.deviceType;
    data['fcmtoken'] = this.fcmtoken;
    data['status'] = this.status;
    data['token'] = this.token;
    return data;
  }
}
