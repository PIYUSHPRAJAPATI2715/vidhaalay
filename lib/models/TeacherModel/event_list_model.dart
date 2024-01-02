class GetEventModel {
  List<Data>? data;
  bool? status;
  String? msg;

  GetEventModel({this.data, this.status, this.msg});

  GetEventModel.fromJson(Map<String, dynamic> json) {
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
  String? eventName;
  Null? image;
  int? teacherId;
  int? classId;
  Null? from;
  Null? to;
  String? date;
  String? message;
  int? status;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Data(
      {this.id,
        this.eventName,
        this.image,
        this.teacherId,
        this.classId,
        this.from,
        this.to,
        this.date,
        this.message,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventName = json['event_name'];
    image = json['image'];
    teacherId = json['teacher_id'];
    classId = json['class_id'];
    from = json['from'];
    to = json['to'];
    date = json['date'];
    message = json['message'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_name'] = this.eventName;
    data['image'] = this.image;
    data['teacher_id'] = this.teacherId;
    data['class_id'] = this.classId;
    data['from'] = this.from;
    data['to'] = this.to;
    data['date'] = this.date;
    data['message'] = this.message;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    return data;
  }
}
