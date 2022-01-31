import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sigmajobportal/models/candidate_education_model.dart';
import 'package:sigmajobportal/models/course_model.dart';
import 'package:sigmajobportal/models/degree_model.dart';
import 'package:sigmajobportal/models/personal_details_model.dart';
import 'package:sigmajobportal/repository.dart';
import 'package:sigmajobportal/utils.dart';

class EditEducationScreen extends StatefulWidget {
  final CandidateEducation candidateEducation;
  EditEducationScreen({Key key, this.candidateEducation}) : super(key: key);

  @override
  _EditEducationScreenState createState() => _EditEducationScreenState();
}

class _EditEducationScreenState extends State<EditEducationScreen> {
  Future _future;
  TextEditingController _graduationController;
  TextEditingController _degreeController;
  TextEditingController _specializationController;
  TextEditingController _yearOfPassingController;
  List<Degree> _degreeList = [];
  List<Course> _courseList = [];
  String graduationID, degreeID, specializationID, yearOfPassingID, institution;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _future = getCandidateEducation();
    _graduationController = new TextEditingController(text: widget.candidateEducation.graduationTypeName);
    _degreeController = new TextEditingController(text: widget.candidateEducation.degreeName);
    _specializationController = new TextEditingController(text: widget.candidateEducation.specializationName);
    _yearOfPassingController = new TextEditingController(text: widget.candidateEducation.yearOfPassingName);
    graduationID = widget.candidateEducation.refGraduationTypeId;
    degreeID = widget.candidateEducation.refDegreeId;
    specializationID = widget.candidateEducation.refSpecializationId;
    institution = widget.candidateEducation.candidateEducationInstitution;
    yearOfPassingID = widget.candidateEducation.refYearOfPassingId;
    populateList();
  }

  @override
  void dispose() {
    _graduationController.dispose();
    _degreeController.dispose();
    _specializationController.dispose();
    _yearOfPassingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: appbarMethod('Add education'),
      body: FutureBuilder<CandidateEducationModel>(
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              h1Text('Graduation'),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 12),
                                decoration: BoxDecoration(
                                    color: grey,
                                    borderRadius: BorderRadius.circular(30)),
                                child: TypeAheadFormField<Graduation>(
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    controller: _graduationController,
                                    decoration: InputDecoration(
                                        suffixIcon:
                                            Icon(FeatherIcons.chevronDown),
                                        border: InputBorder.none,
                                        hintText: 'Graduation',
                                        hintStyle: TextStyle(
                                          color: grey1,
                                        )),
                                  ),
                                  autoFlipDirection: true,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please Select Graduation';
                                    }
                                  },
                                  onSuggestionSelected: (graduation) async {
                                    graduationID = graduation.graduationTypeId;
                                    _graduationController.text =
                                        graduation.graduationTypeName;
                                    DegreeModel model = await getDegree(
                                        {'graduation_id': graduationID});
                                    _degreeList = model.degree;
                                  },
                                  itemBuilder: (context, graduation) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          Text(graduation.graduationTypeName),
                                    );
                                  },
                                  getImmediateSuggestions: true,
                                  suggestionsCallback: (pattern) {
                                    return snapshot.data.graduation
                                        .where((val) => val.graduationTypeName
                                            .toLowerCase()
                                            .contains(pattern.toLowerCase()))
                                        .toList();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              h1Text('Degree'),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 12),
                                decoration: BoxDecoration(
                                    color: grey,
                                    borderRadius: BorderRadius.circular(30)),
                                child: TypeAheadFormField<Degree>(
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    controller: _degreeController,
                                    decoration: InputDecoration(
                                        suffixIcon:
                                            Icon(FeatherIcons.chevronDown),
                                        border: InputBorder.none,
                                        hintText: 'Degree',
                                        hintStyle: TextStyle(
                                          color: grey1,
                                        )),
                                  ),
                                  autoFlipDirection: true,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please Select Degree';
                                    }
                                  },
                                  onSuggestionSelected: (degree) async {
                                    degreeID = degree.degreeId;
                                    _degreeController.text = degree.degreeName;
                                    CourseModel model = await getCourse({
                                      'degree_id': degreeID,
                                      'graduation_id': graduationID
                                    });
                                    _courseList = model.course;
                                  },
                                  itemBuilder: (context, degree) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(degree.degreeName),
                                    );
                                  },
                                  getImmediateSuggestions: true,
                                  suggestionsCallback: (pattern) {
                                    return _degreeList
                                        .where((val) => val.degreeName
                                            .toLowerCase()
                                            .contains(pattern.toLowerCase()))
                                        .toList();
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              h1Text('Specialization'),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 12),
                                decoration: BoxDecoration(
                                    color: grey,
                                    borderRadius: BorderRadius.circular(30)),
                                child: TypeAheadFormField<Course>(
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    controller: _specializationController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Specialization',
                                        hintStyle: TextStyle(
                                          color: grey1,
                                        )),
                                  ),
                                  autoFlipDirection: true,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please Select Specialization';
                                    }
                                  },
                                  onSuggestionSelected: (course) async {
                                    specializationID = course.specializationId;
                                    _specializationController.text =
                                        course.specializationName;
                                  },
                                  itemBuilder: (context, course) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(course.specializationName),
                                    );
                                  },
                                  getImmediateSuggestions: true,
                                  suggestionsCallback: (pattern) {
                                    return _courseList
                                        .where((val) => val.specializationName
                                            .toLowerCase()
                                            .contains(pattern.toLowerCase()))
                                        .toList();
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              h1Text('Institution'),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 12),
                                decoration: BoxDecoration(
                                    color: grey,
                                    borderRadius: BorderRadius.circular(30)),
                                child: TextFormField(
                                  initialValue: institution,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Enter Institution';
                                    }
                                  },
                                  onSaved: (val) {
                                    institution = val;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Institution',
                                      hintStyle: TextStyle(
                                        color: grey1,
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              h1Text('Year of Passing'),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 12),
                                decoration: BoxDecoration(
                                    color: grey,
                                    borderRadius: BorderRadius.circular(30)),
                                child: TypeAheadFormField<YearOfPassing>(
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    controller: _yearOfPassingController,
                                    decoration: InputDecoration(
                                        suffixIcon:
                                            Icon(FeatherIcons.chevronDown),
                                        border: InputBorder.none,
                                        hintText: 'Year of Passing',
                                        hintStyle: TextStyle(
                                          color: grey1,
                                        )),
                                  ),
                                  autoFlipDirection: true,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please Select Year of Passing';
                                    }
                                  },
                                  onSuggestionSelected: (yearOfPassing) async {
                                    yearOfPassingID =
                                        yearOfPassing.yearOfPassingId;
                                    _yearOfPassingController.text =
                                        yearOfPassing.yearOfPassingName;
                                  },
                                  itemBuilder: (context, yop) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(yop.yearOfPassingName),
                                    );
                                  },
                                  getImmediateSuggestions: true,
                                  suggestionsCallback: (pattern) {
                                    return snapshot.data.yearOfPassing
                                        .where((val) => val.yearOfPassingName
                                            .toLowerCase()
                                            .contains(pattern.toLowerCase()))
                                        .toList();
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: 300,
                          child: RaisedButton(
                            shape: buttonShape(30),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                Navigator.pop(
                                    context,
                                    CandidateEducation(
                                      graduationTypeName:
                                          _graduationController.text,
                                      candidateEducationInstitution:
                                          institution,
                                      yearOfPassingName:
                                          _yearOfPassingController.text,
                                      specializationName:
                                          _specializationController.text,
                                      refYearOfPassingId: yearOfPassingID,
                                      refSpecializationId: specializationID,
                                      refGraduationTypeId: graduationID,
                                      refDegreeId: degreeID,
                                      degreeName: _degreeController.text,
                                    ));
                              }
                            },
                            color: purple,
                            child: buttonText('Add education'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }

  void populateList() async {

    DegreeModel dModel = await getDegree(
        {'graduation_id': graduationID});
    _degreeList = dModel.degree;

    CourseModel model = await getCourse({
      'degree_id': degreeID,
      'graduation_id': graduationID
    });
    _courseList = model.course;
  }
}
