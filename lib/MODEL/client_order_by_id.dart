// To parse this JSON data, do
//
//     final clientOrderIdModel = clientOrderIdModelFromJson(jsonString);

import 'dart:convert';

ClientOrderIdModel clientOrderIdModelFromJson(String str) => ClientOrderIdModel.fromJson(json.decode(str));

String clientOrderIdModelToJson(ClientOrderIdModel data) => json.encode(data.toJson());

class ClientOrderIdModel {
  int id;
  String name;
  String title;
  String desc;
  String phoneNumber;
  String photoName;
  int serviceId;
  dynamic service;
  String applicationUserId;
  dynamic applicationUser;

  ClientOrderIdModel({
    required this.id,
    required this.name,
    required this.title,
    required this.desc,
    required this.phoneNumber,
    required this.photoName,
    required this.serviceId,
    this.service,
    required this.applicationUserId,
    this.applicationUser,
  });

  factory ClientOrderIdModel.fromJson(Map<String, dynamic> json) => ClientOrderIdModel(
    id: json["id"],
    name: json["name"],
    title: json["title"],
    desc: json["desc"],
    phoneNumber: json["phoneNumber"],
    photoName: json["photoName"],
    serviceId: json["serviceId"],
    service: json["service"],
    applicationUserId: json["applicationUserId"],
    applicationUser: json["applicationUser"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "title": title,
    "desc": desc,
    "phoneNumber": phoneNumber,
    "photoName": photoName,
    "serviceId": serviceId,
    "service": service,
    "applicationUserId": applicationUserId,
    "applicationUser": applicationUser,
  };
}
