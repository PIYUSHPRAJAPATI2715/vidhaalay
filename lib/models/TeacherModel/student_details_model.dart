class StudentDetails {
  Data? data;
  bool? status;
  String? msg;

  StudentDetails({this.data, this.status, this.msg});

  StudentDetails.fromJson(Map<String, dynamic> json) {
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
  String? password;
  String? profileImage;
  int? classId;
  int? schoolId;
  String? userType;
  String? emailOtp;
  String? mobileOtp;
  bool? emailVerified;
  String? deviceType;
  String? fcmtoken;
  int? status;
  Class? class0;

  Data(
      {this.id,
        this.name,
        this.email,
        this.uniqueId,
        this.mobile,
        this.dob,
        this.gender,
        this.password,
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
        this.class0});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    uniqueId = json['unique_id'];
    mobile = json['mobile'];
    dob = json['dob'];
    gender = json['gender'];
    password = json['password'];
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
    class0 = json['class'] != null ? new Class.fromJson(json['class']) : null;
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
    data['password'] = this.password;
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
    if (this.class0 != null) {
      data['class'] = this.class0!.toJson();
    }
    return data;
  }
}

class Class {
  int? id;
  String? name;
  int? status;

  Class({this.id, this.name, this.status});

  Class.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}
