// To parse this JSON data, do
//
//     final candidatePersonalModel = candidatePersonalModelFromJson(jsonString);

import 'dart:convert';

CandidatePersonalModel candidatePersonalModelFromJson(String str) => CandidatePersonalModel.fromJson(json.decode(str));

String candidatePersonalModelToJson(CandidatePersonalModel data) => json.encode(data.toJson());

class CandidatePersonalModel {
  List<MaritalStatus> maritalStatus;
  List<Salutation> salutation;
  List<Industry> industry;
  List<Category> category;
  List<HearAboutUs> hearAboutUs;
  List<State> state;
  String response;
  String status;

  CandidatePersonalModel({
    this.maritalStatus,
    this.salutation,
    this.industry,
    this.category,
    this.hearAboutUs,
    this.state,
    this.response,
    this.status,
  });

  factory CandidatePersonalModel.fromJson(Map<String, dynamic> json) => CandidatePersonalModel(
    maritalStatus: json["marital_status"] == null ? null : List<MaritalStatus>.from(json["marital_status"].map((x) => MaritalStatus.fromJson(x))),
    salutation: json["salutation"] == null ? null : List<Salutation>.from(json["salutation"].map((x) => Salutation.fromJson(x))),
    industry: json["industry"] == null ? null : List<Industry>.from(json["industry"].map((x) => Industry.fromJson(x))),
    category: json["category"] == null ? null : List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    hearAboutUs: json["hear_about_us"] == null ? null : List<HearAboutUs>.from(json["hear_about_us"].map((x) => HearAboutUs.fromJson(x))),
    state: json["state"] == null ? null : List<State>.from(json["state"].map((x) => State.fromJson(x))),
    response: json["response"] == null ? null : json["response"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "marital_status": maritalStatus == null ? null : List<dynamic>.from(maritalStatus.map((x) => x.toJson())),
    "salutation": salutation == null ? null : List<dynamic>.from(salutation.map((x) => x.toJson())),
    "industry": industry == null ? null : List<dynamic>.from(industry.map((x) => x.toJson())),
    "category": category == null ? null : List<dynamic>.from(category.map((x) => x.toJson())),
    "hear_about_us": hearAboutUs == null ? null : List<dynamic>.from(hearAboutUs.map((x) => x.toJson())),
    "state": state == null ? null : List<dynamic>.from(state.map((x) => x.toJson())),
    "response": response == null ? null : response,
    "status": status == null ? null : status,
  };
}

class Category {
  String jobCategoryId;
  String jobCategoryName;

  Category({
    this.jobCategoryId,
    this.jobCategoryName,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    jobCategoryId: json["job_category_id"] == null ? null : json["job_category_id"],
    jobCategoryName: json["job_category_name"] == null ? null : json["job_category_name"],
  );

  Map<String, dynamic> toJson() => {
    "job_category_id": jobCategoryId == null ? null : jobCategoryId,
    "job_category_name": jobCategoryName == null ? null : jobCategoryName,
  };
}

class HearAboutUs {
  String hearAboutUsId;
  String hearAboutUsName;

  HearAboutUs({
    this.hearAboutUsId,
    this.hearAboutUsName,
  });

  factory HearAboutUs.fromJson(Map<String, dynamic> json) => HearAboutUs(
    hearAboutUsId: json["hear_about_us_id"] == null ? null : json["hear_about_us_id"],
    hearAboutUsName: json["hear_about_us_name"] == null ? null : json["hear_about_us_name"],
  );

  Map<String, dynamic> toJson() => {
    "hear_about_us_id": hearAboutUsId == null ? null : hearAboutUsId,
    "hear_about_us_name": hearAboutUsName == null ? null : hearAboutUsName,
  };
}

class Industry {
  String jobIndustryId;
  String jobIndustryName;

  Industry({
    this.jobIndustryId,
    this.jobIndustryName,
  });

  factory Industry.fromJson(Map<String, dynamic> json) => Industry(
    jobIndustryId: json["job_industry_id"] == null ? null : json["job_industry_id"],
    jobIndustryName: json["job_industry_name"] == null ? null : json["job_industry_name"],
  );

  Map<String, dynamic> toJson() => {
    "job_industry_id": jobIndustryId == null ? null : jobIndustryId,
    "job_industry_name": jobIndustryName == null ? null : jobIndustryName,
  };
}

class MaritalStatus {
  String maritalStatusId;
  String maritalStatusName;

  MaritalStatus({
    this.maritalStatusId,
    this.maritalStatusName,
  });

  factory MaritalStatus.fromJson(Map<String, dynamic> json) => MaritalStatus(
    maritalStatusId: json["marital_status_id"] == null ? null : json["marital_status_id"],
    maritalStatusName: json["marital_status_name"] == null ? null : json["marital_status_name"],
  );

  Map<String, dynamic> toJson() => {
    "marital_status_id": maritalStatusId == null ? null : maritalStatusId,
    "marital_status_name": maritalStatusName == null ? null : maritalStatusName,
  };
}

class Salutation {
  String salutationId;
  String salutationName;

  Salutation({
    this.salutationId,
    this.salutationName,
  });

  factory Salutation.fromJson(Map<String, dynamic> json) => Salutation(
    salutationId: json["salutation_id"] == null ? null : json["salutation_id"],
    salutationName: json["salutation_name"] == null ? null : json["salutation_name"],
  );

  Map<String, dynamic> toJson() => {
    "salutation_id": salutationId == null ? null : salutationId,
    "salutation_name": salutationName == null ? null : salutationName,
  };
}

class State {
  String stateId;
  String countryId;
  String stateName;
  String code;
  String status;
  String deleteStatus;
  String userId;
  String transactionId;
  String addedDate;

  State({
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

  factory State.fromJson(Map<String, dynamic> json) => State(
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
