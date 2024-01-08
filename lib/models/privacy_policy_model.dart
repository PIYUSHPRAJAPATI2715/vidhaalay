// To parse this JSON data, do
//
//     final privacyPolicyModel = privacyPolicyModelFromJson(jsonString);

import 'dart:convert';

PrivacyPolicyModel privacyPolicyModelFromJson(String str) => PrivacyPolicyModel.fromJson(json.decode(str));

String privacyPolicyModelToJson(PrivacyPolicyModel data) => json.encode(data.toJson());

class PrivacyPolicyModel {
  Data data;
  bool status;
  String msg;

  PrivacyPolicyModel({
    required this.data,
    required this.status,
    required this.msg,
  });

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) => PrivacyPolicyModel(
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
