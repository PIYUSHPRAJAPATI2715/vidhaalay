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
  List<AttendanceData>? attendanceData;
  AttRatio? attRatio;

  Data({this.attendanceData, this.attRatio});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['attendanceData'] != null) {
      attendanceData = <AttendanceData>[];
      json['attendanceData'].forEach((v) {
        attendanceData!.add(new AttendanceData.fromJson(v));
      });
    }
    attRatio = json['attRatio'] != null
        ? new AttRatio.fromJson(json['attRatio'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attendanceData != null) {
      data['attendanceData'] =
          this.attendanceData!.map((v) => v.toJson()).toList();
    }
    if (this.attRatio != null) {
      data['attRatio'] = this.attRatio!.toJson();
    }
    return data;
  }
}

class AttendanceData {
  int? studentId;
  int? classId;
  int? schoolId;
  int? present;
  int? status;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  int? id;

  AttendanceData(
      {this.studentId,
        this.classId,
        this.schoolId,
        this.present,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.id});

  AttendanceData.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    classId = json['class_id'];
    schoolId = json['school_id'];
    present = json['present'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['student_id'] = this.studentId;
    data['class_id'] = this.classId;
    data['school_id'] = this.schoolId;
    data['present'] = this.present;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['id'] = this.id;
    return data;
  }
}

class AttRatio {
  String? present;
  String? absent;
  String? holiday;

  AttRatio({this.present, this.absent, this.holiday});

  AttRatio.fromJson(Map<String, dynamic> json) {
    present = json['present'];
    absent = json['absent'];
    holiday = json['holiday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['present'] = this.present;
    data['absent'] = this.absent;
    data['holiday'] = this.holiday;
    return data;
  }
}
