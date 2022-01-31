import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:sigmajobportal/models/get_dashboard_model.dart';
import 'package:sigmajobportal/models/location_model.dart';
import 'package:sigmajobportal/models/skills_model.dart';
import 'package:sigmajobportal/repository.dart';
import 'package:sigmajobportal/ui/job_list_screen.dart';
import 'package:sigmajobportal/utils.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TextEditingController keySkillsController = new TextEditingController();
  TextEditingController keyLocationController = new TextEditingController();
  TextEditingController keyExperienceController = new TextEditingController();
  TextEditingController keySalaryController = new TextEditingController();
  String skillID, locationID, experienceID = '', salaryID = '';
  String candidateName, baseURL;
  List<Skill> _skillList = [];
  List<Location> _locationList = [];

  @override
  void initState() {
    super.initState();
    getCandidateDetails();
  }

  @override
  void dispose() {
    keySkillsController.dispose();
    keyLocationController.dispose();
    keyExperienceController.dispose();
    keySalaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: purple,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: purple,
      ),
      body: FutureBuilder<GetDashboardModel>(
          future: getDashboard(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return errorWidget(context);
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Hello, $candidateName!',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: white),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Find the right job for you!',
                      style: TextStyle(fontSize: 16, color: white),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 12),
                                decoration: BoxDecoration(
                                  color: white,
                                ),
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
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 12),
                                decoration: BoxDecoration(
                                  color: white,
                                ),
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
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 12),
                                decoration: BoxDecoration(
                                  color: white,
                                ),
                                child: TypeAheadFormField<Experience>(
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    controller: keyExperienceController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Experience in Years',
                                    ),
                                  ),
                                  autoFlipDirection: true,
//                                  validator: (value) {
//                                    if (value.isEmpty) {
//                                      return 'Please Select Location';
//                                    }
//                                  },
                                  onSuggestionSelected: (experience) {
                                    print(experience.experienceYearId);
                                    experienceID = experience.experienceYearId;
                                    keyExperienceController.text =
                                        experience.experienceYearName;
                                  },
                                  itemBuilder: (context, experience) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          Text(experience.experienceYearName),
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
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 12),
                                decoration: BoxDecoration(
                                  color: white,
                                ),
                                child: TypeAheadFormField<Salary>(
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    controller: keySalaryController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Salary in Lakhs',
                                    ),
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
                                    keySalaryController.text =
                                        salary.salaryLakhsName;
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
                              SizedBox(
                                height: 15,
                              ),
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                color: lightYellow,
                                onPressed: () {
                                  if (_skillList.isEmpty &&
                                      _locationList.isEmpty) {
                                    showCustomSnackBar(
                                        key: scaffoldKey,
                                        title:
                                            'Please Select Atleast 1 Skill or Location');
                                  }
//                                  else if(_locationList.isEmpty){
//                                    showCustomSnackBar(key: scaffoldKey, title: 'Please Select Atleast 1 Location');
//                                  }
                                  else {
                                    List<String> skills = [];
                                    List<String> locations = [];
                                    _skillList.forEach((val) {
                                      skills.add(val.id);
                                    });
                                    if (_locationList.isNotEmpty)
                                      _locationList.forEach((val) {
                                        locations.add(val.jobLocationId);
                                      });
                                    var params = {
                                      'filter_data': jsonEncode([
                                        {
                                          'filter_skill': skills,
                                          'filter_location': locations,
                                          'filter_exp': experienceID,
                                          'filter_salary': salaryID
                                        }
                                      ])
                                    };
                                    push(
                                        context: context,
                                        pushReplacement: false,
                                        toWidget: JobListScreen(
                                          isCategory: false,
                                          params: params,
                                          baseURL: baseURL,
                                        ));
                                  }
                                },
                                textColor: white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 48, vertical: 8),
                                  child: Text(
                                    'Search',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }

  void getCandidateDetails() async {
    final storage = FlutterSecureStorage();
    candidateName = await storage.read(key: skCandidateName);
    baseURL = await storage.read(key: skBaseURL);
  }
}
