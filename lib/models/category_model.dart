// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_tagging/flutter_tagging.dart';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  List<JobCategory> jobCategory;
  String response;
  String status;

  CategoryModel({
    this.jobCategory,
    this.response,
    this.status,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    jobCategory: json["job_category"] == null ? null : List<JobCategory>.from(json["job_category"].map((x) => JobCategory.fromJson(x))),
    response: json["response"] == null ? null : json["response"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "job_category": jobCategory == null ? null : List<dynamic>.from(jobCategory.map((x) => x.toJson())),
    "response": response == null ? null : response,
    "status": status == null ? null : status,
  };
}

class JobCategory extends Taggable {
  String jobName;
  String refJobCategoryId;
  String jobCategoryImage;
  String total;

  JobCategory({
    this.jobName,
    this.refJobCategoryId,
    this.jobCategoryImage,
    this.total,
  });

  factory JobCategory.fromJson(Map<String, dynamic> json) => JobCategory(
    jobName: json["job_name"] == null ? null : json["job_name"],
    refJobCategoryId: json["ref_job_category_id"] == null ? null : json["ref_job_category_id"],
    jobCategoryImage: json["job_category_image"] == null ? null : json["job_category_image"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "job_name": jobName == null ? null : jobName,
    "ref_job_category_id": refJobCategoryId == null ? null : refJobCategoryId,
    "job_category_image": jobCategoryImage == null ? null : jobCategoryImage,
    "total": total == null ? null : total,
  };

  @override
  List<Object> get props => [
    jobName,
    refJobCategoryId,
    jobCategoryImage,
    total,
  ];
}
