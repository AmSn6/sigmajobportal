// To parse this JSON data, do
//
//     final skillsModel = skillsModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_tagging/flutter_tagging.dart';

SkillsModel skillsModelFromJson(String str) => SkillsModel.fromJson(json.decode(str));

String skillsModelToJson(SkillsModel data) => json.encode(data.toJson());

class SkillsModel {
  List<Skill> skills;
  String response;
  String status;

  SkillsModel({
    this.skills,
    this.response,
    this.status,
  });

  factory SkillsModel.fromJson(Map<String, dynamic> json) => SkillsModel(
    skills: json["skills"] == null ? null : List<Skill>.from(json["skills"].map((x) => Skill.fromJson(x))),
    response: json["response"] == null ? null : json["response"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "skills": skills == null ? null : List<dynamic>.from(skills.map((x) => x.toJson())),
    "response": response == null ? null : response,
    "status": status == null ? null : status,
  };
}

class Skill extends Taggable {
  String id;
  String name;

  Skill({
    this.id,
    this.name,
  });

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
    id: json["key_skills_id"] == null ? null : json["key_skills_id"],
    name: json["key_skills_name"] == null ? null : json["key_skills_name"],
  );

  Map<String, dynamic> toJson() => {
    "key_skills_id": id == null ? null : id,
    "key_skills_name": name == null ? null : name,
  };

  @override
  List<Object> get props =>[
    id,
    name
  ];
}
