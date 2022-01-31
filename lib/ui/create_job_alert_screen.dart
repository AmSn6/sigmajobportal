import 'dart:convert';

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart' as ta;
import 'package:sigmajobportal/models/category_model.dart';
import 'package:sigmajobportal/models/common_response_model.dart';
import 'package:sigmajobportal/models/job_alert_model.dart';
import 'package:sigmajobportal/models/location_model.dart';
import 'package:sigmajobportal/models/skill_industry_model.dart';
import 'package:sigmajobportal/models/skill_role_model.dart';
import 'package:sigmajobportal/models/skills_model.dart';
import 'package:sigmajobportal/repository.dart';
import 'package:sigmajobportal/utils.dart';
import 'package:progress_button/progress_button.dart';
import 'package:rich_alert/rich_alert.dart';

class CreateJobAlertScreen extends StatefulWidget {
  CreateJobAlertScreen({Key key}) : super(key: key);

  @override
  _CreateJobAlertScreenState createState() => _CreateJobAlertScreenState();
}

class _CreateJobAlertScreenState extends State<CreateJobAlertScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Industry> _industryList = [];

  List<Role> _roleList = [];

  List<JobCategory> _categoryList = [];

  String skillID, locationID, experienceID, salaryID, thousandID;
  String candidateName;
  List<Skill> _skillList = [];
  List<Location> _locationList = [];
  bool isLoading = false;

  String username, email, mobileNumber, districtID, monthID;
  TextEditingController districtController = new TextEditingController();
  TextEditingController experienceController = new TextEditingController();
  TextEditingController monthController = new TextEditingController();
  TextEditingController keySalaryController = new TextEditingController();
  TextEditingController keyThousandController = new TextEditingController();

  @override
  void dispose() {
    districtController.dispose();
    experienceController.dispose();
    monthController.dispose();
    keySalaryController.dispose();
    keyThousandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: grey,
      appBar: appbarMethod('Create Job Alert'),
      body: FutureBuilder<JobAlertModel>(
          future: getJobAlert(),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        keywordsContainer(),
                        SizedBox(
                          height: 10,
                        ),
                        workExperienceContainer(snapshot),
                        SizedBox(
                          height: 10,
                        ),
                        industryContainer(),
                        SizedBox(
                          height: 10,
                        ),
                        jobCategoryContainer(),
                        SizedBox(
                          height: 10,
                        ),
                        roleContainer(),
                        SizedBox(
                          height: 10,
                        ),
                        nameContainer(),
                        SizedBox(
                          height: 10,
                        ),
                        locationContainer(),
                        SizedBox(
                          height: 10,
                        ),
                        expectedSalaryContainer(snapshot),
                        SizedBox(
                          height: 10,
                        ),
                        emailContainer(),
                        SizedBox(
                          height: 20,
                        ),
                        button(),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }

  ProgressButton button() {
    return ProgressButton(
      backgroundColor: purple,
      progressColor: white,
      child: buttonText('Create Job Alert'),
      buttonState: isLoading ? ButtonState.inProgress : ButtonState.normal,
      onPressed: () {
        if (_skillList.isEmpty) {
          showCustomSnackBar(title: 'Select Keywords', key: _scaffoldKey);
        } else if (_industryList.isEmpty) {
          showCustomSnackBar(title: 'Select Industry', key: _scaffoldKey);
        } else if (_categoryList.isEmpty) {
          showCustomSnackBar(title: 'Select Job Category', key: _scaffoldKey);
        } else if (_roleList.isEmpty) {
          showCustomSnackBar(title: 'Select Role', key: _scaffoldKey);
        } else if (_locationList.isEmpty) {
          showCustomSnackBar(title: 'Select Locations', key: _scaffoldKey);
        } else if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          setState(() {
            isLoading = true;
          });
          postJobAlert();
        }
      },
    );
  }

  Container emailContainer() {
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
          h1Text('Email'),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                color: grey, borderRadius: BorderRadius.circular(30)),
            child: TextFormField(
              validator: (val) {
                if (val.isEmpty) {
                  return 'Enter Email';
                }
              },
              onSaved: (val) {
                email = val;
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: grey1,
                  )),
            ),
          )
        ],
      ),
    );
  }

  Container expectedSalaryContainer(AsyncSnapshot<JobAlertModel> snapshot) {
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
                      controller: keySalaryController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(FeatherIcons.chevronDown),
                          hintText: 'Select Lakhs',
                          hintStyle: TextStyle(
                            color: grey1,
                          )),
                    ),
                    autoFlipDirection: true,
//                                  validator: (value) {
//                                    if (value.isEmpty) {
//                                      return 'Please Select Location';
//                                    }
//                                  },
                    onSuggestionSelected: (salary) {
                      print(salary.salaryLakhsId);
                      salaryID = salary.salaryLakhsId;
                      keySalaryController.text = salary.salaryLakhsName;
                    },
                    itemBuilder: (context, salary) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(salary.salaryLakhsName),
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
                      controller: keyThousandController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(FeatherIcons.chevronDown),
                          hintText: 'Select Thousands',
                          hintStyle: TextStyle(color: grey1)),
                    ),
                    autoFlipDirection: true,
//                                  validator: (value) {
//                                    if (value.isEmpty) {
//                                      return 'Please Select Location';
//                                    }
//                                  },
                    onSuggestionSelected: (thousand) {
                      thousandID = thousand.salaryThousandsId;
                      keyThousandController.text = thousand.salaryThousandsName;
                    },
                    itemBuilder: (context, thousand) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(thousand.salaryThousandsName),
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
          )
        ],
      ),
    );
  }

  locationContainer() {
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
          h1Text('Location'),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                color: grey, borderRadius: BorderRadius.circular(30)),
            child: FlutterTagging<Location>(
              textFieldConfiguration:
              TextFieldConfiguration(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Preferred Location')),
              configureChip: (loc) {
                return ChipConfiguration(
                    backgroundColor: pink,
                    label: Text(loc.jobLocationName),
                    deleteIconColor: white,
                    labelStyle: TextStyle(color: white));
              },
              configureSuggestion: (loc) {
                return SuggestionConfiguration(
                    title: Text(loc.jobLocationName));
              },
              initialItems: _locationList,
              hideOnError: true,
              findSuggestions: (pattern) async {
                return await postKeyLocation(
                    {'filter_location': pattern});
              },
            ),
          )
        ],
      ),
    );
  }
  Container nameContainer() {
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
          h1Text('Name'),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                color: grey, borderRadius: BorderRadius.circular(30)),
            child: TextFormField(
              validator: (val) {
                if (val.isEmpty) {
                  return 'Enter Name';
                }
              },
              onSaved: (val) {
                candidateName = val;
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Name',
                  hintStyle: TextStyle(
                    color: grey1,
                  )),
            ),
          )
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
            child: FlutterTagging<Role>(
              textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Role')),
              configureChip: (loc) {
                return ChipConfiguration(
                    backgroundColor: pink,
                    label: Text(loc.name),
                    deleteIconColor: white,
                    labelStyle: TextStyle(color: white));
              },
              configureSuggestion: (loc) {
                return SuggestionConfiguration(
                    title: Text(loc.name));
              },
              initialItems: _roleList,
              hideOnError: true,
              findSuggestions: (pattern) async {
                return await postKeyRole({'filter_role': pattern});
              },
              onChanged: () {},
            ),
          )
        ],
      ),
    );
  }

  jobCategoryContainer() {
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
          h1Text('Job Category'),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                color: grey, borderRadius: BorderRadius.circular(30)),
            child: FlutterTagging<JobCategory>(
              textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Role')),
              configureChip: (loc) {
                return ChipConfiguration(
                    backgroundColor: pink,
                    label: Text(loc.jobName),
                    deleteIconColor: white,
                    labelStyle: TextStyle(color: white));
              },
              configureSuggestion: (loc) {
                return SuggestionConfiguration(
                    title: Text(loc.jobName));
              },
              initialItems: _categoryList,
              hideOnError: true,
              findSuggestions: (pattern) async {
                return await postKeyCategory({'filter_category': pattern});
              },
              onChanged: () {},
            ),
          )
        ],
      ),
    );
  }

  industryContainer() {
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
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                color: grey, borderRadius: BorderRadius.circular(30)),
                child: FlutterTagging<Industry>(
                  textFieldConfiguration: TextFieldConfiguration(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Industry')),
                  configureChip: (loc) {
                    return ChipConfiguration(
                        backgroundColor: pink,
                        label: Text(loc.jobIndustryName),
                        deleteIconColor: white,
                        labelStyle: TextStyle(color: white));
                  },
                  configureSuggestion: (loc) {
                    return SuggestionConfiguration(
                        title: Text(loc.jobIndustryName));
                  },
                  initialItems: _industryList,
                  hideOnError: true,
                  findSuggestions: (pattern) async {
                    return await postKeyIndustry({'filter_industry': pattern});
                  },
                  onChanged: () {},
                ),
//            child: FlutterTagging(
//              chipsColor: Colors.pinkAccent,
//              chipsFontColor: Colors.white,
//              deleteIcon: Icon(Icons.cancel, color: Colors.white),
//              chipsPadding: EdgeInsets.all(2.0),
//              chipsFontSize: 14.0,
//              chipsSpacing: 5.0,
//              addButtonWidget: Container(),
//              suggestionsCallback: (pattern) async {
//                return await postKeyIndustry({'filter_industry': pattern});
//              },
//              hideOnError: true,
//              onChanged: (industry) async {
//                _industryList = industry;
//              },
//              textFieldDecoration: InputDecoration(
//                  border: InputBorder.none,
//                  hintText: 'Industry',
//                  hintStyle: TextStyle(
//                    color: grey1,
//                  )),
//            ),
          )
        ],
      ),
    );
  }

  Container workExperienceContainer(AsyncSnapshot<JobAlertModel> snapshot) {
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
          h1Text('Work Experience'),
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
                        keyboardType: TextInputType.numberWithOptions(),
                        controller: experienceController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Icon(FeatherIcons.chevronDown),
                            hintText: 'Select Years',
                            hintStyle: TextStyle(
                              color: grey1,
                            ))),
                    autoFlipDirection: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Select Years';
                      }
                    },
                    onSuggestionSelected: (experience) {
                      print(experience.experienceYearId);
                      experienceID = experience.experienceYearId;
                      experienceController.text = experience.experienceYearName;
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
                      keyboardType: TextInputType.numberWithOptions(),
                      controller: monthController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(FeatherIcons.chevronDown),
                          hintText: 'Select Months',
                          hintStyle: TextStyle(color: grey1)),
                    ),
                    autoFlipDirection: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Select Experience Months';
                      }
                    },
                    onSuggestionSelected: (experience) {
                      print(experience.experienceMonthId);
                      monthID = experience.experienceMonthId;
                      monthController.text = experience.experienceMonthName;
                    },
                    itemBuilder: (context, experience) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(experience.experienceMonthName),
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
          )
        ],
      ),
    );
  }

  keywordsContainer() {
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
          h1Text('Keywords'),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                color: grey, borderRadius: BorderRadius.circular(30)),
            child: FlutterTagging<Skill>(
              textFieldConfiguration:
              TextFieldConfiguration(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Key Skills')),
              configureChip: (skills) {
                return ChipConfiguration(
                    backgroundColor: pink,
                    label: Text(skills.name),
                    deleteIconColor: white,
                    labelStyle: TextStyle(color: white));
              },
              configureSuggestion: (skill) {
                return SuggestionConfiguration(
                    title: Text(skill.name));
              },
              hideOnEmpty: true,
              onChanged: () {},
              initialItems: _skillList,
              hideOnError: true,
              findSuggestions: (pattern) async {
                return await postKeySkills(
                    {'filter_skill': pattern});
              },
            ),
          )
        ],
      ),
    );
  }

  void postJobAlert() async {
    List<String> _skills = [];
    _skillList.forEach((val) => _skills.add(val.id));
    List<String> _locations = [];
    _locationList.forEach((val) => _locations.add(val.jobLocationId));
    List<String> _industries = [];
    _industryList.forEach((val) => _industries.add(val.jobIndustryId));
    List<String> _categories = [];
    _categoryList.forEach((val) => _categories.add(val.refJobCategoryId));
    List<String> _role = [];
    _roleList.forEach((val) => _role.add(val.id));

    var params = {
      'job_alert_details': jsonEncode([
        {
          'job_alert_name': candidateName,
          'job_alert_email': email,
          'job_alert_keyword': _skills.join(','),
          'job_alert_location': _locations.join(','),
          'job_alert_experience_year': experienceID,
          'job_alert_experience_month': monthID,
          'job_alert_expected_salary_lakhs': salaryID,
          'job_alert_expected_salary_thousands': thousandID,
          'job_alert_industry_id': _industries.join(','),
          'job_alert_job_category_id': _categories.join(','),
          'job_alert_job_role_id': _role.join(','),
        }
      ])
    };

    print(params);
    CommonResponseModel model = await saveJobAlert(params);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          if (model.status == 'success') {
            return customBackDialog(
                context: context,
                type: RichAlertType.SUCCESS,
                title: 'Job Alert successfully submitted',
                subtitle:
                    'You will get job notification soon\nrelated to your requirements');
          } else {
            setState(() {
              isLoading = false;
            });
            return customBackDialog(
                context: context,
                type: RichAlertType.ERROR,
                title: 'Error',
                subtitle: 'Try again Later');
          }
        });
  }
}
