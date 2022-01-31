// To parse this JSON data, do
//
//     final skillIndustryModel = skillIndustryModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_tagging/flutter_tagging.dart';

SkillIndustryModel skillIndustryModelFromJson(String str) => SkillIndustryModel.fromJson(json.decode(str));

String skillIndustryModelToJson(SkillIndustryModel data) => json.encode(data.toJson());

class SkillIndustryModel {
  List<Industry> industry;
  String response;
  String status;

  SkillIndustryModel({
    this.industry,
    this.response,
    this.status,
  });

  factory SkillIndustryModel.fromJson(Map<String, dynamic> json) => SkillIndustryModel(
    industry: json["industry"] == null ? null : List<Industry>.from(json["industry"].map((x) => Industry.fromJson(x))),
    response: json["response"] == null ? null : json["response"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "industry": industry == null ? null : List<dynamic>.from(industry.map((x) => x.toJson())),
    "response": response == null ? null : response,
    "status": status == null ? null : status,
  };
}

class Industry extends Taggable {
  String jobIndustryId;
  String jobIndustryName;

  Industry({
    this.jobIndustryId,
    this.jobIndustryName,
  });

  factory Industry.fromJson(Map<String, dynamic> json) => Industry(
    jobIndustryId: json["job_industry_id"] == null ? null : json["job_industry_id"],
    jobIndustryName: json["job_industry_name"] == null ? null : json["job_industry_name"],
  );

  Map<String, dynamic> toJson() => {
    "job_industry_id": jobIndustryId == null ? null : jobIndustryId,
    "job_industry_name": jobIndustryName == null ? null : jobIndustryName,
  };

  @override
  List<Object> get props => [
    jobIndustryId,
    jobIndustryName
  ];
}
