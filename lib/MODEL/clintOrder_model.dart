

import 'dart:convert';

List<ClintOrderModel> clintOrderModelFromJson(String str) => List<ClintOrderModel>.from(json.decode(str).map((x) => ClintOrderModel.fromJson(x)));


class ClintOrderModel {
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

  ClintOrderModel({
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

  factory ClintOrderModel.fromJson(Map<String, dynamic> json) => ClintOrderModel(
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


}
