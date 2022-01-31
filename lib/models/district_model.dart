// To parse this JSON data, do
//
//     final districtModel = districtModelFromJson(jsonString);

import 'dart:convert';

DistrictModel districtModelFromJson(String str) => DistrictModel.fromJson(json.decode(str));

String districtModelToJson(DistrictModel data) => json.encode(data.toJson());

class DistrictModel {
  List<District> district;
  String response;
  String status;

  DistrictModel({
    this.district,
    this.response,
    this.status,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
    district: json["district"] == null ? null : List<District>.from(json["district"].map((x) => District.fromJson(x))),
    response: json["response"] == null ? null : json["response"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "district": district == null ? null : List<dynamic>.from(district.map((x) => x.toJson())),
    "response": response == null ? null : response,
    "status": status == null ? null : status,
  };
}

class District {
  String districtId;
  String districtName;
  String refStateId;
  String deleteStatus;
  String userId;
  String transactionId;
  String addedDate;

  District({
    this.districtId,
    this.districtName,
    this.refStateId,
    this.deleteStatus,
    this.userId,
    this.transactionId,
    this.addedDate,
  });

  factory District.fromJson(Map<String, dynamic> json) => District(
    districtId: json["district_id"] == null ? null : json["district_id"],
    districtName: json["district_name"] == null ? null : json["district_name"],
    refStateId: json["ref_state_id"] == null ? null : json["ref_state_id"],
    deleteStatus: json["delete_status"] == null ? null : json["delete_status"],
    userId: json["user_id"] == null ? null : json["user_id"],
    transactionId: json["transaction_id"] == null ? null : json["transaction_id"],
    addedDate: json["added_date"] == null ? null : json["added_date"],
  );

  Map<String, dynamic> toJson() => {
    "district_id": districtId == null ? null : districtId,
    "district_name": districtName == null ? null : districtName,
    "ref_state_id": refStateId == null ? null : refStateId,
    "delete_status": deleteStatus == null ? null : deleteStatus,
    "user_id": userId == null ? null : userId,
    "transaction_id": transactionId == null ? null : transactionId,
    "added_date": addedDate == null ? null : addedDate,
  };
}
