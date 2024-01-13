class AddExamModel {
  int? id;
  int? examId;
  int? classId;
  String? subjectName;
  int? studentId;
  int? examTypeId;
  String? from;
  int? marks;
  int? totalMarks;
  int? passingMarks;

  AddExamModel(
      {this.id,
        this.examId,
        this.classId,
        this.subjectName,
        this.studentId,
        this.examTypeId,
        this.from,
        this.marks,
        this.totalMarks,
        this.passingMarks});

  AddExamModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examId = json['exam_id'];
    classId = json['class_id'];
    subjectName = json['subject_name'];
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
    data['subject_name'] = this.subjectName;
    data['student_id'] = this.studentId;
    data['exam_type_id'] = this.examTypeId;
    data['from'] = this.from;
    data['marks'] = this.marks;
    data['totalMarks'] = this.totalMarks;
    data['passingMarks'] = this.passingMarks;
    return data;
  }
}
