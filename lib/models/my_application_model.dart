// To parse this JSON data, do
//
//     final myApplicationModel = myApplicationModelFromJson(jsonString);

import 'dart:convert';

MyApplicationModel myApplicationModelFromJson(String str) => MyApplicationModel.fromJson(json.decode(str));

String myApplicationModelToJson(MyApplicationModel data) => json.encode(data.toJson());

class MyApplicationModel {
  List<ApplyDetail> applyDetails;

  MyApplicationModel({
    this.applyDetails,
  });

  factory MyApplicationModel.fromJson(Map<String, dynamic> json) => MyApplicationModel(
    applyDetails: json["apply_details"] == false ? [] : List<ApplyDetail>.from(json["apply_details"].map((x) => ApplyDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "apply_details": applyDetails == null ? null : List<dynamic>.from(applyDetails.map((x) => x.toJson())),
  };
}

class ApplyDetail {
  String jobApplyHistoryId;
  String candidateId;
  String refJobId;
  String candidateName;
  String jobName;
  DateTime jobApplyDate;

  ApplyDetail({
    this.jobApplyHistoryId,
    this.candidateId,
    this.refJobId,
    this.candidateName,
    this.jobName,
    this.jobApplyDate,
  });

  factory ApplyDetail.fromJson(Map<String, dynamic> json) => ApplyDetail(
    jobApplyHistoryId: json["job_apply_history_id"] == null ? null : json["job_apply_history_id"],
    candidateId: json["candidate_id"] == null ? null : json["candidate_id"],
    refJobId: json["ref_job_id"] == null ? null : json["ref_job_id"],
    candidateName: json["candidate_name"] == null ? null : json["candidate_name"],
    jobName: json["job_name"] == null ? null : json["job_name"],
    jobApplyDate: json["job_apply_date"] == null ? null : DateTime.parse(json["job_apply_date"]),
  );

  Map<String, dynamic> toJson() => {
    "job_apply_history_id": jobApplyHistoryId == null ? null : jobApplyHistoryId,
    "candidate_id": candidateId == null ? null : candidateId,
    "ref_job_id": refJobId == null ? null : refJobId,
    "candidate_name": candidateName == null ? null : candidateName,
    "job_name": jobName == null ? null : jobName,
    "job_apply_date": jobApplyDate == null ? null : "${jobApplyDate.year.toString().padLeft(4, '0')}-${jobApplyDate.month.toString().padLeft(2, '0')}-${jobApplyDate.day.toString().padLeft(2, '0')}",
  };
}
