// To parse this JSON data, do
//
//     final servicsModel = servicsModelFromJson(jsonString);

import 'dart:convert';

List<ServicsModel> servicsModelFromJson(String str) => List<ServicsModel>.from(json.decode(str).map((x) => ServicsModel.fromJson(x)));


class ServicsModel {
  int id;
  String name;
  String photoName;
  String description;


  ServicsModel({
    required this.id,
    required this.name,
    required this.photoName,
    required this.description,

  });

  factory ServicsModel.fromJson(Map<String, dynamic> json) => ServicsModel(
    id: json["id"],
    name: json["name"],
    photoName: json["photoName"],
    description: json["description"],

  );


}
