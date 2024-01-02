// To parse this JSON data, do
//
//     final termsModel = termsModelFromJson(jsonString);

import 'dart:convert';

TermsModel termsModelFromJson(String str) => TermsModel.fromJson(json.decode(str));

String termsModelToJson(TermsModel data) => json.encode(data.toJson());

class TermsModel {
  Data data;
  bool status;
  String msg;

  TermsModel({
    required this.data,
    required this.status,
    required this.msg,
  });

  factory TermsModel.fromJson(Map<String, dynamic> json) => TermsModel(
    data: Data.fromJson(json["data"]),
    status: json["status"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "status": status,
    "msg": msg,
  };
}

class Data {
  String id;
  String title;
  String slug;
  String content;
  int status;

  Data({
    required this.id,
    required this.title,
    required this.slug,
    required this.content,
    required this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    content: json["content"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "content": content,
    "status": status,
  };
}
