class ExamResultModel {
  List<Data>? data;
  bool? status;
  String? msg;

  ExamResultModel({this.data, this.status, this.msg});

  ExamResultModel.fromJson(Map<String, dynamic> json) {
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
  int? examId;
  int? classId;
  int? studentId;
  int? examTypeId;
  String? from;
  int? marks;
  int? totalMarks;
  int? passingMarks;

  Data(
      {this.id,
        this.examId,
        this.classId,
        this.studentId,
        this.examTypeId,
        this.from,
        this.marks,
        this.totalMarks,
        this.passingMarks});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examId = json['exam_id'];
    classId = json['class_id'];
    studentId = json['student_id'];
    examTypeId = json['exam_type_id'];
    from = json['from'];
    marks = json['marks'];
    totalMarks = json['totalMarks'];
    passingMarks = json['passingMarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['exam_id'] = this.examId;
    data['class_id'] = this.classId;
    data['student_id'] = this.studentId;
    data['exam_type_id'] = this.examTypeId;
    data['from'] = this.from;
    data['marks'] = this.marks;
    data['totalMarks'] = this.totalMarks;
    data['passingMarks'] = this.passingMarks;
    return data;
  }
}
