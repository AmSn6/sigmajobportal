// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_tagging/flutter_tagging.dart';

LocationModel locationModelFromJson(String str) =>
    LocationModel.fromJson(json.decode(str));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  List<Location> location;
  String response;
  String status;

  LocationModel({
    this.location,
    this.response,
    this.status,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        location: json["location"] == null
            ? null
            : List<Location>.from(
                json["location"].map((x) => Location.fromJson(x))),
        response: json["response"] == null ? null : json["response"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "location": location == null
            ? null
            : List<dynamic>.from(location.map((x) => x.toJson())),
        "response": response == null ? null : response,
        "status": status == null ? null : status,
      };
}

class Location extends Taggable {
  String jobLocationId;
  String jobLocationName;

  Location({
    this.jobLocationId,
    this.jobLocationName,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        jobLocationId:
            json["job_location_id"] == null ? null : json["job_location_id"],
        jobLocationName: json["job_location_name"] == null
            ? null
            : json["job_location_name"],
      );

  Map<String, dynamic> toJson() => {
        "job_location_id": jobLocationId == null ? null : jobLocationId,
        "job_location_name": jobLocationName == null ? null : jobLocationName,
      };

  @override
  List<Object> get props => [jobLocationId, jobLocationName];
}
