class ClassTimetableDetails {
  Data? data;
  bool? status;
  String? msg;

  ClassTimetableDetails({this.data, this.status, this.msg});

  ClassTimetableDetails.fromJson(Map<String, dynamic> json) {
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
        this.deletedAt});

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
    return data;
  }
}
