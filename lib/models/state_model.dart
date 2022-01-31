// To parse this JSON data, do
//
//     final stateModel = stateModelFromJson(jsonString);

import 'dart:convert';

StateModel stateModelFromJson(String str) => StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  List<StateList> stateList;

  StateModel({
    this.stateList,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    stateList: json["state_list"] == null ? null : List<StateList>.from(json["state_list"].map((x) => StateList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "state_list": stateList == null ? null : List<dynamic>.from(stateList.map((x) => x.toJson())),
  };
}

class StateList {
  String stateId;
  String countryId;
  String stateName;
  String code;
  String status;
  String deleteStatus;
  String userId;
  String transactionId;
  String addedDate;

  StateList({
    this.stateId,
    this.countryId,
    this.stateName,
    this.code,
    this.status,
    this.deleteStatus,
    this.userId,
    this.transactionId,
    this.addedDate,
  });

  factory StateList.fromJson(Map<String, dynamic> json) => StateList(
    stateId: json["state_id"] == null ? null : json["state_id"],
    countryId: json["country_id"] == null ? null : json["country_id"],
    stateName: json["state_name"] == null ? null : json["state_name"],
    code: json["code"] == null ? null : json["code"],
    status: json["status"] == null ? null : json["status"],
    deleteStatus: json["delete_status"] == null ? null : json["delete_status"],
    userId: json["user_id"] == null ? null : json["user_id"],
    transactionId: json["transaction_id"] == null ? null : json["transaction_id"],
    addedDate: json["added_date"] == null ? null : json["added_date"],
  );

  Map<String, dynamic> toJson() => {
    "state_id": stateId == null ? null : stateId,
    "country_id": countryId == null ? null : countryId,
    "state_name": stateName == null ? null : stateName,
    "code": code == null ? null : code,
    "status": status == null ? null : status,
    "delete_status": deleteStatus == null ? null : deleteStatus,
    "user_id": userId == null ? null : userId,
    "transaction_id": transactionId == null ? null : transactionId,
    "added_date": addedDate == null ? null : addedDate,
  };
}
