

import 'dart:convert';

List<SliderModel> sliderModelFromJson(String str) => List<SliderModel>.from(json.decode(str).map((x) => SliderModel.fromJson(x)));

String sliderModelToJson(List<SliderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SliderModel {
  int id;
  String photoName;

  SliderModel({
    required this.id,
    required this.photoName,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    id: json["id"],
    photoName: json["photoName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "photoName": photoName,
  };
}
