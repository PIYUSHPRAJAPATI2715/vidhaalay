class GetAttandanceListData {
  List<Data>? data;
  bool? status;
  String? msg;

  GetAttandanceListData({this.data, this.status, this.msg});

  GetAttandanceListData.fromJson(Map<String, dynamic> json) {
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
  int? studentId;
  String? studentName;
  int? classId;
  bool? present;

  Data({this.studentId, this.studentName, this.classId, this.present});

  Data.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    studentName = json['student_name'];
    classId = json['class_id'];
    present = json['present'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['student_id'] = this.studentId;
    data['student_name'] = this.studentName;
    data['class_id'] = this.classId;
    data['present'] = this.present;
    return data;
  }
}
