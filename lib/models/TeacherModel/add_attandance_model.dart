class AddAttandanceModel {
  int? classId;
  int? studentId;
  bool? present;

  AddAttandanceModel({this.classId, this.studentId, this.present});

  AddAttandanceModel.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    studentId = json['student_id'];
    present = json['present'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class_id'] = this.classId;
    data['student_id'] = this.studentId;
    data['present'] = this.present;
    return data;
  }
}