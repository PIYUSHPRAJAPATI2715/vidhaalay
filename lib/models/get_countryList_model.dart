class CountryListModel {
  List<Data>? data;
  bool? status;
  String? msg;

  CountryListModel({this.data, this.status, this.msg});

  CountryListModel.fromJson(Map<String, dynamic> json) {
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
  String? countrycode;
  String? name;

  Data({this.id, this.countrycode, this.name});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countrycode = json['countrycode'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['countrycode'] = this.countrycode;
    data['name'] = this.name;
    return data;
  }
}
