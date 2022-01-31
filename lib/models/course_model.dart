// To parse this JSON data, do
//
//     final courseModel = courseModelFromJson(jsonString);

import 'dart:convert';

CourseModel courseModelFromJson(String str) => CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {
  List<Course> course;
  String response;
  String status;

  CourseModel({
    this.course,
    this.response,
    this.status,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
    course: json["course"] == null ? null : List<Course>.from(json["course"].map((x) => Course.fromJson(x))),
    response: json["response"] == null ? null : json["response"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "course": course == null ? null : List<dynamic>.from(course.map((x) => x.toJson())),
    "response": response == null ? null : response,
    "status": status == null ? null : status,
  };
}

class Course {
  String specializationId;
  String specializationName;

  Course({
    this.specializationId,
    this.specializationName,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    specializationId: json["specialization_id"] == null ? null : json["specialization_id"],
    specializationName: json["specialization_name"] == null ? null : json["specialization_name"],
  );

  Map<String, dynamic> toJson() => {
    "specialization_id": specializationId == null ? null : specializationId,
    "specialization_name": specializationName == null ? null : specializationName,
  };
}
