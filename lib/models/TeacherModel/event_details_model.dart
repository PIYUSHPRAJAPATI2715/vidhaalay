class EventDetails {
  Data? data;
  bool? status;
  String? msg;

  EventDetails({this.data, this.status, this.msg});

  EventDetails.fromJson(Map<String, dynamic> json) {
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
  String? eventName;
  Null? image;
  int? schoolId;
  int? teacherId;
  int? classId;
  Null? from;
  Null? to;
  String? date;
  String? message;
  int? status;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Teacher? teacher;

  Data(
      {this.id,
        this.eventName,
        this.image,
        this.schoolId,
        this.teacherId,
        this.classId,
        this.from,
        this.to,
        this.date,
        this.message,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.teacher});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventName = json['event_name'];
    image = json['image'];
    schoolId = json['school_id'];
    teacherId = json['teacher_id'];
    classId = json['class_id'];
    from = json['from'];
    to = json['to'];
    date = json['date'];
    message = json['message'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    teacher =
    json['teacher'] != null ? new Teacher.fromJson(json['teacher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_name'] = this.eventName;
    data['image'] = this.image;
    data['school_id'] = this.schoolId;
    data['teacher_id'] = this.teacherId;
    data['class_id'] = this.classId;
    data['from'] = this.from;
    data['to'] = this.to;
    data['date'] = this.date;
    data['message'] = this.message;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
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
  String? classAssigned;
  String? email;
  String? uniqueId;
  String? mobile;
  String? dob;
  String? gender;
  String? password;
  String? userType;
  String? deviceType;
  String? fcmtoken;
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
