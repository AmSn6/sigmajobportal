// To parse this JSON data, do
//
//     final registerDetailsModel = registerDetailsModelFromJson(jsonString);

import 'dart:convert';

RegisterDetailsModel registerDetailsModelFromJson(String str) => RegisterDetailsModel.fromJson(json.decode(str));

String registerDetailsModelToJson(RegisterDetailsModel data) => json.encode(data.toJson());

class RegisterDetailsModel {
  List<District> district;
  List<Experience> experience;
  List<Month> months;
  String status;

  RegisterDetailsModel({
    this.district,
    this.experience,
    this.months,
    this.status,
  });

  factory RegisterDetailsModel.fromJson(Map<String, dynamic> json) => RegisterDetailsModel(
    district: json["district"] == null ? null : List<District>.from(json["district"].map((x) => District.fromJson(x))),
    experience: json["experience"] == null ? null : List<Experience>.from(json["experience"].map((x) => Experience.fromJson(x))),
    months: json["months"] == null ? null : List<Month>.from(json["months"].map((x) => Month.fromJson(x))),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "district": district == null ? null : List<dynamic>.from(district.map((x) => x.toJson())),
    "experience": experience == null ? null : List<dynamic>.from(experience.map((x) => x.toJson())),
    "months": months == null ? null : List<dynamic>.from(months.map((x) => x.toJson())),
    "status": status == null ? null : status,
  };
}

class District {
  String districtId;
  String districtName;

  District({
    this.districtId,
    this.districtName,
  });

  factory District.fromJson(Map<String, dynamic> json) => District(
    districtId: json["district_id"] == null ? null : json["district_id"],
    districtName: json["district_name"] == null ? null : json["district_name"],
  );

  Map<String, dynamic> toJson() => {
    "district_id": districtId == null ? null : districtId,
    "district_name": districtName == null ? null : districtName,
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
