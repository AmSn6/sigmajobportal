// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  String status;
  String message;
  Result result;

  LoginResponseModel({
    this.status,
    this.message,
    this.result,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "result": result == null ? null : result.toJson(),
  };
}

class Result {
  String candidateId;
  String candidateName;

  Result({
    this.candidateId,
    this.candidateName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    candidateId: json["candidate_id"] == null ? null : json["candidate_id"],
    candidateName: json["candidate_name"] == null ? null : json["candidate_name"],
  );

  Map<String, dynamic> toJson() => {
    "candidate_id": candidateId == null ? null : candidateId,
    "candidate_name": candidateName == null ? null : candidateName,
  };
}
