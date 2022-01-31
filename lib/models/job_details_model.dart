// To parse this JSON data, do
//
//     final jobDetailsModel = jobDetailsModelFromJson(jsonString);

import 'dart:convert';

JobDetailsModel jobDetailsModelFromJson(String str) => JobDetailsModel.fromJson(json.decode(str));

String jobDetailsModelToJson(JobDetailsModel data) => json.encode(data.toJson());

class JobDetailsModel {
  List<JobDetail> jobDetails;
  String response;
  String status;

  JobDetailsModel({
    this.jobDetails,
    this.response,
    this.status,
  });

  factory JobDetailsModel.fromJson(Map<String, dynamic> json) => JobDetailsModel(
    jobDetails: json["job_details"] == null ? null : List<JobDetail>.from(json["job_details"].map((x) => JobDetail.fromJson(x))),
    response: json["response"] == null ? null : json["response"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "job_details": jobDetails == null ? null : List<dynamic>.from(jobDetails.map((x) => x.toJson())),
    "response": response == null ? null : response,
    "status": status == null ? null : status,
  };
}

class JobDetail {
  String jobId;
  String refEmployerId;
  String jobName;
  String jobVacancy;
  String refJobIndustryId;
  String refJobCategoryId;
  String refJobRoleId;
  String refJobTypeId;
  String jobDescription;
  String jobKeySkills;
  String jobPreferredLocation;
  String jobExperienceYearFrom;
  String jobExperienceYearTo;
  String jobSalaryLakhsFrom;
  String jobSalaryLakhsTo;
  String jobContactPerson;
  String jobContactPersonNumber;
  DateTime jobInterviewDateFrom;
  DateTime jobInterviewDateTo;
  String jobDesiredCandidateProfile;
  String jobEmployerProfile;
  DateTime jobPostedDate;
  String refStatusId;
  String refUserId;
  String deleteStatus;
  String transactionId;
  DateTime addedDate;
  String employerName;
  String jobIndustryName;
  String jobCategoryName;
  String jobRoleName;
  String jobTypeName;
  String statusName;
  String userName;

  JobDetail({
    this.jobId,
    this.refEmployerId,
    this.jobName,
    this.jobVacancy,
    this.refJobIndustryId,
    this.refJobCategoryId,
    this.refJobRoleId,
    this.refJobTypeId,
    this.jobDescription,
    this.jobKeySkills,
    this.jobPreferredLocation,
    this.jobExperienceYearFrom,
    this.jobExperienceYearTo,
    this.jobSalaryLakhsFrom,
    this.jobSalaryLakhsTo,
    this.jobContactPerson,
    this.jobContactPersonNumber,
    this.jobInterviewDateFrom,
    this.jobInterviewDateTo,
    this.jobDesiredCandidateProfile,
    this.jobEmployerProfile,
    this.jobPostedDate,
    this.refStatusId,
    this.refUserId,
    this.deleteStatus,
    this.transactionId,
    this.addedDate,
    this.employerName,
    this.jobIndustryName,
    this.jobCategoryName,
    this.jobRoleName,
    this.jobTypeName,
    this.statusName,
    this.userName,
  });

  factory JobDetail.fromJson(Map<String, dynamic> json) => JobDetail(
    jobId: json["job_id"] == null ? '-' : json["job_id"],
    refEmployerId: json["ref_employer_id"] == null ? '-' : json["ref_employer_id"],
    jobName: json["job_name"] == null ? '-' : json["job_name"],
    jobVacancy: json["job_vacancy"] == null ? '-' : json["job_vacancy"],
    refJobIndustryId: json["ref_job_industry_id"] == null ? '-' : json["ref_job_industry_id"],
    refJobCategoryId: json["ref_job_category_id"] == null ? '-' : json["ref_job_category_id"],
    refJobRoleId: json["ref_job_role_id"] == null ? '-' : json["ref_job_role_id"],
    refJobTypeId: json["ref_job_type_id"] == null ? '-' : json["ref_job_type_id"],
    jobDescription: json["job_description"] == null ? '-' : json["job_description"],
    jobKeySkills: json["job_key_skills"] == null ? '-' : json["job_key_skills"],
    jobPreferredLocation: json["job_preferred_location"] == null ? '-' : json["job_preferred_location"],
    jobExperienceYearFrom: json["job_experience_year_from"] == null ? '-' : json["job_experience_year_from"],
    jobExperienceYearTo: json["job_experience_year_to"] == null ? '-' : json["job_experience_year_to"],
    jobSalaryLakhsFrom: json["job_salary_lakhs_from"] == null ? '-' : json["job_salary_lakhs_from"],
    jobSalaryLakhsTo: json["job_salary_lakhs_to"] == null ? '-' : json["job_salary_lakhs_to"],
    jobContactPerson: json["job_contact_person"] == null ? '-' : json["job_contact_person"],
    jobContactPersonNumber: json["job_contact_person_number"] == null ? '-' : json["job_contact_person_number"],
    jobInterviewDateFrom: json["job_interview_date_from"] == null ? '-' : DateTime.parse(json["job_interview_date_from"]),
    jobInterviewDateTo: json["job_interview_date_to"] == null ? '-' : DateTime.parse(json["job_interview_date_to"]),
    jobDesiredCandidateProfile: json["job_desired_candidate_profile"] == null ? '-' : json["job_desired_candidate_profile"],
    jobEmployerProfile: json["job_employer_profile"] == null ? '-' : json["job_employer_profile"],
    jobPostedDate: json["job_posted_date"] == null ? '-' : DateTime.parse(json["job_posted_date"]),
    refStatusId: json["ref_status_id"] == null ? '-' : json["ref_status_id"],
    refUserId: json["ref_user_id"] == null ? '-' : json["ref_user_id"],
    deleteStatus: json["delete_status"] == null ? '-' : json["delete_status"],
    transactionId: json["transaction_id"] == null ? '-' : json["transaction_id"],
    addedDate: json["added_date"] == null ? '-' : DateTime.parse(json["added_date"]),
    employerName: json["employer_name"] == null ? '-' : json["employer_name"],
    jobIndustryName: json["job_industry_name"] == null ? '-' : json["job_industry_name"],
    jobCategoryName: json["job_category_name"] == null ? '-' : json["job_category_name"],
    jobRoleName: json["job_role_name"] == null ? '-' : json["job_role_name"],
    jobTypeName: json["job_type_name"] == null ? '-' : json["job_type_name"],
    statusName: json["status_name"] == null ? '-' : json["status_name"],
    userName: json["user_name"] == null ? '-' : json["user_name"],
  );

  Map<String, dynamic> toJson() => {
    "job_id": jobId == null ? null : jobId,
    "ref_employer_id": refEmployerId == null ? null : refEmployerId,
    "job_name": jobName == null ? null : jobName,
    "job_vacancy": jobVacancy == null ? null : jobVacancy,
    "ref_job_industry_id": refJobIndustryId == null ? null : refJobIndustryId,
    "ref_job_category_id": refJobCategoryId == null ? null : refJobCategoryId,
    "ref_job_role_id": refJobRoleId == null ? null : refJobRoleId,
    "ref_job_type_id": refJobTypeId == null ? null : refJobTypeId,
    "job_description": jobDescription == null ? null : jobDescription,
    "job_key_skills": jobKeySkills == null ? null : jobKeySkills,
    "job_preferred_location": jobPreferredLocation == null ? null : jobPreferredLocation,
    "job_experience_year_from": jobExperienceYearFrom == null ? null : jobExperienceYearFrom,
    "job_experience_year_to": jobExperienceYearTo == null ? null : jobExperienceYearTo,
    "job_salary_lakhs_from": jobSalaryLakhsFrom == null ? null : jobSalaryLakhsFrom,
    "job_salary_lakhs_to": jobSalaryLakhsTo == null ? null : jobSalaryLakhsTo,
    "job_contact_person": jobContactPerson == null ? null : jobContactPerson,
    "job_contact_person_number": jobContactPersonNumber == null ? null : jobContactPersonNumber,
    "job_interview_date_from": jobInterviewDateFrom == null ? null : jobInterviewDateFrom.toIso8601String(),
    "job_interview_date_to": jobInterviewDateTo == null ? null : jobInterviewDateTo.toIso8601String(),
    "job_desired_candidate_profile": jobDesiredCandidateProfile == null ? null : jobDesiredCandidateProfile,
    "job_employer_profile": jobEmployerProfile == null ? null : jobEmployerProfile,
    "job_posted_date": jobPostedDate == null ? null : "${jobPostedDate.year.toString().padLeft(4, '0')}-${jobPostedDate.month.toString().padLeft(2, '0')}-${jobPostedDate.day.toString().padLeft(2, '0')}",
    "ref_status_id": refStatusId == null ? null : refStatusId,
    "ref_user_id": refUserId == null ? null : refUserId,
    "delete_status": deleteStatus == null ? null : deleteStatus,
    "transaction_id": transactionId == null ? null : transactionId,
    "added_date": addedDate == null ? null : addedDate.toIso8601String(),
    "employer_name": employerName == null ? null : employerName,
    "job_industry_name": jobIndustryName == null ? null : jobIndustryName,
    "job_category_name": jobCategoryName == null ? null : jobCategoryName,
    "job_role_name": jobRoleName == null ? null : jobRoleName,
    "job_type_name": jobTypeName == null ? null : jobTypeName,
    "status_name": statusName == null ? null : statusName,
    "user_name": userName == null ? null : userName,
  };
}
