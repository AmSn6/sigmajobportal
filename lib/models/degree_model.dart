// To parse this JSON data, do
//
//     final degreeModel = degreeModelFromJson(jsonString);

import 'dart:convert';

DegreeModel degreeModelFromJson(String str) => DegreeModel.fromJson(json.decode(str));

String degreeModelToJson(DegreeModel data) => json.encode(data.toJson());

class DegreeModel {
  List<Degree> degree;

  DegreeModel({
    this.degree,
  });

  factory DegreeModel.fromJson(Map<String, dynamic> json) => DegreeModel(
    degree: json["degree"] == null ? null : List<Degree>.from(json["degree"].map((x) => Degree.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "degree": degree == null ? null : List<dynamic>.from(degree.map((x) => x.toJson())),
  };
}

class Degree {
  String degreeName;
  String degreeId;

  Degree({
    this.degreeName,
    this.degreeId,
  });

  factory Degree.fromJson(Map<String, dynamic> json) => Degree(
    degreeName: json["degree_name"] == null ? null : json["degree_name"],
    degreeId: json["degree_id"] == null ? null : json["degree_id"],
  );

  Map<String, dynamic> toJson() => {
    "degree_name": degreeName == null ? null : degreeName,
    "degree_id": degreeId == null ? null : degreeId,
  };
}
