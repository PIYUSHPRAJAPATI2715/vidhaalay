class GetStudentAttandanceModel {
  Data? data;
  bool? status;
  String? msg;

  GetStudentAttandanceModel({this.data, this.status, this.msg});

  GetStudentAttandanceModel.fromJson(Map<String, dynamic> json) {
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
  int? studentId;
  int? classId;
  int? schoolId;
  bool? present;
  int? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.studentId,
        this.classId,
        this.schoolId,
        this.present,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    classId = json['class_id'];
    schoolId = json['school_id'];
    present = json['present'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['student_id'] = this.studentId;
    data['class_id'] = this.classId;
    data['school_id'] = this.schoolId;
    data['present'] = this.present;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
