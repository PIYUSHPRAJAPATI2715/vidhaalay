class LatestEventModel {
  Data? data;
  bool? status;
  String? msg;

  LatestEventModel({this.data, this.status, this.msg});

  LatestEventModel.fromJson(Map<String, dynamic> json) {
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
  Event? event;
  Assignment? assignment;
  NextClass? nextClass;
  AttRatio? attRatio;

  Data({this.event, this.assignment, this.nextClass, this.attRatio});

  Data.fromJson(Map<String, dynamic> json) {
    event = json['event'] != null ? new Event.fromJson(json['event']) : null;
    assignment = json['assignment'] != null ? new Assignment.fromJson(json['assignment']) : null;
    nextClass = json['nextClass'] != null ? new NextClass.fromJson(json['nextClass']) : null;
    attRatio = json['attRatio'] != null ? new AttRatio.fromJson(json['attRatio']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.event != null) {
      data['event'] = this.event!.toJson();
    }
    if (this.assignment != null) {
      data['assignment'] = this.assignment!.toJson();
    }
    if (this.nextClass != null) {
      data['nextClass'] = this.nextClass!.toJson();
    }
    if (this.attRatio != null) {
      data['attRatio'] = this.attRatio!.toJson();
    }
    return data;
  }
}

class Event {
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
  Class? teacher;

  Event({this.id, this.eventName, this.image, this.schoolId, this.teacherId, this.classId, this.from, this.to, this.date, this.message, this.status, this.createdAt, this.updatedAt, this.deletedAt, this.teacher});

  Event.fromJson(Map<String, dynamic> json) {
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
    teacher = json['teacher'] != null ? new Class.fromJson(json['teacher']) : null;
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

  Teacher({this.id, this.name, this.profileImage, this.schoolId, this.classId, this.classAssigned, this.email, this.uniqueId, this.mobile, this.dob, this.gender, this.password, this.userType, this.deviceType, this.fcmtoken, this.mobileOtp, this.status});

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

class Assignment {
  int? id;
  int? teacherId;
  int? classId;
  int? schoolId;
  int? subjectId;
  String? assignmentName;
  String? tagline;
  String? detail;
  Null? image;
  String? dueDate;
  int? status;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Teacher? teacher;
  Class? class0;
  Class? subject;

  Assignment({this.id, this.teacherId, this.classId, this.schoolId, this.subjectId, this.assignmentName, this.tagline, this.detail, this.image, this.dueDate, this.status, this.createdAt, this.updatedAt, this.deletedAt, this.teacher, this.class0, this.subject});

  Assignment.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  teacherId = json['teacher_id'];
  classId = json['class_id'];
  schoolId = json['school_id'];
  subjectId = json['subject_id'];
  assignmentName = json['assignment_name'];
  tagline = json['tagline'];
  detail = json['detail'];
  image = json['image'];
  dueDate = json['dueDate'];
  status = json['status'];
  createdAt = json['createdAt'];
  updatedAt = json['updatedAt'];
  deletedAt = json['deletedAt'];
  teacher = json['teacher'] != null ? new Teacher.fromJson(json['teacher']) : null;
  class0 = json['class'] != null ? new Class.fromJson(json['class']) : null;
  subject = json['subject'] != null ? new Class.fromJson(json['subject']) : null;
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['teacher_id'] = this.teacherId;
  data['class_id'] = this.classId;
  data['school_id'] = this.schoolId;
  data['subject_id'] = this.subjectId;
  data['assignment_name'] = this.assignmentName;
  data['tagline'] = this.tagline;
  data['detail'] = this.detail;
  data['image'] = this.image;
  data['dueDate'] = this.dueDate;
  data['status'] = this.status;
  data['createdAt'] = this.createdAt;
  data['updatedAt'] = this.updatedAt;
  data['deletedAt'] = this.deletedAt;
  if (this.teacher != null) {
  data['teacher'] = this.teacher!.toJson();
  }
  if (this.class0 != null) {
  data['class'] = this.class0!.toJson();
  }
  if (this.subject != null) {
  data['subject'] = this.subject!.toJson();
  }
  return data;
  }
}

class Class {
  int? id;
  String? name;

  Class({this.id, this.name});

  Class.fromJson(Map<String, dynamic> json) {
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

class NextClass {
  String? time;
  Class? subject;
  Class? teacher;

  NextClass({this.time, this.subject, this.teacher});

  NextClass.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    subject = json['subject'] != null ? new Class.fromJson(json['subject']) : null;
    teacher = json['teacher'] != null ? new Class.fromJson(json['teacher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    return data;
  }
}

class AttRatio {
  String? present;
  String? absent;

  AttRatio({this.present, this.absent});

  AttRatio.fromJson(Map<String, dynamic> json) {
    present = json['present'];
    absent = json['absent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['present'] = this.present;
    data['absent'] = this.absent;
    return data;
  }
}

