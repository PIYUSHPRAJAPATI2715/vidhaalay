class ExamTimetableDetails {
  Data? data;
  bool? status;
  String? msg;

  ExamTimetableDetails({this.data, this.status, this.msg});

  ExamTimetableDetails.fromJson(Map<String, dynamic> json) {
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
  int? classId;
  int? subjectId;
  String? from;
  String? to;
  int? teacherId;
  int? examTypeId;
  int? seatClassId;
  int? schoolId;
  int? createdBy;
  int? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.classId,
        this.subjectId,
        this.from,
        this.to,
        this.teacherId,
        this.examTypeId,
        this.seatClassId,
        this.schoolId,
        this.createdBy,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classId = json['class_id'];
    subjectId = json['subject_id'];
    from = json['from'];
    to = json['to'];
    teacherId = json['teacher_id'];
    examTypeId = json['exam_type_id'];
    seatClassId = json['seat_class_id'];
    schoolId = json['school_id'];
    createdBy = json['createdBy'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['class_id'] = this.classId;
    data['subject_id'] = this.subjectId;
    data['from'] = this.from;
    data['to'] = this.to;
    data['teacher_id'] = this.teacherId;
    data['exam_type_id'] = this.examTypeId;
    data['seat_class_id'] = this.seatClassId;
    data['school_id'] = this.schoolId;
    data['createdBy'] = this.createdBy;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
