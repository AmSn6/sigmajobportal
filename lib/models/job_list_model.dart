// To parse this JSON data, do
//
//     final jobListModel = jobListModelFromJson(jsonString);

import 'dart:convert';

JobListModel jobListModelFromJson(String str) => JobListModel.fromJson(json.decode(str));

String jobListModelToJson(JobListModel data) => json.encode(data.toJson());

class JobListModel {
  List<JobList> jobList;
  String response;
  String status;

  JobListModel({
    this.jobList,
    this.response,
    this.status,
  });

  factory JobListModel.fromJson(Map<String, dynamic> json) => JobListModel(
    jobList: json["job_list"] == false || json["job_list"] == null ? [] : List<JobList>.from(json["job_list"].map((x) => JobList.fromJson(x))),
    response: json["response"] == null ? null : json["response"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "job_list": jobList == null ? null : List<dynamic>.from(jobList.map((x) => x.toJson())),
    "response": response == null ? null : response,
    "status": status == null ? null : status,
  };
}

class JobList {
  String jobCategoryName;
  String jobName;
  String jobId;
  DateTime jobPostedDate;
  String jobExperienceYearFrom;
  String jobExperienceYearTo;
  String employerId;
  String employerName;
  String employerImage;
  String jobLocationId;
  String jobLocationName;
  List<String> keySkillsName;

  JobList({
    this.jobCategoryName,
    this.jobName,
    this.jobId,
    this.jobPostedDate,
    this.jobExperienceYearFrom,
    this.jobExperienceYearTo,
    this.employerId,
    this.employerName,
    this.employerImage,
    this.jobLocationId,
    this.jobLocationName,
    this.keySkillsName,
  });

  factory JobList.fromJson(Map<String, dynamic> json) => JobList(
    jobCategoryName: json["job_category_name"] == null ? null : json["job_category_name"],
    jobName: json["job_name"] == null ? null : json["job_name"],
    jobId: json["job_id"] == null ? null : json["job_id"],
    jobPostedDate: json["job_posted_date"] == null ? null : DateTime.parse(json["job_posted_date"]),
    jobExperienceYearFrom: json["job_experience_year_from"] == null ? null : json["job_experience_year_from"],
    jobExperienceYearTo: json["job_experience_year_to"] == null ? null : json["job_experience_year_to"],
    employerId: json["employer_id"] == null ? null : json["employer_id"],
    employerName: json["employer_name"] == null ? null : json["employer_name"],
    employerImage: json["employer_image"] == null ? '-' : json["employer_image"],
    jobLocationId: json["job_location_id"] == null ? null : json["job_location_id"],
    jobLocationName: json["job_location_name"] == null ? null : json["job_location_name"],
    keySkillsName: json["key_skills_name"] == null || json["key_skills_name"] == '' ? [] : json["key_skills_name"].toString().substring(0, json["key_skills_name"].toString().length -1).split(',').toList(),
  );

  Map<String, dynamic> toJson() => {
    "job_category_name": jobCategoryName == null ? null : jobCategoryName,
    "job_name": jobName == null ? null : jobName,
    "job_id": jobId == null ? null : jobId,
    "job_posted_date": jobPostedDate == null ? null : "${jobPostedDate.year.toString().padLeft(4, '0')}-${jobPostedDate.month.toString().padLeft(2, '0')}-${jobPostedDate.day.toString().padLeft(2, '0')}",
    "job_experience_year_from": jobExperienceYearFrom == null ? null : jobExperienceYearFrom,
    "job_experience_year_to": jobExperienceYearTo == null ? null : jobExperienceYearTo,
    "employer_id": employerId == null ? null : employerId,
    "employer_name": employerName == null ? null : employerName,
    "employer_image": employerImage == null ? null : employerImage,
    "job_location_id": jobLocationId,
    "job_location_name": jobLocationName,
  };
}
