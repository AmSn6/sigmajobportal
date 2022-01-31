// To parse this JSON data, do
//
//     final commonResponseModel = commonResponseModelFromJson(jsonString);

import 'dart:convert';

CommonResponseModel commonResponseModelFromJson(String str) => CommonResponseModel.fromJson(json.decode(str));

String commonResponseModelToJson(CommonResponseModel data) => json.encode(data.toJson());

class CommonResponseModel {
  String status;
  String response;

  CommonResponseModel({
    this.status,
    this.response,
  });

  factory CommonResponseModel.fromJson(Map<String, dynamic> json) => CommonResponseModel(
    status: json["status"] == null ? null : json["status"],
    response: json["response"] == null ? null : json["response"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "response": response == null ? null : response,
  };
}
