// To parse this JSON data, do
//
//     final personalDetailModel = personalDetailModelFromJson(jsonString);

import 'dart:convert';

PersonalDetailModel personalDetailModelFromJson(String str) =>
    PersonalDetailModel.fromJson(json.decode(str));

class PersonalDetailModel {
  List<CandidateDetails> candidateDetails;
  List<ContactNumber> contactNumbers;
  List<EmailId> emailIds;
  List<CandidateEducation> candidateEducation;
  List<CandidateExperience> candidateExperience;
  List<Keyskill> keyskill;
  List<Keylocation> pLocation;
  String response;
  String status;
  String image;

  PersonalDetailModel({
    this.candidateDetails,
    this.contactNumbers,
    this.emailIds,
    this.candidateEducation,
    this.candidateExperience,
    this.keyskill,
    this.pLocation,
    this.response,
    this.status,
    this.image,
  });

  factory PersonalDetailModel.fromJson(Map<String, dynamic> json) =>
      PersonalDetailModel(
        candidateDetails: json["candidate_details"] == null
            ? null
            : List<CandidateDetails>.from(json["candidate_details"]
                .map((x) => CandidateDetails.fromJson(x))),
        contactNumbers: json["contact_numbers"] == null || json["contact_numbers"] == false
            ? []
            : List<ContactNumber>.from(
                json["contact_numbers"].map((x) => ContactNumber.fromJson(x))),
        emailIds: json["email_ids"] == null || json["email_ids"] == false
            ? []
            : List<EmailId>.from(
                json["email_ids"].map((x) => EmailId.fromJson(x))),
        candidateEducation: json["candidate_education"] == null || json["candidate_education"] == false
            ? []
            : List<CandidateEducation>.from(json["candidate_education"]
                .map((x) => CandidateEducation.fromJson(x))),
        candidateExperience: json["candidate_experience"] == null || json["candidate_experience"] == false
            ? []
            : List<CandidateExperience>.from(json["candidate_experience"]
                .map((x) => CandidateExperience.fromJson(x))),
        pLocation: json["keylocation"] == null || json["keylocation"] == false ? [] : List<Keylocation>.from(json["keylocation"].map((x) => Keylocation.fromJson(x))),
        keyskill: json["keyskill"] == null || json["keyskill"] == false ? [] : List<Keyskill>.from(json["keyskill"].map((x) => Keyskill.fromJson(x))),
        response: json["response"] == null ? null : json["response"],
        status: json["status"] == null ? null : json["status"],
        image: json["image"] == null ? '-' : json["image"],
      );
}

class CandidateEducation {
  String candidateEducationId;
  String refCandidateId;
  String candidateEducationInstitution;
  String refGraduationTypeId;
  String refDegreeId;
  String refSpecializationId;
  String refYearOfPassingId;
  String refUserId;
  String deleteStatus;
  String transactionId;
  DateTime addedDate;
  String candidateName;
  String graduationTypeName;
  String degreeName;
  dynamic specializationName;
  String yearOfPassingName;
  dynamic userName;

  CandidateEducation({
    this.candidateEducationId,
    this.refCandidateId,
    this.candidateEducationInstitution,
    this.refGraduationTypeId,
    this.refDegreeId,
    this.refSpecializationId,
    this.refYearOfPassingId,
    this.refUserId,
    this.deleteStatus,
    this.transactionId,
    this.addedDate,
    this.candidateName,
    this.graduationTypeName,
    this.degreeName,
    this.specializationName,
    this.yearOfPassingName,
    this.userName,
  });

  factory CandidateEducation.fromJson(Map<String, dynamic> json) =>
      CandidateEducation(
        candidateEducationId: json["candidate_education_id"] == null
            ? null
            : json["candidate_education_id"],
        refCandidateId:
            json["ref_candidate_id"] == null ? null : json["ref_candidate_id"],
        candidateEducationInstitution:
            json["candidate_education_institution"] == null
                ? null
                : json["candidate_education_institution"],
        refGraduationTypeId: json["ref_graduation_type_id"] == null
            ? null
            : json["ref_graduation_type_id"],
        refDegreeId:
            json["ref_degree_id"] == null ? null : json["ref_degree_id"],
        refSpecializationId: json["ref_specialization_id"] == null
            ? null
            : json["ref_specialization_id"],
        refYearOfPassingId: json["ref_year_of_passing_id"] == null
            ? null
            : json["ref_year_of_passing_id"],
        refUserId: json["ref_user_id"] == null ? null : json["ref_user_id"],
        deleteStatus:
            json["delete_status"] == null ? null : json["delete_status"],
        transactionId:
            json["transaction_id"] == null ? null : json["transaction_id"],
        addedDate: json["added_date"] == null
            ? null
            : DateTime.parse(json["added_date"]),
        candidateName:
            json["candidate_name"] == null ? null : json["candidate_name"],
        graduationTypeName: json["graduation_type_name"] == null
            ? null
            : json["graduation_type_name"],
        degreeName: json["degree_name"] == null ? null : json["degree_name"],
        specializationName: json["specialization_name"],
        yearOfPassingName: json["year_of_passing_name"] == null
            ? null
            : json["year_of_passing_name"],
        userName: json["user_name"],
      );

  Map<String, dynamic> toJson() => {
        "candidate_education_id":
            candidateEducationId == null ? null : candidateEducationId,
        "ref_candidate_id": refCandidateId == null ? null : refCandidateId,
        "candidate_education_institution": candidateEducationInstitution == null
            ? null
            : candidateEducationInstitution,
        "ref_graduation_type_id":
            refGraduationTypeId == null ? null : refGraduationTypeId,
        "ref_degree_id": refDegreeId == null ? null : refDegreeId,
        "ref_specialization_id":
            refSpecializationId == null ? null : refSpecializationId,
        "ref_year_of_passing_id":
            refYearOfPassingId == null ? null : refYearOfPassingId,
        "ref_user_id": refUserId == null ? null : refUserId,
        "delete_status": deleteStatus == null ? null : deleteStatus,
        "transaction_id": transactionId == null ? null : transactionId,
        "added_date": addedDate == null ? null : addedDate.toIso8601String(),
        "candidate_name": candidateName == null ? null : candidateName,
        "graduation_type_name":
            graduationTypeName == null ? null : graduationTypeName,
        "degree_name": degreeName == null ? null : degreeName,
        "specialization_name": specializationName,
        "year_of_passing_name":
            yearOfPassingName == null ? null : yearOfPassingName,
        "user_name": userName,
      };
}

class CandidateExperience {
  String candidateExperienceId;
  String refCandidateId;
  String candidateExperienceCompany;
  String candidateExperienceDesignation;
  DateTime candidateExperienceDateFrom;
  DateTime candidateExperienceDateTo;
  String candidateExperienceProfile;
  String refUserId;
  String deleteStatus;
  String transactionId;
  DateTime addedDate;
  String candidateName;
  dynamic userName;

  CandidateExperience({
    this.candidateExperienceId,
    this.refCandidateId,
    this.candidateExperienceCompany,
    this.candidateExperienceDesignation,
    this.candidateExperienceDateFrom,
    this.candidateExperienceDateTo,
    this.candidateExperienceProfile,
    this.refUserId,
    this.deleteStatus,
    this.transactionId,
    this.addedDate,
    this.candidateName,
    this.userName,
  });

  factory CandidateExperience.fromJson(Map<String, dynamic> json) =>
      CandidateExperience(
        candidateExperienceId: json["candidate_experience_id"] == null
            ? null
            : json["candidate_experience_id"],
        refCandidateId:
            json["ref_candidate_id"] == null ? null : json["ref_candidate_id"],
        candidateExperienceCompany: json["candidate_experience_company"] == null
            ? null
            : json["candidate_experience_company"],
        candidateExperienceDesignation:
            json["candidate_experience_designation"] == null
                ? null
                : json["candidate_experience_designation"],
        candidateExperienceDateFrom:
            json["candidate_experience_date_from"] == null
                ? null
                : DateTime.parse(json["candidate_experience_date_from"]),
        candidateExperienceDateTo: json["candidate_experience_date_to"] == null
            ? null
            : DateTime.parse(json["candidate_experience_date_to"]),
        candidateExperienceProfile: json["candidate_experience_profile"] == null
            ? null
            : json["candidate_experience_profile"],
        refUserId: json["ref_user_id"] == null ? null : json["ref_user_id"],
        deleteStatus:
            json["delete_status"] == null ? null : json["delete_status"],
        transactionId:
            json["transaction_id"] == null ? null : json["transaction_id"],
        addedDate: json["added_date"] == null
            ? null
            : DateTime.parse(json["added_date"]),
        candidateName:
            json["candidate_name"] == null ? null : json["candidate_name"],
        userName: json["user_name"],
      );

  Map<String, dynamic> toJson() => {
        "candidate_experience_id":
            candidateExperienceId == null ? null : candidateExperienceId,
        "ref_candidate_id": refCandidateId == null ? null : refCandidateId,
        "candidate_experience_company": candidateExperienceCompany == null
            ? null
            : candidateExperienceCompany,
        "candidate_experience_designation":
            candidateExperienceDesignation == null
                ? null
                : candidateExperienceDesignation,
        "candidate_experience_date_from": candidateExperienceDateFrom == null
            ? null
            : "${candidateExperienceDateFrom.year.toString().padLeft(4, '0')}-${candidateExperienceDateFrom.month.toString().padLeft(2, '0')}-${candidateExperienceDateFrom.day.toString().padLeft(2, '0')}",
        "candidate_experience_date_to": candidateExperienceDateTo == null
            ? null
            : "${candidateExperienceDateTo.year.toString().padLeft(4, '0')}-${candidateExperienceDateTo.month.toString().padLeft(2, '0')}-${candidateExperienceDateTo.day.toString().padLeft(2, '0')}",
        "candidate_experience_profile": candidateExperienceProfile == null
            ? null
            : candidateExperienceProfile,
        "ref_user_id": refUserId == null ? null : refUserId,
        "delete_status": deleteStatus == null ? null : deleteStatus,
        "transaction_id": transactionId == null ? null : transactionId,
        "added_date": addedDate == null ? null : addedDate.toIso8601String(),
        "candidate_name": candidateName == null ? null : candidateName,
        "user_name": userName,
      };
}

class ContactNumber {
  String contactId;
  String refCandidateId;
  String contactPerson;
  String refContactNumberTypeId;
  String contactStdCode;
  String contactNumber;
  String refUserId;
  String deleteStatus;
  String transactionId;
  DateTime addedDate;
  String candidateName;
  String contactNumberTypeName;
  dynamic userName;

  ContactNumber({
    this.contactId,
    this.refCandidateId,
    this.contactPerson,
    this.refContactNumberTypeId,
    this.contactStdCode,
    this.contactNumber,
    this.refUserId,
    this.deleteStatus,
    this.transactionId,
    this.addedDate,
    this.candidateName,
    this.contactNumberTypeName,
    this.userName,
  });

  factory ContactNumber.fromJson(Map<String, dynamic> json) => ContactNumber(
        contactId: json["contact_id"] == null ? null : json["contact_id"],
        refCandidateId:
            json["ref_candidate_id"] == null ? null : json["ref_candidate_id"],
        contactPerson:
            json["contact_person"] == null ? null : json["contact_person"],
        refContactNumberTypeId: json["ref_contact_number_type_id"] == null
            ? null
            : json["ref_contact_number_type_id"],
        contactStdCode:
            json["contact_std_code"] == null ? null : json["contact_std_code"],
        contactNumber:
            json["contact_number"] == null ? null : json["contact_number"],
        refUserId: json["ref_user_id"] == null ? null : json["ref_user_id"],
        deleteStatus:
            json["delete_status"] == null ? null : json["delete_status"],
        transactionId:
            json["transaction_id"] == null ? null : json["transaction_id"],
        addedDate: json["added_date"] == null
            ? null
            : DateTime.parse(json["added_date"]),
        candidateName:
            json["candidate_name"] == null ? null : json["candidate_name"],
        contactNumberTypeName: json["contact_number_type_name"] == null
            ? null
            : json["contact_number_type_name"],
        userName: json["user_name"],
      );

  Map<String, dynamic> toJson() => {
        "contact_id": contactId == null ? null : contactId,
        "ref_candidate_id": refCandidateId == null ? null : refCandidateId,
        "contact_person": contactPerson == null ? null : contactPerson,
        "ref_contact_number_type_id":
            refContactNumberTypeId == null ? null : refContactNumberTypeId,
        "contact_std_code": contactStdCode == null ? null : contactStdCode,
        "contact_number": contactNumber == null ? null : contactNumber,
        "ref_user_id": refUserId == null ? null : refUserId,
        "delete_status": deleteStatus == null ? null : deleteStatus,
        "transaction_id": transactionId == null ? null : transactionId,
        "added_date": addedDate == null ? null : addedDate.toIso8601String(),
        "candidate_name": candidateName == null ? null : candidateName,
        "contact_number_type_name":
            contactNumberTypeName == null ? null : contactNumberTypeName,
        "user_name": userName,
      };
}

class EmailId {
  String contactEmailId;
  String refCandidateId;
  String contactEmail;
  String contactEmailName;
  String refUserId;
  String deleteStatus;
  String transactionId;
  DateTime addedDate;
  String candidateName;
  dynamic userName;

  EmailId({
    this.contactEmailId,
    this.refCandidateId,
    this.contactEmail,
    this.contactEmailName,
    this.refUserId,
    this.deleteStatus,
    this.transactionId,
    this.addedDate,
    this.candidateName,
    this.userName,
  });

  factory EmailId.fromJson(Map<String, dynamic> json) => EmailId(
        contactEmailId:
            json["contact_email_id"] == null ? null : json["contact_email_id"],
        refCandidateId:
            json["ref_candidate_id"] == null ? null : json["ref_candidate_id"],
        contactEmail:
            json["contact_email"] == null ? null : json["contact_email"],
        contactEmailName: json["contact_email_name"] == null
            ? null
            : json["contact_email_name"],
        refUserId: json["ref_user_id"] == null ? null : json["ref_user_id"],
        deleteStatus:
            json["delete_status"] == null ? null : json["delete_status"],
        transactionId:
            json["transaction_id"] == null ? null : json["transaction_id"],
        addedDate: json["added_date"] == null
            ? null
            : DateTime.parse(json["added_date"]),
        candidateName:
            json["candidate_name"] == null ? null : json["candidate_name"],
        userName: json["user_name"],
      );

  Map<String, dynamic> toJson() => {
        "contact_email_id": contactEmailId == null ? null : contactEmailId,
        "ref_candidate_id": refCandidateId == null ? null : refCandidateId,
        "contact_email": contactEmail == null ? null : contactEmail,
        "contact_email_name":
            contactEmailName == null ? null : contactEmailName,
        "ref_user_id": refUserId == null ? null : refUserId,
        "delete_status": deleteStatus == null ? null : deleteStatus,
        "transaction_id": transactionId == null ? null : transactionId,
        "added_date": addedDate == null ? null : addedDate.toIso8601String(),
        "candidate_name": candidateName == null ? null : candidateName,
        "user_name": userName,
      };
}

class CandidateDetails {
  String candidateId;
  String refSalutationId;
  String candidateName;
  String candidateCode;
  String candidateGender;
  String refMaritalStatusId;
  DateTime candidateDob;
  String refJobLocationId;
  String candidateAddress1;
  String candidateAddress2;
  String candidatePincode;
  String refAreaId;
  String refDistrictId;
  String refStateId;
  String refCountryId;
  String refJobIndustryId;
  String refJobCategoryId;
  String refJobRoleId;
  String refJobTypeId;
  String refHearAboutUsId;
  String candidateImage;
  String candidateResume;
  String candidateDescription;
  String candidateUsernameOld;
  String candidateUsername;
  String candidatePassword;
  String candidatePasswordOrg;
  String candidateKeySkills;
  String candidatePreferredLocation;
  String candidateMobile;
  String refExperienceYearId;
  String refExperienceMonthId;
  String expectedSalaryLakhsId;
  String expectedSalaryThousandsId;
  String currentSalaryLakhsId;
  String currentSalaryThousandsId;
  String refStatusId;
  String refCandidateStatusId;
  String callDateAndTime;
  String callComments;
  String refUserId;
  String deleteStatus;
  String transactionId;
  String addedDate;
  String salutationName;
  String maritalStatusName;
  String jobLocationName;
  String areaName;
  String districtName;
  String stateName;
  String countryName;
  String jobIndustryName;
  String jobCategoryName;
  String jobRoleName;
  String jobTypeName;
  String hearAboutUsName;
  String experienceYearName;
  String experienceMonthName;
  String statusName;
  String candidateStatusName;
  String userName;

  CandidateDetails(
      {this.candidateId,
      this.refSalutationId,
      this.candidateName,
      this.candidateCode,
      this.candidateGender,
      this.refMaritalStatusId,
      this.candidateDob,
      this.refJobLocationId,
      this.candidateAddress1,
      this.candidateAddress2,
      this.candidatePincode,
      this.refAreaId,
      this.refDistrictId,
      this.refStateId,
      this.refCountryId,
      this.refJobIndustryId,
      this.refJobCategoryId,
      this.refJobRoleId,
      this.refJobTypeId,
      this.refHearAboutUsId,
      this.candidateImage,
      this.candidateResume,
      this.candidateDescription,
      this.candidateUsernameOld,
      this.candidateUsername,
      this.candidatePassword,
      this.candidatePasswordOrg,
      this.candidateKeySkills,
      this.candidatePreferredLocation,
      this.candidateMobile,
      this.refExperienceYearId,
      this.refExperienceMonthId,
      this.expectedSalaryLakhsId,
      this.expectedSalaryThousandsId,
      this.currentSalaryLakhsId,
      this.currentSalaryThousandsId,
      this.refStatusId,
      this.refCandidateStatusId,
      this.callDateAndTime,
      this.callComments,
      this.refUserId,
      this.deleteStatus,
      this.transactionId,
      this.addedDate,
      this.salutationName,
      this.maritalStatusName,
      this.jobLocationName,
      this.areaName,
      this.districtName,
      this.stateName,
      this.countryName,
      this.jobIndustryName,
      this.jobCategoryName,
      this.jobRoleName,
      this.jobTypeName,
      this.hearAboutUsName,
      this.experienceYearName,
      this.experienceMonthName,
      this.statusName,
      this.candidateStatusName,
      this.userName});

  factory CandidateDetails.fromJson(Map<String, dynamic> json) =>
      CandidateDetails(
        candidateId: json['candidate_id'] ?? '-',
        refSalutationId: json['ref_salutation_id'] ?? '-',
        candidateName: json['candidate_name'] ?? '-',
        candidateCode: json['candidate_code'] ?? '-',
        candidateGender: json['candidate_gender'] ?? '-',
        refMaritalStatusId: json['ref_marital_status_id'] ?? '-',
        candidateDob: json['candidate_dob'] == '0000-00-00' ? DateTime.parse('1901-01-01') : DateTime.parse(json['candidate_dob']),
        refJobLocationId: json['ref_job_location_id'] ?? '-',
        candidateAddress1: json['candidate_address1'] ?? '-',
        candidateAddress2: json['candidate_address2'] ?? '-',
        candidatePincode: json['candidate_pincode'] ?? '-',
        refAreaId: json['ref_area_id'] ?? '-',
        refDistrictId: json['ref_district_id'] ?? '-',
        refStateId: json['ref_state_id'] ?? '-',
        refCountryId: json['ref_country_id'] ?? '-',
        refJobIndustryId: json['ref_job_industry_id'] ?? '-',
        refJobCategoryId: json['ref_job_category_id'] ?? '-',
        refJobRoleId: json['ref_job_role_id'] ?? '-',
        refJobTypeId: json['ref_job_type_id'] ?? '-',
        refHearAboutUsId: json['ref_hear_about_us_id'] ?? '-',
        candidateImage: json['candidate_image'] ?? '-',
        candidateResume: json['candidate_resume'] ?? '-',
        candidateDescription: json['candidate_description'] ?? '-',
        candidateUsernameOld: json['candidate_username_old'] ?? '-',
        candidateUsername: json['candidate_username'] ?? '-',
        candidatePassword: json['candidate_password'] ?? '-',
        candidatePasswordOrg: json['candidate_password_org'] ?? '-',
        candidateKeySkills: json['candidate_key_skills'] ?? '-',
        candidatePreferredLocation: json['candidate_preferred_location'] ?? '-',
        candidateMobile: json['candidate_mobile'] ?? '-',
        refExperienceYearId: json['ref_experience_year_id'] ?? '-',
        refExperienceMonthId: json['ref_experience_month_id'] ?? '-',
        expectedSalaryLakhsId: json['expected_salary_lakhs_id'] ?? '-',
        expectedSalaryThousandsId: json['expected_salary_thousands_id'] ?? '-',
        currentSalaryLakhsId: json['current_salary_lakhs_id'] ?? '-',
        currentSalaryThousandsId: json['current_salary_thousands_id'] ?? '-',
        refStatusId: json['ref_status_id'] ?? '-',
        refCandidateStatusId: json['ref_candidate_status_id'] ?? '-',
        callDateAndTime: json['call_date_and_time'] ?? '-',
        callComments: json['call_comments'] ?? '-',
        refUserId: json['ref_user_id'] ?? '-',
        deleteStatus: json['delete_status'] ?? '-',
        transactionId: json['transaction_id'] ?? '-',
        addedDate: json['added_date'] ?? '-',
        salutationName: json['salutation_name'] ?? '-',
        maritalStatusName: json['marital_status_name'] ?? '-',
        jobLocationName: json['job_location_name'] ?? '-',
        areaName: json['area_name'] ?? '-',
        districtName: json['district_name'] ?? '-',
        stateName: json['state_name'] ?? '-',
        countryName: json['country_name'] ?? '-',
        jobIndustryName: json['job_industry_name'] ?? '-',
        jobCategoryName: json['job_category_name'] ?? '-',
        jobRoleName: json['job_role_name'] ?? '-',
        jobTypeName: json['job_type_name'] ?? '-',
        hearAboutUsName: json['hear_about_us_name'] ?? '-',
        experienceYearName: json['experience_year_name'] ?? '-',
        experienceMonthName: json['experience_month_name'] ?? '-',
        statusName: json['status_name'] ?? '-',
        candidateStatusName: json['candidate_status_name'] ?? '-',
        userName: json['user_name'] ?? '-',
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['candidate_id'] = this.candidateId;
    data['ref_salutation_id'] = this.refSalutationId;
    data['candidate_name'] = this.candidateName;
    data['candidate_code'] = this.candidateCode;
    data['candidate_gender'] = this.candidateGender;
    data['ref_marital_status_id'] = this.refMaritalStatusId;
    data['candidate_dob'] = this.candidateDob;
    data['ref_job_location_id'] = this.refJobLocationId;
    data['candidate_address1'] = this.candidateAddress1;
    data['candidate_address2'] = this.candidateAddress2;
    data['candidate_pincode'] = this.candidatePincode;
    data['ref_area_id'] = this.refAreaId;
    data['ref_district_id'] = this.refDistrictId;
    data['ref_state_id'] = this.refStateId;
    data['ref_country_id'] = this.refCountryId;
    data['ref_job_industry_id'] = this.refJobIndustryId;
    data['ref_job_category_id'] = this.refJobCategoryId;
    data['ref_job_role_id'] = this.refJobRoleId;
    data['ref_job_type_id'] = this.refJobTypeId;
    data['ref_hear_about_us_id'] = this.refHearAboutUsId;
    data['candidate_image'] = this.candidateImage;
    data['candidate_resume'] = this.candidateResume;
    data['candidate_description'] = this.candidateDescription;
    data['candidate_username_old'] = this.candidateUsernameOld;
    data['candidate_username'] = this.candidateUsername;
    data['candidate_password'] = this.candidatePassword;
    data['candidate_password_org'] = this.candidatePasswordOrg;
    data['candidate_key_skills'] = this.candidateKeySkills;
    data['candidate_preferred_location'] = this.candidatePreferredLocation;
    data['candidate_mobile'] = this.candidateMobile;
    data['ref_experience_year_id'] = this.refExperienceYearId;
    data['ref_experience_month_id'] = this.refExperienceMonthId;
    data['expected_salary_lakhs_id'] = this.expectedSalaryLakhsId;
    data['expected_salary_thousands_id'] = this.expectedSalaryThousandsId;
    data['current_salary_lakhs_id'] = this.currentSalaryLakhsId;
    data['current_salary_thousands_id'] = this.currentSalaryThousandsId;
    data['ref_status_id'] = this.refStatusId;
    data['ref_candidate_status_id'] = this.refCandidateStatusId;
    data['call_date_and_time'] = this.callDateAndTime;
    data['call_comments'] = this.callComments;
    data['ref_user_id'] = this.refUserId;
    data['delete_status'] = this.deleteStatus;
    data['transaction_id'] = this.transactionId;
    data['added_date'] = this.addedDate;
    data['salutation_name'] = this.salutationName;
    data['marital_status_name'] = this.maritalStatusName;
    data['job_location_name'] = this.jobLocationName;
    data['area_name'] = this.areaName;
    data['district_name'] = this.districtName;
    data['state_name'] = this.stateName;
    data['country_name'] = this.countryName;
    data['job_industry_name'] = this.jobIndustryName;
    data['job_category_name'] = this.jobCategoryName;
    data['job_role_name'] = this.jobRoleName;
    data['job_type_name'] = this.jobTypeName;
    data['hear_about_us_name'] = this.hearAboutUsName;
    data['experience_year_name'] = this.experienceYearName;
    data['experience_month_name'] = this.experienceMonthName;
    data['status_name'] = this.statusName;
    data['candidate_status_name'] = this.candidateStatusName;
    data['user_name'] = this.userName;
    return data;
  }
}

class Keylocation {
  String jobLocationId;
  String jobLocationName;
  String jobLocationParentId;
  String refStatusId;
  String deleteStatus;
  String refUserId;
  String transactionId;
  String addedDate;
  String statusName;
  dynamic userName;

  Keylocation({
    this.jobLocationId,
    this.jobLocationName,
    this.jobLocationParentId,
    this.refStatusId,
    this.deleteStatus,
    this.refUserId,
    this.transactionId,
    this.addedDate,
    this.statusName,
    this.userName,
  });

  factory Keylocation.fromJson(Map<String, dynamic> json) => Keylocation(
    jobLocationId: json["job_location_id"] == null ? null : json["job_location_id"],
    jobLocationName: json["job_location_name"] == null ? null : json["job_location_name"],
    jobLocationParentId: json["job_location_parent_id"] == null ? null : json["job_location_parent_id"],
    refStatusId: json["ref_status_id"] == null ? null : json["ref_status_id"],
    deleteStatus: json["delete_status"] == null ? null : json["delete_status"],
    refUserId: json["ref_user_id"] == null ? null : json["ref_user_id"],
    transactionId: json["transaction_id"] == null ? null : json["transaction_id"],
    addedDate: json["added_date"] == null ? null : json["added_date"],
    statusName: json["status_name"] == null ? null : json["status_name"],
    userName: json["user_name"],
  );

  Map<String, dynamic> toJson() => {
    "job_location_id": jobLocationId == null ? null : jobLocationId,
    "job_location_name": jobLocationName == null ? null : jobLocationName,
    "job_location_parent_id": jobLocationParentId == null ? null : jobLocationParentId,
    "ref_status_id": refStatusId == null ? null : refStatusId,
    "delete_status": deleteStatus == null ? null : deleteStatus,
    "ref_user_id": refUserId == null ? null : refUserId,
    "transaction_id": transactionId == null ? null : transactionId,
    "added_date": addedDate == null ? null : addedDate,
    "status_name": statusName == null ? null : statusName,
    "user_name": userName,
  };
}

class Keyskill {
  String keySkillsId;
  String keySkillsName;
  String deleteStatus;
  String refUserId;
  String transactionId;
  DateTime addedDate;
  String userName;

  Keyskill({
    this.keySkillsId,
    this.keySkillsName,
    this.deleteStatus,
    this.refUserId,
    this.transactionId,
    this.addedDate,
    this.userName,
  });

  factory Keyskill.fromJson(Map<String, dynamic> json) => Keyskill(
    keySkillsId: json["key_skills_id"] == null ? null : json["key_skills_id"],
    keySkillsName: json["key_skills_name"] == null ? null : json["key_skills_name"],
    deleteStatus: json["delete_status"] == null ? null : json["delete_status"],
    refUserId: json["ref_user_id"] == null ? null : json["ref_user_id"],
    transactionId: json["transaction_id"] == null ? null : json["transaction_id"],
    addedDate: json["added_date"] == null ? null : DateTime.parse(json["added_date"]),
    userName: json["user_name"] == null ? null : json["user_name"],
  );

  Map<String, dynamic> toJson() => {
    "key_skills_id": keySkillsId == null ? null : keySkillsId,
    "key_skills_name": keySkillsName == null ? null : keySkillsName,
    "delete_status": deleteStatus == null ? null : deleteStatus,
    "ref_user_id": refUserId == null ? null : refUserId,
    "transaction_id": transactionId == null ? null : transactionId,
    "added_date": addedDate == null ? null : addedDate.toIso8601String(),
    "user_name": userName == null ? null : userName,
  };
}

