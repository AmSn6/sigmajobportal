import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sigmajobportal/http_request.dart';
import 'package:sigmajobportal/models/candidate_education_model.dart';
import 'package:sigmajobportal/models/category_model.dart';
import 'package:sigmajobportal/models/common_response_model.dart';
import 'package:sigmajobportal/models/contact_type_model.dart';
import 'package:sigmajobportal/models/course_model.dart';
import 'package:sigmajobportal/models/degree_model.dart';
import 'package:sigmajobportal/models/get_dashboard_model.dart';
import 'package:sigmajobportal/models/job_alert_model.dart';
import 'package:sigmajobportal/models/job_details_model.dart';
import 'package:sigmajobportal/models/job_list_model.dart';
import 'package:sigmajobportal/models/location_model.dart';
import 'package:sigmajobportal/models/login_response_model.dart';
import 'package:sigmajobportal/models/my_application_model.dart';
import 'package:sigmajobportal/models/personal_details_model.dart';
import 'package:sigmajobportal/models/skill_industry_model.dart' as skim;
import 'package:sigmajobportal/models/skills_model.dart';
import 'package:sigmajobportal/models/state_model.dart';
import 'package:sigmajobportal/utils.dart';
import 'models/candidate_personal_model.dart';
import 'models/district_model.dart';
import 'models/register_details_model.dart';
import 'models/skill_role_model.dart';

String indexURL = 'index.php/api/';
String registerDetailsURL = indexURL + 'candidate_register_details';
String candidateRegisterURL = indexURL + 'candidate_register';
String loginURL = indexURL + 'do_login';
String getKeySkillsURL = indexURL + 'get_key_skills';
String getKeyLocationURL = indexURL + 'get_key_location';
String getDashbordURL = indexURL + 'get_dashboard';
String getCategoryListURL = indexURL + 'get_category_list';
String getPersonalDetailsURL = indexURL + 'get_candidate_view';
String getJobListURL = indexURL + 'get_category_job_list';
String getJobDetailsURL = indexURL + 'get_job_details';
String applyJobURL = indexURL + 'apply_job';
String getJobAlertURL = indexURL + 'get_jobalert';
String getIndustryURL = indexURL + 'get_industry';
String getCategoryURL = indexURL + 'get_category';
String getRoleURL = indexURL + 'getRole';
String saveJobAlertURL = indexURL + 'save_job_alert';
String getContactTypeURL = indexURL + 'get_contact_type';
String getCandidateEducationURL = indexURL + 'candidate_education';
String getDegreeURL = indexURL + 'get_degree';
String getCourseURL = indexURL + 'get_course';
String getCandidatePersonalURL = indexURL + 'candidate_personal';
String editCandidatePersonalURL = indexURL + 'edit_candidate_personal';
String editCandidateURL = indexURL + 'edit_candidate';
String postJobDetailsURL = indexURL + 'edit_candidate_jobdetails';
String getStateListURL = indexURL + 'employee_register_details';
String getDistrictListURL = indexURL + 'get_district';
String myApplicationURL = indexURL + 'view_applied_job';
String searchJobURL = indexURL + 'candidate_search_job';
String changePasswordURL = indexURL + 'change_password';
String checkUsernameURL = indexURL + 'check_candidate';

final storage = FlutterSecureStorage();

Future getBaseURL() async {

  DocumentSnapshot ds = await FirebaseFirestore.instance
      .collection('base_url')
      .doc('base_url')
      .get();
  print('firebase');
  // String baseUrl = 'http://192.168.1.6/shared/connexions/';
  // await storage.write(key: skBaseURL, value: baseUrl);
  await storage.write(key: skBaseURL, value: ds.get('base_url').toString());
}

Future<RegisterDetailsModel> getRegisterDetails() async {
  var url = await storage.read(key: skBaseURL) + registerDetailsURL;
  print('url - $url');

  return registerDetailsModelFromJson(await httpGet(url: url));
}

Future<GetDashboardModel> getDashboard() async {
  return getDashboardModelFromJson(
      await httpGet(url: await storage.read(key: skBaseURL) + getDashbordURL));
}

Future<CandidatePersonalModel> getCandidatePersonal() async {
  return candidatePersonalModelFromJson(await httpGet(
      url: await storage.read(key: skBaseURL) + getCandidatePersonalURL));
}

Future<List<Contact>> getContactType() async {
  ContactTypeModel model = contactTypeModelFromJson(await httpGet(
      url: await storage.read(key: skBaseURL) + getContactTypeURL));
  return model.contact;
}

Future<CandidateEducationModel> getCandidateEducation() async {
  return candidateEducationModelFromJson(await httpGet(
      url: await storage.read(key: skBaseURL) + getCandidateEducationURL));
}

Future<CommonResponseModel> postRegistrationDetials(
    Map<String, String> params) async {
  print(params);
  return commonResponseModelFromJson(await httpPost(
      url: await storage.read(key: skBaseURL) + candidateRegisterURL,
      params: params));
}

Future<CommonResponseModel> postCandidatePersonal(
    Map<String, String> params) async {
  print(params);
  return commonResponseModelFromJson(await httpPost(
      url: await storage.read(key: skBaseURL) + editCandidateURL,
      params: params));
}

Future<CommonResponseModel> checkUsername(Map<String, String> params) async {
  print(params);
  return commonResponseModelFromJson(await httpPost(
      url: await storage.read(key: skBaseURL) + checkUsernameURL,
      params: params));
}

Future<CommonResponseModel> postJobDetails(Map<String, String> params) async {
  print(params);
  return commonResponseModelFromJson(await httpPost(
      url: await storage.read(key: skBaseURL) + postJobDetailsURL,
      params: params));
}

Future<DegreeModel> getDegree(Map<String, String> params) async {
  print(params);
  return degreeModelFromJson(await httpPost(
      url: await storage.read(key: skBaseURL) + getDegreeURL, params: params));
}

Future<CourseModel> getCourse(Map<String, String> params) async {
  print(params);
  return courseModelFromJson(await httpPost(
      url: await storage.read(key: skBaseURL) + getCourseURL, params: params));
}

Future<CommonResponseModel> applyJob(String jobID) async {
  String candidateID = await storage.read(key: skCandidateID);
  return commonResponseModelFromJson(await httpPost(
      url: await storage.read(key: skBaseURL) + applyJobURL,
      params: {'candidate_id': candidateID, 'job_id': jobID}));
}

Future<CommonResponseModel> changePassword(String password) async {
  String candidateID = await storage.read(key: skCandidateID);
  return commonResponseModelFromJson(await httpPost(
      url: await storage.read(key: skBaseURL) + changePasswordURL,
      params: {'candidate_id': candidateID, 'password': password}));
}

Future<CommonResponseModel> postCandidatePersonalDetails(
    Map<String, String> params) async {
  return commonResponseModelFromJson(await httpPost(
      url: await storage.read(key: skBaseURL) + editCandidatePersonalURL,
      params: params));
}

Future<PersonalDetailModel> getPersonalDetails() async {
  String candidateID = await storage.read(key: skCandidateID);
  String baseURL = await storage.read(key: skBaseURL);
  return personalDetailModelFromJson(await httpPost(
      url: baseURL + getPersonalDetailsURL,
      params: {'candidate_id': candidateID}));
}

Future<LoginResponseModel> postLoginDetails(Map<String, String> params) async {
  String url = await storage.read(key: skBaseURL) + loginURL;
  print('login url -$url');
  String response = await httpPost(params: params, url: url);
  print('res = $response');
  if (response == 'Error') {
    return null;
  } else {
    return loginResponseModelFromJson(response);
  }
}

// Keyskills
Future<List<Skill>> postKeySkills(Map<String, String> params) async {
  print(params);
  return skillsModelFromJson(await httpPost(
          params: params,
          url: await storage.read(key: skBaseURL) + getKeySkillsURL))
      .skills;
}

//pref location
Future<List<Location>> postKeyLocation(Map<String, String> params) async {
  print(params);
  return locationModelFromJson(await httpPost(
          params: params,
          url: await storage.read(key: skBaseURL) + getKeyLocationURL))
      .location;
}

Future<CategoryModel> getCategories() async {
  return categoryModelFromJson(await httpGet(
      url: await storage.read(key: skBaseURL) + getCategoryListURL));
}

Future<JobListModel> getJobList(String categoryID) async {
  return jobListModelFromJson(await httpPost(
      url: await storage.read(key: skBaseURL) + getJobListURL,
      params: {'category_id': categoryID}));
}

Future<JobDetailsModel> getJobDetails(String jobID) async {
  return jobDetailsModelFromJson(await httpPost(
      url: await storage.read(key: skBaseURL) + getJobDetailsURL,
      params: {'job_id': jobID}));
}

Future<JobAlertModel> getJobAlert() async {
  return jobAlertModelFromJson(
      await httpGet(url: await storage.read(key: skBaseURL) + getJobAlertURL));
}

Future<List<skim.Industry>> postKeyIndustry(Map<String, String> params) async {
  print(params);
  return skim
      .skillIndustryModelFromJson(await httpPost(
          params: params,
          url: await storage.read(key: skBaseURL) + getIndustryURL))
      .industry;
}

Future<List<JobCategory>> postKeyCategory(Map<String, String> params) async {
  print(params);
  return categoryModelFromJson(await httpPost(
          params: params,
          url: await storage.read(key: skBaseURL) + getCategoryURL))
      .jobCategory;
}

Future<List<Role>> postKeyRole(Map<String, String> params) async {
  print(params);
  return skillRoleModelFromJson(await httpPost(
          params: params, url: await storage.read(key: skBaseURL) + getRoleURL))
      .role;
}

Future<SkillRoleModel> postKeyRoleType(Map<String, String> params) async {
  print(params);
  return skillRoleModelFromJson(await httpPost(
      url: await storage.read(key: skBaseURL) + getRoleURL, params: params));
}

Future<CommonResponseModel> saveJobAlert(Map<String, String> params) async {
  return commonResponseModelFromJson(await httpPost(
      url: await storage.read(key: skBaseURL) + saveJobAlertURL,
      params: params));
}

Future<StateModel> getStateList() async {
  return stateModelFromJson(
      await httpGet(url: await storage.read(key: skBaseURL) + getStateListURL));
}

Future<DistrictModel> getDistrictList(Map<String, String> params) async {
  return districtModelFromJson(
    await httpPost(
        params: params,
        url: await storage.read(key: skBaseURL) + getDistrictListURL),
  );
}

Future<MyApplicationModel> getMyApplicationList() async {
  String candidateID = await storage.read(key: skCandidateID);
  return myApplicationModelFromJson(
    await httpPost(
        params: {'candidate_id': candidateID},
        url: await storage.read(key: skBaseURL) + myApplicationURL),
  );
}

Future<JobListModel> searchJob(Map<String, String> params) async {
  return jobListModelFromJson(await httpPost(
      params: params, url: await storage.read(key: skBaseURL) + searchJobURL));
}
