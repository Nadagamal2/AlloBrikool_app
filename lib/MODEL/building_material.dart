import 'dart:convert';

List<BuldingMaterialModel> buldingMaterialModelFromJson(String str) => List<BuldingMaterialModel>.from(json.decode(str).map((x) => BuldingMaterialModel.fromJson(x)));

String buldingMaterialModelToJson(List<BuldingMaterialModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BuldingMaterialModel {
  int id;
  String name;
  String photoName;
  String description;
  String faceBookLink;
  String instagramLink;
  String location;
  String phoneNumber;
  String whatsAppNumber;
  List<BuildingMaterialsPhoto> buildingMaterialsPhotos;

  BuldingMaterialModel({
    required this.id,
    required this.name,
    required this.photoName,
    required this.description,
    required this.faceBookLink,
    required this.instagramLink,
    required this.location,
    required this.phoneNumber,
    required this.whatsAppNumber,
    required this.buildingMaterialsPhotos,
  });

  factory BuldingMaterialModel.fromJson(Map<String, dynamic> json) => BuldingMaterialModel(
    id: json["id"],
    name: json["name"],
    photoName: json["photoName"],
    description: json["description"],
    faceBookLink: json["faceBookLink"],
    instagramLink: json["instagramLink"],
    location: json["location"],
    phoneNumber: json["phoneNumber"],
    whatsAppNumber: json["whatsAppNumber"],
    buildingMaterialsPhotos: List<BuildingMaterialsPhoto>.from(json["buildingMaterialsPhotos"].map((x) => BuildingMaterialsPhoto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photoName": photoName,
    "description": description,
    "faceBookLink": faceBookLink,
    "instagramLink": instagramLink,
    "location": location,
    "phoneNumber": phoneNumber,
    "whatsAppNumber": whatsAppNumber,
    "buildingMaterialsPhotos": List<dynamic>.from(buildingMaterialsPhotos.map((x) => x.toJson())),
  };
}

class BuildingMaterialsPhoto {
  int id;
  String imgUrl;
  int buildingMaterialsId;

  BuildingMaterialsPhoto({
    required this.id,
    required this.imgUrl,
    required this.buildingMaterialsId,
  });

  factory BuildingMaterialsPhoto.fromJson(Map<String, dynamic> json) => BuildingMaterialsPhoto(
    id: json["id"],
    imgUrl: json["imgURL"],
    buildingMaterialsId: json["buildingMaterialsId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "imgURL": imgUrl,
    "buildingMaterialsId": buildingMaterialsId,
  };
}
