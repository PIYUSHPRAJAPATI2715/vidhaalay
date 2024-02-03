class EventDetails {
  Data? data;
  bool? status;
  String? msg;

  EventDetails({this.data, this.status, this.msg});

  EventDetails.fromJson(Map<String, dynamic> json) {
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
  String? eventName;
  Null? image;
  int? schoolId;
  int? teacherId;
  int? classId;
  String? date;
  String? message;
  int? status;
  String? createdAt;
  String? updatedAt;
  Teacher? teacher;

  Data(
      {this.id,
        this.eventName,
        this.image,
        this.schoolId,
        this.teacherId,
        this.classId,
        this.date,
        this.message,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.teacher});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventName = json['event_name'];
    image = json['image'];
    schoolId = json['school_id'];
    teacherId = json['teacher_id'];
    classId = json['class_id'];
    date = json['date'];
    message = json['message'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    teacher =
    json['teacher'] != null ? new Teacher.fromJson(json['teacher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_name'] = this.eventName;
    data['image'] = this.image;
    data['school_id'] = this.schoolId;
    data['teacher_id'] = this.teacherId;
    data['class_id'] = this.classId;
    data['date'] = this.date;
    data['message'] = this.message;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
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
