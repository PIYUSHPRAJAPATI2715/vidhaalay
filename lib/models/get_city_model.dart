class GetCityModel {
  List<Data>? data;
  bool? status;
  String? msg;

  GetCityModel({this.data, this.status, this.msg});

  GetCityModel.fromJson(Map<String, dynamic> json) {
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
  int? stateId;
  String? city;

  Data({this.id, this.stateId, this.city});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateId = json['state_id'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state_id'] = this.stateId;
    data['city'] = this.city;
    return data;
  }
}
