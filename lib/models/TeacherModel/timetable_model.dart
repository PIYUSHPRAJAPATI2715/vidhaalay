class GetTimetableModel {
  List<Data>? data;
  bool? status;
  String? msg;

  GetTimetableModel({this.data, this.status, this.msg});

  GetTimetableModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    status = json['status'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['msg'] = this.msg;
    return data;
  }
}

class Data {
  int? id;
  int? classId;
  int? subjectId;
  String? weekday;
  String? from;
  String? to;
  int? schoolId;
  int? teacherId;
  int? status;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Null? subject;
  Teacher? teacher;

  Data(
      {this.id,
        this.classId,
        this.subjectId,
        this.weekday,
        this.from,
        this.to,
        this.schoolId,
        this.teacherId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.subject,
        this.teacher});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classId = json['class_id'];
    subjectId = json['subject_id'];
    weekday = json['weekday'];
    from = json['from'];
    to = json['to'];
    schoolId = json['school_id'];
    teacherId = json['teacher_id'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    subject = json['subject'];
    teacher =
    json['teacher'] != null ? new Teacher.fromJson(json['teacher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['class_id'] = this.classId;
    data['subject_id'] = this.subjectId;
    data['weekday'] = this.weekday;
    data['from'] = this.from;
    data['to'] = this.to;
    data['school_id'] = this.schoolId;
    data['teacher_id'] = this.teacherId;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['subject'] = this.subject;
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    return data;
  }
}

class Teacher {
  int? id;
  String? name;
  String? profileImage;
  int? schoolId;
  int? classId;
  Null? classAssigned;
  String? email;
  String? uniqueId;
  String? mobile;
  String? dob;
  String? gender;
  String? password;
  String? userType;
  Null? deviceType;
  Null? fcmtoken;
  Null? mobileOtp;
  int? status;

  Teacher(
      {this.id,
        this.name,
        this.profileImage,
        this.schoolId,
        this.classId,
        this.classAssigned,
        this.email,
        this.uniqueId,
        this.mobile,
        this.dob,
        this.gender,
        this.password,
        this.userType,
        this.deviceType,
        this.fcmtoken,
        this.mobileOtp,
        this.status});

  Teacher.fromJson(Map<String, dynamic> json) {
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
    password = json['password'];
    userType = json['user_type'];
    deviceType = json['device_type'];
    fcmtoken = json['fcmtoken'];
    mobileOtp = json['mobile_otp'];
    status = json['status'];
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
    data['password'] = this.password;
    data['user_type'] = this.userType;
    data['device_type'] = this.deviceType;
    data['fcmtoken'] = this.fcmtoken;
    data['mobile_otp'] = this.mobileOtp;
    data['status'] = this.status;
    return data;
  }
}
