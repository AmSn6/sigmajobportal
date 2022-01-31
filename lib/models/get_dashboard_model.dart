// To parse this JSON data, do
//
//     final getDashboardModel = getDashboardModelFromJson(jsonString);

import 'dart:convert';

GetDashboardModel getDashboardModelFromJson(String str) => GetDashboardModel.fromJson(json.decode(str));

String getDashboardModelToJson(GetDashboardModel data) => json.encode(data.toJson());

class GetDashboardModel {
  List<Salary> salary;
  List<Experience> experience;
  List<EmpStatus> empStatus;
  List<Industry> industry;
  List<Category> category;
  List<JobType> jobType;
  List<Month> months;
  List<Thousand> thousands;
  String response;
  String status;

  GetDashboardModel({
    this.salary,
    this.experience,
    this.empStatus,
    this.industry,
    this.category,
    this.jobType,
    this.months,
    this.thousands,
    this.response,
    this.status,
  });

  factory GetDashboardModel.fromJson(Map<String, dynamic> json) => GetDashboardModel(
    salary: json["salary"] == null ? null : List<Salary>.from(json["salary"].map((x) => Salary.fromJson(x))),
    experience: json["experience"] == null ? null : List<Experience>.from(json["experience"].map((x) => Experience.fromJson(x))),
    empStatus: json["emp_status"] == null ? null : List<EmpStatus>.from(json["emp_status"].map((x) => EmpStatus.fromJson(x))),
    industry: json["industry"] == null ? null : List<Industry>.from(json["industry"].map((x) => Industry.fromJson(x))),
    category: json["category"] == null ? null : List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    jobType: json["job_type"] == null ? null : List<JobType>.from(json["job_type"].map((x) => JobType.fromJson(x))),
    months: json["months"] == null ? null : List<Month>.from(json["months"].map((x) => Month.fromJson(x))),
    thousands: json["thousands"] == null ? null : List<Thousand>.from(json["thousands"].map((x) => Thousand.fromJson(x))),
    response: json["response"] == null ? null : json["response"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "salary": salary == null ? null : List<dynamic>.from(salary.map((x) => x.toJson())),
    "experience": experience == null ? null : List<dynamic>.from(experience.map((x) => x.toJson())),
    "emp_status": empStatus == null ? null : List<dynamic>.from(empStatus.map((x) => x.toJson())),
    "industry": industry == null ? null : List<dynamic>.from(industry.map((x) => x.toJson())),
    "category": category == null ? null : List<dynamic>.from(category.map((x) => x.toJson())),
    "job_type": jobType == null ? null : List<dynamic>.from(jobType.map((x) => x.toJson())),
    "months": months == null ? null : List<dynamic>.from(months.map((x) => x.toJson())),
    "thousands": thousands == null ? null : List<dynamic>.from(thousands.map((x) => x.toJson())),
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

class EmpStatus {
  String statusId;
  String statusName;

  EmpStatus({
    this.statusId,
    this.statusName,
  });

  factory EmpStatus.fromJson(Map<String, dynamic> json) => EmpStatus(
    statusId: json["status_id"] == null ? null : json["status_id"],
    statusName: json["status_name"] == null ? null : json["status_name"],
  );

  Map<String, dynamic> toJson() => {
    "status_id": statusId == null ? null : statusId,
    "status_name": statusName == null ? null : statusName,
  };
}

class Experience {
  String experienceYearId;
  String experienceYearName;

  Experience({
    this.experienceYearId,
    this.experienceYearName,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
    experienceYearId: json["experience_year_id"] == null ? null : json["experience_year_id"],
    experienceYearName: json["experience_year_name"] == null ? null : json["experience_year_name"],
  );

  Map<String, dynamic> toJson() => {
    "experience_year_id": experienceYearId == null ? null : experienceYearId,
    "experience_year_name": experienceYearName == null ? null : experienceYearName,
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

class JobType {
  String jobTypeId;
  String jobTypeName;

  JobType({
    this.jobTypeId,
    this.jobTypeName,
  });

  factory JobType.fromJson(Map<String, dynamic> json) => JobType(
    jobTypeId: json["job_type_id"] == null ? null : json["job_type_id"],
    jobTypeName: json["job_type_name"] == null ? null : json["job_type_name"],
  );

  Map<String, dynamic> toJson() => {
    "job_type_id": jobTypeId == null ? null : jobTypeId,
    "job_type_name": jobTypeName == null ? null : jobTypeName,
  };
}

class Month {
  String experienceMonthId;
  String experienceMonthName;

  Month({
    this.experienceMonthId,
    this.experienceMonthName,
  });

  factory Month.fromJson(Map<String, dynamic> json) => Month(
    experienceMonthId: json["experience_month_id"] == null ? null : json["experience_month_id"],
    experienceMonthName: json["experience_month_name"] == null ? null : json["experience_month_name"],
  );

  Map<String, dynamic> toJson() => {
    "experience_month_id": experienceMonthId == null ? null : experienceMonthId,
    "experience_month_name": experienceMonthName == null ? null : experienceMonthName,
  };
}

class Salary {
  String salaryLakhsId;
  String salaryLakhsName;

  Salary({
    this.salaryLakhsId,
    this.salaryLakhsName,
  });

  factory Salary.fromJson(Map<String, dynamic> json) => Salary(
    salaryLakhsId: json["salary_lakhs_id"] == null ? null : json["salary_lakhs_id"],
    salaryLakhsName: json["salary_lakhs_name"] == null ? null : json["salary_lakhs_name"],
  );

  Map<String, dynamic> toJson() => {
    "salary_lakhs_id": salaryLakhsId == null ? null : salaryLakhsId,
    "salary_lakhs_name": salaryLakhsName == null ? null : salaryLakhsName,
  };
}

class Thousand {
  String salaryThousandsId;
  String salaryThousandsName;

  Thousand({
    this.salaryThousandsId,
    this.salaryThousandsName,
  });

  factory Thousand.fromJson(Map<String, dynamic> json) => Thousand(
    salaryThousandsId: json["salary_thousands_id"] == null ? null : json["salary_thousands_id"],
    salaryThousandsName: json["salary_thousands_name"] == null ? null : json["salary_thousands_name"],
  );

  Map<String, dynamic> toJson() => {
    "salary_thousands_id": salaryThousandsId == null ? null : salaryThousandsId,
    "salary_thousands_name": salaryThousandsName == null ? null : salaryThousandsName,
  };
}
