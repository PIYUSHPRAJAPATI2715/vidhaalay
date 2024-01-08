class CreateEvent {
  Data? data;
  bool? status;
  String? msg;

  CreateEvent({this.data, this.status, this.msg});

  CreateEvent.fromJson(Map<String, dynamic> json) {
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
  int? status;
  int? id;
  String? eventName;
  String? date;
  String? message;
  int? classId;
  int? teacherId;
  int? schoolId;
  String? updatedAt;
  String? createdAt;
  Null? image;
  Null? from;
  Null? to;
  Null? deletedAt;

  Data(
      {this.status,
        this.id,
        this.eventName,
        this.date,
        this.message,
        this.classId,
        this.teacherId,
        this.schoolId,
        this.updatedAt,
        this.createdAt,
        this.image,
        this.from,
        this.to,
        this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    eventName = json['event_name'];
    date = json['date'];
    message = json['message'];
    classId = json['class_id'];
    teacherId = json['teacher_id'];
    schoolId = json['school_id'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    image = json['image'];
    from = json['from'];
    to = json['to'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['id'] = this.id;
    data['event_name'] = this.eventName;
    data['date'] = this.date;
    data['message'] = this.message;
    data['class_id'] = this.classId;
    data['teacher_id'] = this.teacherId;
    data['school_id'] = this.schoolId;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['image'] = this.image;
    data['from'] = this.from;
    data['to'] = this.to;
    data['deletedAt'] = this.deletedAt;
    return data;
  }
}
