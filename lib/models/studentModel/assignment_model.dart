class GetAssignmentModel {
  List<Data>? data;
  bool? status;
  String? msg;

  GetAssignmentModel({this.data, this.status, this.msg});

  GetAssignmentModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) { data!.add(new Data.fromJson(v)); });
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
  Class0? class0;
  Class0? subject;

  Data({this.id, this.teacherId, this.classId, this.schoolId, this.subjectId, this.assignmentName, this.tagline, this.detail, this.image, this.dueDate, this.status, this.createdAt, this.updatedAt, this.deletedAt, this.teacher, this.class0, this.subject});

  Data.fromJson(Map<String, dynamic> json) {
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
class0 = json['class'] != null ? new Class0.fromJson(json['class']) : null;
  subject = json['subject'] != null ? new Class0.fromJson(json['subject']) : null;
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

class Class0 {
  int? id;
  String? name;

  Class0({this.id, this.name});

  Class0.fromJson(Map<String, dynamic> json) {
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
