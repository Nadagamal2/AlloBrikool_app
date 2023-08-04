// To parse this JSON data, do
//
//     final termsAndConditionsModel = termsAndConditionsModelFromJson(jsonString);

import 'dart:convert';

List<TermsAndConditionsModel> termsAndConditionsModelFromJson(String str) => List<TermsAndConditionsModel>.from(json.decode(str).map((x) => TermsAndConditionsModel.fromJson(x)));

String termsAndConditionsModelToJson(List<TermsAndConditionsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TermsAndConditionsModel {
  int id;
  String details;

  TermsAndConditionsModel({
    required this.id,
    required this.details,
  });

  factory TermsAndConditionsModel.fromJson(Map<String, dynamic> json) => TermsAndConditionsModel(
    id: json["id"],
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "details": details,
  };
}
