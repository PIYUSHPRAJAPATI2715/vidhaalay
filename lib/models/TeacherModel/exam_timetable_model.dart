class GetExamTimetableModel0 {
  List<Data>? data;
  bool? status;
  String? msg;

  GetExamTimetableModel0({this.data, this.status, this.msg});

  GetExamTimetableModel0.fromJson(Map<String, dynamic> json) {
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
  Subject? subject;
  ExamType? examType;
  Teacher? teacher;

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
        this.updatedAt,
        this.subject,
        this.examType,
        this.teacher});

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
    subject =
    json['subject'] != null ? new Subject.fromJson(json['subject']) : null;
    examType = json['exam_type'] != null
        ? new ExamType.fromJson(json['exam_type'])
        : null;
    teacher =
    json['teacher'] != null ? new Teacher.fromJson(json['teacher']) : null;
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
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    if (this.examType != null) {
      data['exam_type'] = this.examType!.toJson();
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
  List<int>? classId;
  int? status;

  Subject({this.id, this.name, this.classId, this.status});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    classId = json['class_id'].cast<int>();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['class_id'] = this.classId;
    data['status'] = this.status;
    return data;
  }
}

class ExamType {
  int? id;
  String? name;
  String? month;

  ExamType({this.id, this.name, this.month});

  ExamType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['month'] = this.month;
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
