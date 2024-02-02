class LoginModelTeacher {
  Data? data;
  bool? status;
  String? msg;

  LoginModelTeacher({this.data, this.status, this.msg});

  LoginModelTeacher.fromJson(Map<String, dynamic> json) {
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
  String? profileImage;
  int? schoolId;
  int? classId;
  String? classAssigned;
  String? email;
  String? uniqueId;
  String? mobile;
  String? dob;
  String? gender;
  String? userType;
  String? deviceType;
  String? fcmtoken;
  Null? mobileOtp;
  int? status;
  List<ClassArr>? classArr;
  Class? class0;
  String? token;

  Data({this.id, this.name, this.profileImage, this.schoolId, this.classId, this.classAssigned, this.email, this.uniqueId, this.mobile, this.dob, this.gender, this.userType, this.deviceType, this.fcmtoken, this.mobileOtp, this.status, this.classArr, this.class0, this.token});

  Data.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  name = json['name'];
  profileImage = json['profile_image'];
  schoolId = json['school_id'];
  classId = json['class_id'];
  classAssigned = json['class_assigned'];
  email = json['email'];
  uniqueId = json['unique_id'];
  mobile = json['mobile'];
  dob = json['dob'];
  gender = json['gender'];
  userType = json['user_type'];
  deviceType = json['device_type'];
  fcmtoken = json['fcmtoken'];
  mobileOtp = json['mobile_otp'];
  status = json['status'];
  if (json['classArr'] != null) {
  classArr = <ClassArr>[];
  json['classArr'].forEach((v) { classArr!.add(new ClassArr.fromJson(v)); });
  }
class0 = json['Class'] != null ? new Class.fromJson(json['Class']) : null;
  token = json['token'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['name'] = this.name;
  data['profile_image'] = this.profileImage;
  data['school_id'] = this.schoolId;
  data['class_id'] = this.classId;
  data['class_assigned'] = this.classAssigned;
  data['email'] = this.email;
  data['unique_id'] = this.uniqueId;
  data['mobile'] = this.mobile;
  data['dob'] = this.dob;
  data['gender'] = this.gender;
  data['user_type'] = this.userType;
  data['device_type'] = this.deviceType;
  data['fcmtoken'] = this.fcmtoken;
  data['mobile_otp'] = this.mobileOtp;
  data['status'] = this.status;
  if (this.classArr != null) {
  data['classArr'] = this.classArr!.map((v) => v.toJson()).toList();
  }
  if (this.class0 != null) {
  data['Class'] = this.class0!.toJson();
  }
  data['token'] = this.token;
  return data;
  }
}

class ClassArr {
  int? id;
  String? name;

  ClassArr({this.id, this.name});

  ClassArr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Class {
  String? name;

  Class({this.name});

  Class.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
