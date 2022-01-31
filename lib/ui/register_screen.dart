import 'dart:convert';

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sigmajobportal/models/common_response_model.dart';
import 'package:sigmajobportal/models/register_details_model.dart';
import 'package:sigmajobportal/repository.dart';
import 'package:sigmajobportal/ui/login_screen.dart';
import 'package:sigmajobportal/utils.dart';
import 'package:progress_button/progress_button.dart';
import 'package:rich_alert/rich_alert.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String username, email, mobileNumber, districtID, experienceID, monthID;
  TextEditingController districtController = new TextEditingController();
  TextEditingController experienceController = new TextEditingController();
  TextEditingController monthController = new TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    districtController.dispose();
    experienceController.dispose();
    monthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: grey,
        body: FutureBuilder<RegisterDetailsModel>(
            future: getRegisterDetails(),
            builder: (context, snapshot) {
              print('snap -${snapshot.data}');
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return errorWidget(context);
              } else {
                if (snapshot.data.status == 'success') {
                  return Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(8),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/register.png',
                              height: MediaQuery.of(context).size.height / 3,
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(left: 12),
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(30)),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Icon(FeatherIcons.user),
                                  hintText: 'Name',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter Name';
                                  }
                                },
                                onSaved: (value) {
                                  username = value;
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(left: 12),
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(30)),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Icon(FeatherIcons.mail),
                                  hintText: 'E-Mail',
                                ),
                                onEditingComplete: () {
                                  print('editing completed');
                                },
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter E-Mail';
                                  }else if(!value.contains('.') && !value.contains('@')){
                                    return 'Invalid Email-Id';
                                  }else{
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  email = value;
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(left: 12),
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(30)),
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Icon(FeatherIcons.smartphone),
                                  hintText: 'Mobile Number',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter Mobile Number';
                                  }else if(value.length != 10){
                                    return 'Invalid Mobile Number';
                                  }else{
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  mobileNumber = value;
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(left: 12),
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(30)),
                              child: TypeAheadFormField<District>(
                                textFieldConfiguration: TextFieldConfiguration(
                                  controller: districtController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: Icon(FeatherIcons.mapPin),
                                    hintText: 'Current Location',
                                  ),
                                ),
                                autoFlipDirection: true,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Select Location';
                                  }
                                },
                                onSuggestionSelected: (district) {
                                  print(district.districtId);
                                  districtID = district.districtId;
                                  districtController.text =
                                      district.districtName;
                                },
                                itemBuilder: (context, district) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(district.districtName),
                                  );
                                },
                                getImmediateSuggestions: true,
                                suggestionsCallback: (pattern) {
                                  return snapshot.data.district
                                      .where((val) => val.districtName
                                          .toLowerCase()
                                          .contains(pattern.toLowerCase()))
                                      .toList();
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 12),
                                    decoration: BoxDecoration(
                                        color: white,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: TypeAheadFormField<Experience>(
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                        keyboardType:
                                            TextInputType.numberWithOptions(),
                                        controller: experienceController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Experience Years',
                                        ),
                                      ),
                                      autoFlipDirection: true,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please Select Experience Years';
                                        }
                                      },
                                      onSuggestionSelected: (experience) {
                                        print(experience.experienceYearId);
                                        experienceID =
                                            experience.experienceYearId;
                                        experienceController.text =
                                            experience.experienceYearName;
                                      },
                                      itemBuilder: (context, experience) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              experience.experienceYearName),
                                        );
                                      },
                                      getImmediateSuggestions: true,
                                      suggestionsCallback: (pattern) {
                                        return snapshot.data.experience
                                            .where((val) => val
                                                .experienceYearName
                                                .toLowerCase()
                                                .contains(
                                                    pattern.toLowerCase()))
                                            .toList();
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 12),
                                    decoration: BoxDecoration(
                                        color: white,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: TypeAheadFormField<Month>(
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                        keyboardType:
                                            TextInputType.numberWithOptions(),
                                        controller: monthController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Experience Months',
                                        ),
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
                                        monthController.text =
                                            experience.experienceMonthName;
                                      },
                                      itemBuilder: (context, experience) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              experience.experienceMonthName),
                                        );
                                      },
                                      getImmediateSuggestions: true,
                                      suggestionsCallback: (pattern) {
                                        return snapshot.data.months
                                            .where((val) => val
                                                .experienceMonthName
                                                .toLowerCase()
                                                .contains(
                                                    pattern.toLowerCase()))
                                            .toList();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
/*                            Container(
                              width: double.infinity,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    formKey.currentState.save();
                                    postRegistration();
                                  }
                                },
                                color: purple,
                                child: buttonText('Register'),
                              ),
                            )*/
                            ProgressButton(
                              backgroundColor: purple,
                              progressColor: white,
                              child: buttonText('Register'),
                              buttonState: isLoading ? ButtonState.inProgress : ButtonState.normal,
                              onPressed: () async {
                                if (formKey.currentState.validate()) {
                                  formKey.currentState.save();
                                  setState(() {
                                    isLoading = true;
                                  });
                                  postRegistration();
                                }
                              },
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Already have an account?',
                                  style: TextStyle(color: violet, fontSize: 16),
                                ),
                                FlatButton(
                                    onPressed: () {
                                      push(
                                          context: context,
                                          pushReplacement: true,
                                          toWidget: LoginScreen());
                                    },
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(color: purple, fontSize: 16),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text('Error'),
                  );
                }
              }
            }));
  }

  void postRegistration() async {
    var usernameParams = {
      'user_name': email,
    };

    CommonResponseModel usernameModel = await checkUsername(usernameParams);

    if (usernameModel.response == '1') {
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (context) {
            return customBackDialog(
              context: context,
              type: RichAlertType.WARNING,
              title: 'E-Mail Already Exists',
              subtitle: 'Try Other E-Mail ID',
              doubleBack: false,
            );
          });
    } else {
      var params = {
        'candidate_details': jsonEncode([
          {
            'candidate_name': username,
            'ref_job_location_id': districtID,
            'candidate_mobile': mobileNumber,
            'ref_experience_year_id': experienceID,
            'ref_experience_month_id': monthID,
            'candidate_username': email,
            'tbl_contact_email': jsonEncode([
              {'contact_email': email}
            ]),
            'tbl_contact_detail': jsonEncode([
              {'contact_number': mobileNumber}
            ]),
          }
        ])
      };
      CommonResponseModel model = await postRegistrationDetials(params);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            if (model.status == 'success') {
              return customBackDialog(
                  context: context,
                  isRestartApp: true,
                  type: RichAlertType.SUCCESS,
                  title: 'Registration Successful',
                  subtitle:
                      'Username and Password will be sent\nto your registered E-Mail ID');
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
}
