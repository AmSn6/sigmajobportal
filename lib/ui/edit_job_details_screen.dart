import 'dart:convert';

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sigmajobportal/models/common_response_model.dart';
import 'package:sigmajobportal/models/get_dashboard_model.dart';
import 'package:sigmajobportal/models/personal_details_model.dart';
import 'package:sigmajobportal/models/skill_role_model.dart';
import 'package:sigmajobportal/repository.dart';
import 'package:sigmajobportal/repository.dart' as prefix0;
import 'package:sigmajobportal/utils.dart';
import 'package:progress_button/progress_button.dart';

class EditJobDetailsScreen extends StatefulWidget {
  final CandidateDetails candidateDetails;

  EditJobDetailsScreen({Key key, this.candidateDetails}) : super(key: key);

  @override
  _EditJobDetailsScreenState createState() => _EditJobDetailsScreenState();
}

class _EditJobDetailsScreenState extends State<EditJobDetailsScreen> {
  TextEditingController industryController;
  TextEditingController functionalAreaController;
  TextEditingController roleController;
  TextEditingController experienceYearController;
  TextEditingController experienceMonthController;
  TextEditingController currentSalaryLakhsController;
  TextEditingController currentSalaryThousandController;
  TextEditingController expectedSalaryLakhsController;
  TextEditingController expectedSalaryThousandController;
  TextEditingController jobTypeController;
  TextEditingController hearController;

  List<Role> _roleList = [];

  String industryID;
  String functionalAreaID;
  String roleID;
  String experienceYearID;
  String experienceMonthID;
  String jobTypeID;
  String hearID;

  Future _future;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    initializeVariables();
    _future = getDashboard();
    getRoles();
  }

  void initializeVariables() {
    industryController = new TextEditingController(
        text: widget.candidateDetails.jobIndustryName);
    functionalAreaController = new TextEditingController(
        text: widget.candidateDetails.jobCategoryName);
    roleController =
        new TextEditingController(text: widget.candidateDetails.jobRoleName);
    experienceYearController = new TextEditingController(
        text: widget.candidateDetails.experienceYearName);
    experienceMonthController = new TextEditingController(
        text: widget.candidateDetails.experienceMonthName);
    currentSalaryLakhsController = new TextEditingController(
        text: widget.candidateDetails.currentSalaryLakhsId);
    currentSalaryThousandController = new TextEditingController(
        text: widget.candidateDetails.currentSalaryThousandsId);
    expectedSalaryLakhsController = new TextEditingController(
        text: widget.candidateDetails.expectedSalaryLakhsId);
    expectedSalaryThousandController = new TextEditingController(
        text: widget.candidateDetails.expectedSalaryThousandsId);
    jobTypeController =
        new TextEditingController(text: widget.candidateDetails.jobTypeName);
    hearController = new TextEditingController(
        text: widget.candidateDetails.hearAboutUsName);

    industryID = widget.candidateDetails.refJobIndustryId;
    functionalAreaID = widget.candidateDetails.refAreaId;
    roleID = widget.candidateDetails.refJobRoleId;
    experienceYearID = widget.candidateDetails.refExperienceYearId;
    experienceMonthID = widget.candidateDetails.refExperienceMonthId;
    jobTypeID = widget.candidateDetails.refJobTypeId;
    hearID = widget.candidateDetails.refHearAboutUsId;
  }

  @override
  void dispose() {
    industryController.dispose();
    functionalAreaController.dispose();
    roleController.dispose();
    experienceYearController.dispose();
    experienceMonthController.dispose();
    currentSalaryLakhsController.dispose();
    currentSalaryThousandController.dispose();
    expectedSalaryLakhsController.dispose();
    expectedSalaryThousandController.dispose();
    jobTypeController.dispose();
    hearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: appbarMethod('Update Job details'),
      body:
          FutureBuilder<GetDashboardModel>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return errorWidget(context);
                } else {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          industryContainer(snapshot),
                          SizedBox(
                            height: 10,
                          ),
                          functionalAreaContainer(snapshot),
                          SizedBox(
                            height: 10,
                          ),
                          roleContainer(),
                          SizedBox(
                            height: 10,
                          ),
                          experienceContainer(snapshot),
                          SizedBox(
                            height: 10,
                          ),
                          currentSalaryContainer(snapshot),
                          SizedBox(
                            height: 10,
                          ),
                          expectedSalaryContainer(snapshot),
                          SizedBox(
                            height: 10,
                          ),
                          jobTypeContainer(snapshot),
                          SizedBox(
                            height: 10,
                          ),
//                      Container(
//                        width: double.infinity,
//                        padding: EdgeInsets.all(10),
//                        decoration: BoxDecoration(
//                          color: white,
//                          borderRadius: BorderRadius.circular(5),
//                        ),
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            h1Text('How Hear About Us?'),
//                            SizedBox(
//                              height: 15,
//                            ),
//                            Container(
//                              padding: EdgeInsets.only(left: 12),
//                              decoration: BoxDecoration(
//                                  color: grey,
//                                  borderRadius: BorderRadius.circular(30)),
//                              child: TypeAheadFormField<>(
//                                textFieldConfiguration: TextFieldConfiguration(
//                                  controller: hearController,
//                                  decoration: InputDecoration(
//                                      suffixIcon:
//                                      Icon(FeatherIcons.chevronDown),
//                                      border: InputBorder.none,
//                                      hintText: 'How Hear About Us?',
//                                      hintStyle: TextStyle(
//                                        color: grey1,
//                                      )),
//                                ),
//                                autoFlipDirection: true,
//                                validator: (value) {
//                                  if (value.isEmpty) {
//                                    return 'Please Select Months';
//                                  }
//                                },
//                                onSuggestionSelected: (month) async {
//                                  experienceMonthID = month.experienceMonthId;
//                                  experienceMonthController.text =
//                                      month.experienceMonthName;
//                                },
//                                itemBuilder: (context, month) {
//                                  return Padding(
//                                    padding: const EdgeInsets.all(8.0),
//                                    child: Text(month.experienceMonthName),
//                                  );
//                                },
//                                getImmediateSuggestions: true,
//                                suggestionsCallback: (pattern) {
//                                  return snapshot.data.months
//                                      .where((val) => val.experienceMonthName
//                                      .toLowerCase()
//                                      .contains(pattern.toLowerCase()))
//                                      .toList();
//                                },
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                      SizedBox(
//                        height: 20,
//                      ),
                        /*  SizedBox(
                            height: 50,
                            width: 300,
                            child: RaisedButton(
                              shape: buttonShape(30),
                              onPressed: () {
                                postJobDetails();
                              },
                              color: purple,
                              child: buttonText('Edit Job details'),
                            ),
                          ),*/
                          ProgressButton(
                            backgroundColor: purple,
                            progressColor: white,
                            child: buttonText('Update'),
                            buttonState: _isLoading ? ButtonState.inProgress : ButtonState.normal,
                            onPressed: () async {
                              postJobDetails();
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }),
    );
  }

  Container jobTypeContainer(AsyncSnapshot<GetDashboardModel> snapshot) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          h1Text('Job Type'),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                color: grey, borderRadius: BorderRadius.circular(30)),
            child: TypeAheadFormField<JobType>(
              textFieldConfiguration: TextFieldConfiguration(
                controller: jobTypeController,
                decoration: InputDecoration(
                    suffixIcon: Icon(FeatherIcons.chevronDown),
                    border: InputBorder.none,
                    hintText: 'Job Type',
                    hintStyle: TextStyle(
                      color: grey1,
                    )),
              ),
              autoFlipDirection: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Select Job Type';
                }
              },
              onSuggestionSelected: (month) async {
                jobTypeID = month.jobTypeId;
                jobTypeController.text = month.jobTypeName;
              },
              itemBuilder: (context, month) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(month.jobTypeName),
                );
              },
              getImmediateSuggestions: true,
              suggestionsCallback: (pattern) {
                return snapshot.data.jobType
                    .where((val) => val.jobTypeName
                        .toLowerCase()
                        .contains(pattern.toLowerCase()))
                    .toList();
              },
            ),
          ),
        ],
      ),
    );
  }

  Container expectedSalaryContainer(AsyncSnapshot<GetDashboardModel> snapshot) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          h1Text('Expected Salary'),
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                      color: grey, borderRadius: BorderRadius.circular(30)),
                  child: TypeAheadFormField<Salary>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: expectedSalaryLakhsController,
                      decoration: InputDecoration(
                          suffixIcon: Icon(FeatherIcons.chevronDown),
                          border: InputBorder.none,
                          hintText: 'Select Lakhs',
                          hintStyle: TextStyle(
                            color: grey1,
                          )),
                    ),
                    autoFlipDirection: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Select Years';
                      }
                    },
                    onSuggestionSelected: (experience) async {
                      expectedSalaryLakhsController.text =
                          experience.salaryLakhsId;
                    },
                    itemBuilder: (context, experience) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(experience.salaryLakhsName),
                      );
                    },
                    getImmediateSuggestions: true,
                    suggestionsCallback: (pattern) {
                      return snapshot.data.salary
                          .where((val) => val.salaryLakhsName
                              .toLowerCase()
                              .contains(pattern.toLowerCase()))
                          .toList();
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                      color: grey, borderRadius: BorderRadius.circular(30)),
                  child: TypeAheadFormField<Thousand>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: expectedSalaryThousandController,
                      decoration: InputDecoration(
                          suffixIcon: Icon(FeatherIcons.chevronDown),
                          border: InputBorder.none,
                          hintText: 'Select Thousands',
                          hintStyle: TextStyle(
                            color: grey1,
                          )),
                    ),
                    autoFlipDirection: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Select Thousands';
                      }
                    },
                    onSuggestionSelected: (experience) async {
                      expectedSalaryThousandController.text =
                          experience.salaryThousandsId;
                    },
                    itemBuilder: (context, experience) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(experience.salaryThousandsName),
                      );
                    },
                    getImmediateSuggestions: true,
                    suggestionsCallback: (pattern) {
                      return snapshot.data.thousands
                          .where((val) => val.salaryThousandsName
                              .toLowerCase()
                              .contains(pattern.toLowerCase()))
                          .toList();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container currentSalaryContainer(AsyncSnapshot<GetDashboardModel> snapshot) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          h1Text('Current Salary'),
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                      color: grey, borderRadius: BorderRadius.circular(30)),
                  child: TypeAheadFormField<Salary>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: currentSalaryLakhsController,
                      decoration: InputDecoration(
                          suffixIcon: Icon(FeatherIcons.chevronDown),
                          border: InputBorder.none,
                          hintText: 'Select Lakhs',
                          hintStyle: TextStyle(
                            color: grey1,
                          )),
                    ),
                    autoFlipDirection: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Select Years';
                      }
                    },
                    onSuggestionSelected: (experience) async {
                      currentSalaryLakhsController.text =
                          experience.salaryLakhsId;
                    },
                    itemBuilder: (context, experience) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(experience.salaryLakhsName),
                      );
                    },
                    getImmediateSuggestions: true,
                    suggestionsCallback: (pattern) {
                      return snapshot.data.salary
                          .where((val) => val.salaryLakhsName
                              .toLowerCase()
                              .contains(pattern.toLowerCase()))
                          .toList();
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                      color: grey, borderRadius: BorderRadius.circular(30)),
                  child: TypeAheadFormField<Thousand>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: currentSalaryThousandController,
                      decoration: InputDecoration(
                          suffixIcon: Icon(FeatherIcons.chevronDown),
                          border: InputBorder.none,
                          hintText: 'Select Thousands',
                          hintStyle: TextStyle(
                            color: grey1,
                          )),
                    ),
                    autoFlipDirection: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Select Thousands';
                      }
                    },
                    onSuggestionSelected: (experience) async {
                      currentSalaryThousandController.text =
                          experience.salaryThousandsId;
                    },
                    itemBuilder: (context, experience) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(experience.salaryThousandsName),
                      );
                    },
                    getImmediateSuggestions: true,
                    suggestionsCallback: (pattern) {
                      return snapshot.data.thousands
                          .where((val) => val.salaryThousandsName
                              .toLowerCase()
                              .contains(pattern.toLowerCase()))
                          .toList();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container experienceContainer(AsyncSnapshot<GetDashboardModel> snapshot) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          h1Text('Experience'),
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                      color: grey, borderRadius: BorderRadius.circular(30)),
                  child: TypeAheadFormField<Experience>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: experienceYearController,
                      decoration: InputDecoration(
                          suffixIcon: Icon(FeatherIcons.chevronDown),
                          border: InputBorder.none,
                          hintText: 'Select Years',
                          hintStyle: TextStyle(
                            color: grey1,
                          )),
                    ),
                    autoFlipDirection: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Select Years';
                      }
                    },
                    onSuggestionSelected: (experience) async {
                      experienceYearID = experience.experienceYearId;
                      experienceYearController.text =
                          experience.experienceYearName;
                    },
                    itemBuilder: (context, experience) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(experience.experienceYearName),
                      );
                    },
                    getImmediateSuggestions: true,
                    suggestionsCallback: (pattern) {
                      return snapshot.data.experience
                          .where((val) => val.experienceYearName
                              .toLowerCase()
                              .contains(pattern.toLowerCase()))
                          .toList();
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                      color: grey, borderRadius: BorderRadius.circular(30)),
                  child: TypeAheadFormField<Month>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: experienceMonthController,
                      decoration: InputDecoration(
                          suffixIcon: Icon(FeatherIcons.chevronDown),
                          border: InputBorder.none,
                          hintText: 'Select Months',
                          hintStyle: TextStyle(
                            color: grey1,
                          )),
                    ),
                    autoFlipDirection: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Select Months';
                      }
                    },
                    onSuggestionSelected: (month) async {
                      experienceMonthID = month.experienceMonthId;
                      experienceMonthController.text =
                          month.experienceMonthName;
                    },
                    itemBuilder: (context, month) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(month.experienceMonthName),
                      );
                    },
                    getImmediateSuggestions: true,
                    suggestionsCallback: (pattern) {
                      return snapshot.data.months
                          .where((val) => val.experienceMonthName
                              .toLowerCase()
                              .contains(pattern.toLowerCase()))
                          .toList();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  functionalAreaContainer(AsyncSnapshot<GetDashboardModel> snapshot) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          h1Text('Functional Area'),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                color: grey, borderRadius: BorderRadius.circular(30)),
            child: TypeAheadFormField<Category>(
              textFieldConfiguration: TextFieldConfiguration(
                controller: functionalAreaController,
                decoration: InputDecoration(
                    suffixIcon: Icon(FeatherIcons.chevronDown),
                    border: InputBorder.none,
                    hintText: 'Functional Area',
                    hintStyle: TextStyle(color: grey1)),
              ),
              autoFlipDirection: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Select Functional Area';
                }
              },
              onSuggestionSelected: (category) async {
                functionalAreaID = category.jobCategoryId;
                functionalAreaController.text = category.jobCategoryName;
                SkillRoleModel model =
                    await postKeyRoleType({'id': functionalAreaID});
                _roleList = model.role;
              },
              itemBuilder: (context, categoty) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(categoty.jobCategoryName),
                );
              },
              getImmediateSuggestions: true,
              suggestionsCallback: (pattern) {
                return snapshot.data.category
                    .where((val) => val.jobCategoryName
                        .toLowerCase()
                        .contains(pattern.toLowerCase()))
                    .toList();
              },
            ),
          ),
        ],
      ),
    );
  }

  Container roleContainer() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          h1Text('Role'),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                color: grey, borderRadius: BorderRadius.circular(30)),
            child: TypeAheadFormField<Role>(
              textFieldConfiguration: TextFieldConfiguration(
                controller: roleController,
                decoration: InputDecoration(
                    suffixIcon: Icon(FeatherIcons.chevronDown),
                    border: InputBorder.none,
                    hintText: 'Role',
                    hintStyle: TextStyle(color: grey1)),
              ),
              autoFlipDirection: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Select Role';
                }
              },
              onSuggestionSelected: (role) {
                roleID = role.id;
                roleController.text = role.name;
              },
              itemBuilder: (context, role) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(role.name),
                );
              },
              getImmediateSuggestions: true,
              suggestionsCallback: (pattern) {
                return _roleList
                    .where((val) =>
                        val.name.toLowerCase().contains(pattern.toLowerCase()))
                    .toList();
              },
            ),
          ),
        ],
      ),
    );
  }

  Container industryContainer(AsyncSnapshot<GetDashboardModel> snapshot) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          h1Text('Industry'),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                color: grey, borderRadius: BorderRadius.circular(30)),
            child: TypeAheadFormField<Industry>(
              textFieldConfiguration: TextFieldConfiguration(
                controller: industryController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Icon(FeatherIcons.chevronDown),
                    hintText: 'Industry',
                    hintStyle: TextStyle(color: grey1)),
              ),
              autoFlipDirection: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Select Industry';
                }
              },
              onSuggestionSelected: (industry) {
                industryID = industry.jobIndustryId;
                industryController.text = industry.jobIndustryName;
              },
              itemBuilder: (context, industry) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(industry.jobIndustryName),
                );
              },
              getImmediateSuggestions: true,
              suggestionsCallback: (pattern) {
                return snapshot.data.industry
                    .where((val) => val.jobIndustryName
                        .toLowerCase()
                        .contains(pattern.toLowerCase()))
                    .toList();
              },
            ),
          ),
        ],
      ),
    );
  }

  void postJobDetails() async {
    setState(() {
      _isLoading = true;
    });
    Map<String, String> params = {
      'candidate_job_details': jsonEncode([
        {
          'candidate_id': widget.candidateDetails.candidateId,
          'ref_job_industry_id': industryID,
          'ref_job_category_id': functionalAreaID,
          'ref_job_role_id': roleID,
          'ref_experience_year_id': experienceYearID,
          'ref_experience_month_id': experienceMonthID,
          'current_salary_lakhs_id': currentSalaryLakhsController.text,
          'current_salary_thousands_id': currentSalaryThousandController.text,
          'expected_salary_lakhs_id': expectedSalaryLakhsController.text,
          'expected_salary_thousands_id': expectedSalaryThousandController.text,
          'ref_job_type_id': jobTypeID,
        }
      ])
    };
    CommonResponseModel model = await prefix0.postJobDetails(params);
    if (model.response == "1") {
      Navigator.pop(context, true);
      print('Success');
    } else {
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context, false);
      print('Fail');
    }
  }

  void getRoles() async {
    SkillRoleModel model =
        await postKeyRoleType({'id': widget.candidateDetails.refJobCategoryId});
    _roleList = model.role;
  }
}
