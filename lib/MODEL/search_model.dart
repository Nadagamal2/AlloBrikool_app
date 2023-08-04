// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));



class SearchModel {
  dynamic photo;
  int? id;
  String? name;
  String? photoName;
  String? description;
//  List<ClientOrder> clientOrder;

  SearchModel({
    this.photo,
      this.id,
      this.name,
      this.photoName,
      this.description,
   // required this.clientOrder,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
  photo: json["photo"],
    id: json["id"],
    name: json["name"],
    photoName: json["photoName"],
    description: json["description"],
  //  clientOrder: List<ClientOrder>.from(json["clientOrder"].map((x) => ClientOrder.fromJson(x))),
  );


}

// class ClientOrder {
//   int id;
//   String name;
//   String title;
//   String desc;
//   String phoneNumber;
//   String photoName;
//   int serviceId;
//
//   String applicationUserId;
//
//
//   ClientOrder({
//     required this.id,
//     required this.name,
//     required this.title,
//     required this.desc,
//     required this.phoneNumber,
//     required this.photoName,
//     required this.serviceId,
//
//     required this.applicationUserId,
//
//   });
//
//   factory ClientOrder.fromJson(Map<String, dynamic> json) => ClientOrder(
//     id: json["id"],
//     name: json["name"],
//     title: json["title"],
//     desc: json["desc"],
//     phoneNumber: json["phoneNumber"],
//     photoName: json["photoName"],
//     serviceId: json["serviceId"],
//
//     applicationUserId: json["applicationUserId"],
//
//   );
//  }
