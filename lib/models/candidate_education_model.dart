// To parse this JSON data, do
//
//     final candidateEducationModel = candidateEducationModelFromJson(jsonString);

import 'dart:convert';

CandidateEducationModel candidateEducationModelFromJson(String str) => CandidateEducationModel.fromJson(json.decode(str));

String candidateEducationModelToJson(CandidateEducationModel data) => json.encode(data.toJson());

class CandidateEducationModel {
  List<Graduation> graduation;
  List<YearOfPassing> yearOfPassing;
  String response;
  String status;

  CandidateEducationModel({
    this.graduation,
    this.yearOfPassing,
    this.response,
    this.status,
  });

  factory CandidateEducationModel.fromJson(Map<String, dynamic> json) => CandidateEducationModel(
    graduation: json["graduation"] == null ? null : List<Graduation>.from(json["graduation"].map((x) => Graduation.fromJson(x))),
    yearOfPassing: json["year_of_passing"] == null ? null : List<YearOfPassing>.from(json["year_of_passing"].map((x) => YearOfPassing.fromJson(x))),
    response: json["response"] == null ? null : json["response"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "graduation": graduation == null ? null : List<dynamic>.from(graduation.map((x) => x.toJson())),
    "year_of_passing": yearOfPassing == null ? null : List<dynamic>.from(yearOfPassing.map((x) => x.toJson())),
    "response": response == null ? null : response,
    "status": status == null ? null : status,
  };
}

class Graduation {
  String graduationTypeId;
  String graduationTypeName;

  Graduation({
    this.graduationTypeId,
    this.graduationTypeName,
  });

  factory Graduation.fromJson(Map<String, dynamic> json) => Graduation(
    graduationTypeId: json["graduation_type_id"] == null ? null : json["graduation_type_id"],
    graduationTypeName: json["graduation_type_name"] == null ? null : json["graduation_type_name"],
  );

  Map<String, dynamic> toJson() => {
    "graduation_type_id": graduationTypeId == null ? null : graduationTypeId,
    "graduation_type_name": graduationTypeName == null ? null : graduationTypeName,
  };
}

class YearOfPassing {
  String yearOfPassingId;
  String yearOfPassingName;

  YearOfPassing({
    this.yearOfPassingId,
    this.yearOfPassingName,
  });

  factory YearOfPassing.fromJson(Map<String, dynamic> json) => YearOfPassing(
    yearOfPassingId: json["year_of_passing_id"] == null ? null : json["year_of_passing_id"],
    yearOfPassingName: json["year_of_passing_name"] == null ? null : json["year_of_passing_name"],
  );

  Map<String, dynamic> toJson() => {
    "year_of_passing_id": yearOfPassingId == null ? null : yearOfPassingId,
    "year_of_passing_name": yearOfPassingName == null ? null : yearOfPassingName,
  };
}
