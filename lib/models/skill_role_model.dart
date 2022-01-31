// To parse this JSON data, do
//
//     final skillRoleModel = skillRoleModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_tagging/flutter_tagging.dart';

SkillRoleModel skillRoleModelFromJson(String str) => SkillRoleModel.fromJson(json.decode(str));

String skillRoleModelToJson(SkillRoleModel data) => json.encode(data.toJson());

class SkillRoleModel {
  List<Role> role;
  String response;
  String status;

  SkillRoleModel({
    this.role,
    this.response,
    this.status,
  });

  factory SkillRoleModel.fromJson(Map<String, dynamic> json) => SkillRoleModel(
    role: json["role"] == null ? null : List<Role>.from(json["role"].map((x) => Role.fromJson(x))),
    response: json["response"] == null ? null : json["response"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "role": role == null ? null : List<dynamic>.from(role.map((x) => x.toJson())),
    "response": response == null ? null : response,
    "status": status == null ? null : status,
  };
}

class Role extends Taggable {
  String id;
  String name;

  Role({
    this.id,
    this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["role_id"] == null ? null : json["role_id"],
    name: json["role_name"] == null ? null : json["role_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };

  @override
  List<Object> get props => [
    id,
    name
  ];
}
