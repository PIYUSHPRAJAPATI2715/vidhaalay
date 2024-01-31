class GetSyllabusModel {
  List<Data>? data;
  bool? status;
  String? msg;

  GetSyllabusModel({this.data, this.status, this.msg});

  GetSyllabusModel.fromJson(Map<String, dynamic> json) {
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
  int? classId;
  int? subjectId;
  int? teacherId;
  int? examTypeId;
  String? topic;
  String? description;
  int? status;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Subject? subject;
  Class? class0;

  Data({this.id, this.classId, this.subjectId, this.teacherId, this.examTypeId, this.topic, this.description, this.status, this.createdAt, this.updatedAt, this.deletedAt, this.subject, this.class0});

  Data.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  classId = json['class_id'];
  subjectId = json['subject_id'];
  teacherId = json['teacher_id'];
  examTypeId = json['exam_type_id'];
  topic = json['topic'];
  description = json['description'];
  status = json['status'];
  createdAt = json['createdAt'];
  updatedAt = json['updatedAt'];
  deletedAt = json['deletedAt'];
  subject = json['subject'] != null ? new Subject.fromJson(json['subject']) : null;
class0 = json['class'] != null ? new Class.fromJson(json['class']) : null;
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['class_id'] = this.classId;
  data['subject_id'] = this.subjectId;
  data['teacher_id'] = this.teacherId;
  data['exam_type_id'] = this.examTypeId;
  data['topic'] = this.topic;
  data['description'] = this.description;
  data['status'] = this.status;
  data['createdAt'] = this.createdAt;
  data['updatedAt'] = this.updatedAt;
  data['deletedAt'] = this.deletedAt;
  if (this.subject != null) {
  data['subject'] = this.subject!.toJson();
  }
  if (this.class0 != null) {
  data['class'] = this.class0!.toJson();
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

