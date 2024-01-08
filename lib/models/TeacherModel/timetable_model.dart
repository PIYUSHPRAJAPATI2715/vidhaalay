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
  int? schoolId;
  int? teacherId;
  int? classId;
  int? subjectId;
  String? weekday;
  String? fromTime;
  String? toTime;
  int? status;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Subject? subject;
  Teacher? teacher;

  Data(
      {this.id,
        this.schoolId,
        this.teacherId,
        this.classId,
        this.subjectId,
        this.weekday,
        this.fromTime,
        this.toTime,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.subject,
        this.teacher});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolId = json['school_id'];
    teacherId = json['teacher_id'];
    classId = json['class_id'];
    subjectId = json['subject_id'];
    weekday = json['weekday'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    subject =
    json['subject'] != null ? new Subject.fromJson(json['subject']) : null;
    teacher =
    json['teacher'] != null ? new Teacher.fromJson(json['teacher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['school_id'] = this.schoolId;
    data['teacher_id'] = this.teacherId;
    data['class_id'] = this.classId;
    data['subject_id'] = this.subjectId;
    data['weekday'] = this.weekday;
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    return data;
  }
}

class Subject {
  int? id;
  String? name;

  Subject({this.id, this.name});

  Subject.fromJson(Map<String, dynamic> json) {
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

class Teacher {
  int? id;
  String? name;
  String? profileImage;

  Teacher({this.id, this.name, this.profileImage});

  Teacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
