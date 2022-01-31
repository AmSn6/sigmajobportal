import 'dart:convert';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:sigmajobportal/models/common_response_model.dart';
import 'package:sigmajobportal/models/contact_type_model.dart';
import 'package:sigmajobportal/models/personal_details_model.dart';
import 'package:sigmajobportal/repository.dart';
import 'package:sigmajobportal/ui/add_education_screen.dart';
import 'package:sigmajobportal/ui/add_experience_screen.dart';
import 'package:sigmajobportal/ui/edit_address_screen.dart';
import 'package:sigmajobportal/ui/edit_education_screen.dart';
import 'package:sigmajobportal/ui/edit_experience_screen.dart';
import 'package:sigmajobportal/ui/edit_job_details_screen.dart';
import 'package:sigmajobportal/ui/edit_key_skills_screen.dart';
import 'package:sigmajobportal/ui/edit_personal_details_screen.dart';
import 'package:sigmajobportal/ui/edit_preffered_location_screen.dart';
import 'package:sigmajobportal/utils.dart';
import 'package:progress_button/progress_button.dart';
import 'package:rich_alert/rich_alert.dart';

class ResumeScreen extends StatefulWidget {
  ResumeScreen({Key key}) : super(key: key);

  @override
  _ResumeScreenState createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  String description;
  String mobile;
  String email;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  Future _future;
  TextEditingController _contactTypeValueCntlr = new TextEditingController();
  String contactTypeValueID, baseURL;
  bool _reset = false;
  bool isLoading = false;
  List<String> _skillsIDList = [], _locationIdList = [];

  @override
  void initState() {
    super.initState();
    setBaseURL();
    _future = getPersonalDetails();
  }

  @override
  void dispose() {
    _contactTypeValueCntlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      backgroundColor: grey,
      appBar: appbarMethod('My Resume'),
      body: FutureBuilder<PersonalDetailModel>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              print('error - ${snapshot.error}');
              return errorWidget(context);
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      personalDetailContainer(snapshot, context),
                      SizedBox(
                        height: 10,
                      ),
                      aboutMeContainer(context, snapshot),
                      SizedBox(
                        height: 10,
                      ),
                      myExperienceContainer(context, snapshot),
                      SizedBox(
                        height: 10,
                      ),
                      myEducationContainer(context, snapshot),
                      SizedBox(
                        height: 10,
                      ),
                      jobDetailsContainer(context, snapshot),
                      SizedBox(
                        height: 10,
                      ),
                      keySkillsContainer(snapshot),
                      SizedBox(
                        height: 10,
                      ),
                      locationContainer(snapshot),
                      SizedBox(
                        height: 10,
                      ),
                      addressContainer(context, snapshot),
                      SizedBox(
                        height: 10,
                      ),
                      contactNumberContainer(snapshot, context),
                      SizedBox(
                        height: 10,
                      ),
                      contactEmailContainer(context, snapshot),
                      SizedBox(
                        height: 20,
                      ),
                    //  updateResumeButton(snapshot),
                      ProgressButton(
                        backgroundColor: purple,
                        progressColor: white,
                        child: buttonText('Update Resume'),
                        buttonState: isLoading ? ButtonState.inProgress : ButtonState.normal,
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          postUpdateResume(snapshot);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }

  Container keySkillsContainer(AsyncSnapshot<PersonalDetailModel> snapshot) {
    print('skill -${snapshot.data.keyskill.length}');

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: h1Text('Key Skills'),
            trailing: IconButton(
                icon: Icon(
                  FeatherIcons.edit2,
                  size: 18,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditKeySkillsScreen(
                                skills: snapshot.data.keyskill,
                              ))).then((val) {
                    if (val != null) {

//                      List<Keyskill> _skills = [];
//                      val.forEach((val) {
//                        _skills.add(val['name']);
//                        _skillsIDList.add(val['value']);
//                      });
                      setState(() {
                        _reset = false;
                        snapshot.data.keyskill = val;
                        print('length - ${snapshot.data.keyskill.length}');
                      });
                    }
                  });
                }),
          ),
          if (snapshot.data.keyskill.isNotEmpty || snapshot.data.candidateDetails[0].candidateKeySkills.isNotEmpty)
            ListTile(
              title: Wrap(
                runSpacing: 5,
                spacing: 5,
                children: snapshot.data.keyskill.map((skill) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                        color: pink,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          child: Text(
                           '${skill.keySkillsName}',
                            style: TextStyle(color: white),
                          ),
                        )),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Container locationContainer(AsyncSnapshot<PersonalDetailModel> snapshot) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: h1Text('Preffered Location'),
            trailing: IconButton(
                icon: Icon(
                  FeatherIcons.edit2,
                  size: 18,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditPrefferedLocationScreen(
                                skills: snapshot.data.pLocation,
                              ))).then((val) {
                    if (val != null) {
//                      List<String> _skills = [];
//                      val.forEach((val) {
//                        _skills.add(val['name']);
//                        _locationIdList.add(val['value']);
//                      });
                      setState(() {
                        snapshot.data.pLocation = val;
                      });
                    }
                  });
                }),
          ),
          if (snapshot.data.pLocation.isNotEmpty || snapshot.data.candidateDetails[0].candidateKeySkills.isNotEmpty)
            ListTile(
              title: Wrap(
                runSpacing: 5,
                spacing: 5,
                children: snapshot.data.pLocation.map((skill) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                        color: pink,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          child: Text(
                            skill.jobLocationName,
                            style: TextStyle(color: white),
                          ),
                        )),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

 /* SizedBox updateResumeButton(AsyncSnapshot<PersonalDetailModel> snapshot) {
    return SizedBox(
      height: 50,
      width: 300,
      child: RaisedButton(
        shape: buttonShape(30),
        onPressed: () {
          postUpdateResume(snapshot);
        },
        color: purple,
        child: buttonText('Update Resume'),
      ),
    );
  }
*/
  Container contactEmailContainer(
      BuildContext context, AsyncSnapshot<PersonalDetailModel> snapshot) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 8),

            child: SizedBox(
              height: 25,
              child: Row(
                children: [
                  h1Text('Contact Emails'),
                  Spacer(),
                  IconButton(
                      onPressed: () async {
                        return addEmailDialog(context, snapshot);
                      },
                      icon: Icon(
                        FeatherIcons.plusCircle,
                        color: grey1,
                        size: 18,
                      ))

                ],
              ),
            ),
          ),
          // ListTile(
          //   title: h1Text('Contact Emails'),
          //   trailing: IconButton(
          //       onPressed: () {
          //         return addEmailDialog(context, snapshot);
          //       },
          //       icon: Icon(
          //         FeatherIcons.plusCircle,
          //         size: 18,
          //         color: grey1,
          //       )),
          // ),
          if (snapshot.data.emailIds.isNotEmpty)
            ListView.separated(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return contactEmailItem(snapshot, index, context);
                },
                separatorBuilder: (context, index) => SizedBox(height: 5,),
                itemCount: snapshot.data.emailIds.length),
        ],
      ),
    );
  }

  Container contactNumberContainer(
      AsyncSnapshot<PersonalDetailModel> snapshot, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 8),

            child: SizedBox(
              height: 25,
              child: Row(
                children: [
                  h1Text('Contact Numbers'),
                  Spacer(),
                  IconButton(
                      onPressed: () async {
                        return await addContactNumberDialog(snapshot, context);
                      },
                      icon: Icon(
                        FeatherIcons.plusCircle,
                        color: grey1,
                        size: 18,
                      ))
                  // ListTile(
                  //   title: h1Text('Contact Numbers'),
                  //   trailing: IconButton(
                  //       onPressed: () async {
                  //         return await addContactNumberDialog(snapshot, context);
                  //       },
                  //       icon: Icon(
                  //         FeatherIcons.plusCircle,
                  //         color: grey1,
                  //         size: 18,
                  //       )),
                  // ),
                ],
              ),
            ),
          ),
          if (snapshot.data.contactNumbers.isNotEmpty)
            ListView.separated(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return contactNumberItem(snapshot, index, context);
                },
                separatorBuilder: (context, index) => SizedBox(height: 5,),
                itemCount: snapshot.data.contactNumbers.length)
        ],
      ),
    );
  }

  Container myEducationContainer(
      BuildContext context, AsyncSnapshot<PersonalDetailModel> snapshot) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          ListTile(
            title: h1Text('My Education'),
            trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddEducationScreen()))
                      .then((val) {
                    if (val != null)
                      setState(() {
                        _reset = false;
                        snapshot.data.candidateEducation.add(val);
                      });
                  });
                },
                icon: Icon(
                  FeatherIcons.plusCircle,
                  color: grey1,
                  size: 18,
                )),
          ),
          if (snapshot.data.candidateEducation.isNotEmpty)
            ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: snapshot.data.candidateEducation.length,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return educationItem(snapshot, index, context);
                })
        ],
      ),
    );
  }

  Container myExperienceContainer(
      BuildContext context, AsyncSnapshot<PersonalDetailModel> snapshot) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          ListTile(
            title: h1Text('My Experience'),
            trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddExperienceScreen()))
                      .then((val) {
                    if (val != null) {
                      setState(() {
                        _reset = false;
                        snapshot.data.candidateExperience.add(val);
                      });
                    }
                  });
                },
                icon: Icon(
                  FeatherIcons.plusCircle,
                  color: grey1,
                  size: 18,
                )),
          ),
          if (snapshot.data.candidateExperience.isNotEmpty)
            ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: snapshot.data.candidateExperience.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return experienceItem(snapshot, index, context);
                }),
        ],
      ),
    );
  }

  Container aboutMeContainer(
      BuildContext context, AsyncSnapshot<PersonalDetailModel> snapshot) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: h1Text('About Me'),
            trailing: IconButton(
                onPressed: () {
                  return editAboutMeDialog(snapshot, context);
                },
                icon: Icon(
                  FeatherIcons.edit2,
                  color: grey1,
                  size: 18,
                )),
          ),
          ListTile(
            subtitle:
                h2Text(snapshot.data.candidateDetails[0].candidateDescription),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Container jobDetailsContainer(
      BuildContext context, AsyncSnapshot<PersonalDetailModel> snapshot) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: h1Text('Job Detiails'),
            trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditJobDetailsScreen(
                                candidateDetails:
                                    snapshot.data.candidateDetails[0],
                              ))).then((val) {
                    if (val != null) {
                      if (val) {
                        setState(() {
                          _future = getPersonalDetails();
                        });
                      }
                    }
                  });
                },
                icon: Icon(
                  FeatherIcons.edit2,
                  color: grey1,
                  size: 18,
                )),
          ),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                customText('Industry',
                    snapshot.data.candidateDetails[0].jobIndustryName),
                customText('Functional Area',
                    snapshot.data.candidateDetails[0].jobCategoryName),
                customText(
                    'Role', snapshot.data.candidateDetails[0].jobRoleName),
                customText(
                    'Experience',
                    snapshot.data.candidateDetails[0].experienceYearName +
                        ' Year & ' +
                        snapshot.data.candidateDetails[0].experienceMonthName +
                        ' Months'),
                customText(
                    'Current Salary',
                    snapshot.data.candidateDetails[0].currentSalaryLakhsId +
                        ' Lakhs & ' +
                        snapshot
                            .data.candidateDetails[0].currentSalaryThousandsId +
                        ' Thousand'),
                customText(
                    'Expected Salary',
                    snapshot.data.candidateDetails[0].expectedSalaryLakhsId +
                        ' Lakhs & ' +
                        snapshot.data.candidateDetails[0]
                            .expectedSalaryThousandsId +
                        ' Thousand'),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Container addressContainer(
      BuildContext context, AsyncSnapshot<PersonalDetailModel> snapshot) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: h1Text('Permanent Address'),
            trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditAddressScreen(
                                addressLine1: snapshot
                                    .data.candidateDetails[0].candidateAddress1,
                                addressLine2: snapshot
                                    .data.candidateDetails[0].candidateAddress2,
                                countryName: snapshot
                                    .data.candidateDetails[0].countryName,
                                countryID: snapshot
                                    .data.candidateDetails[0].refCountryId,
                                stateName:
                                    snapshot.data.candidateDetails[0].stateName,
                                stateID: snapshot
                                    .data.candidateDetails[0].refStateId,
                                districtName: snapshot
                                    .data.candidateDetails[0].districtName,
                                districtID: snapshot
                                    .data.candidateDetails[0].refDistrictId,
                                pincode: snapshot
                                    .data.candidateDetails[0].candidatePincode,
                              ))).then((val) {
                    if (val != null) {
                      setState(() {
                        snapshot.data.candidateDetails[0].candidateAddress1 =
                            val.addressLine1;
                        snapshot.data.candidateDetails[0].candidateAddress2 =
                            val.addressLine2;
                        snapshot.data.candidateDetails[0].countryName =
                            val.countryName;
                        snapshot.data.candidateDetails[0].refCountryId =
                            val.countryID;
                        snapshot.data.candidateDetails[0].stateName =
                            val.stateName;
                        snapshot.data.candidateDetails[0].refStateId =
                            val.stateID;
                        snapshot.data.candidateDetails[0].districtName =
                            val.districtName;
                        snapshot.data.candidateDetails[0].refDistrictId =
                            val.districtID;
                        snapshot.data.candidateDetails[0].candidatePincode =
                            val.pincode;
                      });
                    }
                  });
                },
                icon: Icon(
                  FeatherIcons.edit2,
                  color: grey1,
                  size: 18,
                )),
          ),
          ListTile(
            subtitle: h2Text(
                snapshot.data.candidateDetails[0].candidateAddress1 +
                    '\n' +
                    snapshot.data.candidateDetails[0].candidateAddress2 +
                    '\n' +
                    snapshot.data.candidateDetails[0].countryName +
                    '\n' +
                    snapshot.data.candidateDetails[0].stateName +
                    '\n' +
                    snapshot.data.candidateDetails[0].districtName +
                    '\n' +
                    snapshot.data.candidateDetails[0].candidatePincode),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Future editAboutMeDialog(
      AsyncSnapshot<PersonalDetailModel> snapshot, BuildContext context) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: h1Text('About me'),
          content: Form(
            key: formKey,
            child: TextFormField(
              maxLines: 6,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Enter Description',
              ),
              initialValue:
                  snapshot.data.candidateDetails[0].candidateDescription,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Details';
                }
              },
              onSaved: (value) {
                description = value;
              },
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              color: red,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
              textColor: white,
            ),
            RaisedButton(
              color: lightYellow,
              onPressed: () {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  setState(() {
                    _reset = false;
                    snapshot.data.candidateDetails[0].candidateDescription =
                        description;
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
              textColor: white,
            )
          ],
        );
      },
      context: context,
    );
  }

  Container personalDetailContainer(
      AsyncSnapshot<PersonalDetailModel> snapshot, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                    radius: 30,
                    backgroundColor: purple,
                    child: snapshot.data.candidateDetails[0].candidateImage.isEmpty || snapshot.data.candidateDetails[0].candidateImage ==
                            '-'
                        ? Text(
                            snapshot.data.candidateDetails[0].candidateName[0],
                            style: TextStyle(
                                color: white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )
                        : imageWidget(
                            baseURL +
                                snapshot
                                    .data.candidateDetails[0].candidateImage,
                            100)),
                SizedBox(
                  height: 10,
                ),
                h1Text(snapshot.data.candidateDetails[0].salutationName +
                    " " +
                    snapshot.data.candidateDetails[0].candidateName),
                Text(
                  snapshot.data.candidateDetails[0].candidateUsername +
                      "\nDate of Birth - " +
                      DateFormat('dd MMM, yyyy').format(
                          snapshot.data.candidateDetails[0].candidateDob),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditPersonalDetailsScreen(
                                candidateDetails:
                                    snapshot.data.candidateDetails[0],
                            baseURL: baseURL,
                              ))).then((val) {
                    if (val != null) {
                      if (val) {
                        setState(() {
                          _future = getPersonalDetails();
                        });
                      } else {
                        showCustomSnackBar(
                            key: scaffoldState,
                            title: 'Error While Updating Profile. Try Again Later');
                      }
                    }
                  });
                },
                icon: Icon(
                  FeatherIcons.edit2,
                  color: grey1,
                  size: 18,
                )),
          )
        ],
      ),
    );
  }

  addContactNumberDialog(
      AsyncSnapshot<PersonalDetailModel> snapshot, BuildContext context) async {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: h1Text('Contact Numbers'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TypeAheadFormField<Contact>(
                  onSuggestionSelected: (value) {
                    contactTypeValueID = value.contactNumberTypeId;
                    _contactTypeValueCntlr.text = value.contactNumberTypeName;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Select Contact Type';
                    }
                  },
                  itemBuilder: (context, type) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(type.contactNumberTypeName),
                    );
                  },
                  getImmediateSuggestions: true,
                  autoFlipDirection: true,
                  suggestionsCallback: (pattern) async {
                    return await getContactType();
                  },
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _contactTypeValueCntlr,
                    decoration: InputDecoration(
                      hintText: 'Contact Type',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter Mobile Number',
                  ),
                  keyboardType: TextInputType.phone,
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
                    mobile = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              color: red,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
              textColor: white,
            ),
            RaisedButton(
              color: lightYellow,
              onPressed: () {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  setState(() {
                    _reset = false;
                    snapshot.data.contactNumbers.add(ContactNumber(
                        contactNumber: mobile,
                        contactNumberTypeName: _contactTypeValueCntlr.text,
                        refContactNumberTypeId: contactTypeValueID));
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
              textColor: white,
            )
          ],
        );
      },
      context: context,
    );
  }

  Future addEmailDialog(
      BuildContext context, AsyncSnapshot<PersonalDetailModel> snapshot) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: h1Text('Contact Emails'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Email Address';
                    }
                  },
                  onSaved: (value) {
                    email = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              color: red,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
              textColor: white,
            ),
            RaisedButton(
              color: lightYellow,
              onPressed: () {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  setState(() {
                    _reset = false;
                    snapshot.data.emailIds.add(EmailId(contactEmail: email));
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
              textColor: white,
            )
          ],
        );
      },
      context: context,
    );
  }

  Widget contactEmailItem(AsyncSnapshot<PersonalDetailModel> snapshot,
      int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 8),
      child: SizedBox(
        height: 25,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            h2Text('${snapshot.data.emailIds[index].contactEmail}'),
            Spacer(),
            IconButton(
                onPressed: () async {
                  return emailEditDialog(snapshot, index, context);
                },
                icon: Icon(
                  FeatherIcons.edit2,
                  color: grey1,
                  size: 18,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    _reset = false;
                    snapshot.data.emailIds.removeAt(index);
                  });
                },
                icon: Icon(
                  FeatherIcons.x,
                  color: grey1,
                  size: 18,
                )),
          ],
        ),
      ),
    );
    // return ListTile(
    //   title: h2Text('${snapshot.data.emailIds[index].contactEmail}'),
    //   trailing: Row(
    //     mainAxisSize: MainAxisSize.min,
    //     children: <Widget>[
    //       IconButton(
    //           onPressed: () {
    //             return emailEditDialog(snapshot, index, context);
    //           },
    //           icon: Icon(
    //             FeatherIcons.edit2,
    //             size: 18,
    //             color: grey1,
    //           )),
    //       IconButton(
    //           onPressed: () {
    //             setState(() {
    //               _reset = false;
    //               snapshot.data.emailIds.removeAt(index);
    //             });
    //           },
    //           icon: Icon(
    //             FeatherIcons.x,
    //             size: 18,
    //             color: grey1,
    //           )),
    //     ],
    //   ),
    // );
  }

  Future emailEditDialog(AsyncSnapshot<PersonalDetailModel> snapshot, int index,
      BuildContext context) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: h1Text('Contact Email'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                  initialValue: snapshot.data.emailIds[index].contactEmail,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Email Address';
                    }
                  },
                  onSaved: (value) {
                    email = value;
                  },
                )
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              color: red,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
              textColor: white,
            ),
            RaisedButton(
              color: lightYellow,
              onPressed: () {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  setState(() {
                    _reset = false;
                    snapshot.data.emailIds[index].contactEmail = email;
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Edit'),
              textColor: white,
            )
          ],
        );
      },
      context: context,
    );
  }

  Widget contactNumberItem(AsyncSnapshot<PersonalDetailModel> snapshot,
      int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 8),
      child: SizedBox(
        height: 25,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            h2Text(
                '${snapshot.data.contactNumbers[index].contactNumberTypeName} - ${snapshot.data.contactNumbers[index].contactNumber}'),
            Spacer(),
            IconButton(
                onPressed: () async {
                  return await editContactNumberDialog(snapshot, index, context);
                },
                icon: Icon(
                  FeatherIcons.edit2,
                  color: grey1,
                  size: 18,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    _reset = false;
                    snapshot.data.contactNumbers.removeAt(index);
                  });
                },
                icon: Icon(
                  FeatherIcons.x,
                  color: grey1,
                  size: 18,
                )),
          ],
        ),
      ),
    );
  }

  editContactNumberDialog(AsyncSnapshot<PersonalDetailModel> snapshot,
      int index, BuildContext context) async {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: h1Text('Contact Numbers'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TypeAheadFormField<Contact>(
                  onSuggestionSelected: (value) {
                    contactTypeValueID = value.contactNumberTypeId;
                    _contactTypeValueCntlr.text = value.contactNumberTypeName;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Select Contact Type';
                    }
                  },
                  itemBuilder: (context, type) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(type.contactNumberTypeName),
                    );
                  },
//                  initialValue: snapshot.data.contactNumbers[index].contactNumberTypeName,
                  getImmediateSuggestions: true,
                  autoFlipDirection: true,
                  suggestionsCallback: (pattern) async {
                    return await getContactType();
                  },
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _contactTypeValueCntlr,
                    decoration: InputDecoration(
                      hintText: 'Contact Type',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter Mobile Number',
                  ),
                  initialValue:
                      snapshot.data.contactNumbers[index].contactNumber,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Mobile Number';
                    }
                  },
                  onSaved: (value) {
                    mobile = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              color: red,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
              textColor: white,
            ),
            RaisedButton(
              color: lightYellow,
              onPressed: () {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  setState(() {
                    _reset = false;
                    snapshot.data.contactNumbers[index] = ContactNumber(
                        refContactNumberTypeId: contactTypeValueID,
                        contactNumberTypeName: _contactTypeValueCntlr.text,
                        contactNumber: mobile);
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Edit'),
              textColor: white,
            )
          ],
        );
      },
      context: context,
    );
  }

  ListTile educationItem(AsyncSnapshot<PersonalDetailModel> snapshot, int index,
      BuildContext context) {
    return ListTile(
      title: h1Text(snapshot
          .data.candidateEducation[index].candidateEducationInstitution),
      subtitle: Text(
          '${snapshot.data.candidateEducation[index].degreeName}\n${snapshot.data.candidateEducation[index].graduationTypeName}\n${snapshot.data.candidateEducation[index].yearOfPassingName}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditEducationScreen(
                              candidateEducation:
                                  snapshot.data.candidateEducation[index],
                            ))).then((val) {
                  if (val != null)
                    setState(() {
                      _reset = false;
                      snapshot.data.candidateEducation[index] = val;
                    });
                });
              },
              icon: Icon(
                FeatherIcons.edit2,
                color: grey1,
                size: 18,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  _reset = false;
                  snapshot.data.candidateEducation.removeAt(index);
                });
              },
              icon: Icon(
                FeatherIcons.x,
                color: grey1,
                size: 18,
              )),
        ],
      ),
    );
  }

  ListTile experienceItem(AsyncSnapshot<PersonalDetailModel> snapshot,
      int index, BuildContext context) {
    return ListTile(
      title: h1Text(snapshot
          .data.candidateExperience[index].candidateExperienceDesignation),
      subtitle: Text(
          '${DateFormat('MMM yyyy').format(snapshot.data.candidateExperience[index].candidateExperienceDateFrom)} - ${DateFormat('MMM yyyy').format(snapshot.data.candidateExperience[index].candidateExperienceDateTo)}' +
              '\n' +
              snapshot
                  .data.candidateExperience[index].candidateExperienceCompany +
              '\n' +
              snapshot
                  .data.candidateExperience[index].candidateExperienceProfile),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditExperienceScreen(
                              candidateExperience:
                                  snapshot.data.candidateExperience[index],
                            ))).then((val) {
                  if (val != null) {
                    setState(() {
                      _reset = false;
                      snapshot.data.candidateExperience[index] = val;
                    });
                  }
                });
              },
              icon: Icon(
                FeatherIcons.edit2,
                color: grey1,
                size: 18,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  _reset = false;
                  snapshot.data.candidateExperience.removeAt(index);
                });
              },
              icon: Icon(
                FeatherIcons.x,
                color: grey1,
                size: 18,
              )),
        ],
      ),
    );
  }

  Widget customText(String title, String value) {
    return Column(
      children: <Widget>[
        RichText(
            text: TextSpan(children: [
          TextSpan(
            text: '$title : \n',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: violet,
                fontFamily: 'Calibri',
                fontSize: 16),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
                color: Colors.grey, fontFamily: 'Calibri', fontSize: 16),
          )
        ])),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  void setBaseURL() async {
    final storage = FlutterSecureStorage();
    baseURL = await storage.read(key: skBaseURL);
  }

  void postUpdateResume(AsyncSnapshot<PersonalDetailModel> snapshot) async {

    List<String> _skills = [], _locations = [];
    snapshot.data.keyskill.forEach((val){
      _skills.add(val.keySkillsId);
    });
    snapshot.data.pLocation.forEach((val){
      _locations.add(val.jobLocationId);
    });
    Map<String, String> params = {
      'contact_number': jsonEncode(snapshot.data.contactNumbers.map((val) {
        return {
          'ref_contact_number_type_id': val.refContactNumberTypeId,
          'contact_number': val.contactNumber
        };
      }).toList()),
      'contact_email': jsonEncode(snapshot.data.emailIds.map((val) {
        return {'contact_email': val.contactEmail};
      }).toList()),
      'candidate_experience': jsonEncode(
        snapshot.data.candidateExperience.map((val) {
          return {
            'candidate_experience_company': val.candidateExperienceCompany,
            'candidate_experience_designation':
                val.candidateExperienceDesignation,
            'candidate_experience_date_from': DateFormat('yyyy-MM-dd')
                .format(val.candidateExperienceDateFrom),
            'candidate_experience_date_to':
                DateFormat('yyyy-MM-dd').format(val.candidateExperienceDateTo),
            'candidate_experience_profile': val.candidateExperienceProfile,
          };
        }).toList(),
      ),
      'candidate_education':
          jsonEncode(snapshot.data.candidateEducation.map((val) {
        return {
          'ref_graduation_type_id': val.refGraduationTypeId,
          'ref_degree_id': val.refDegreeId,
          'ref_specialization_id': val.refSpecializationId,
          'candidate_education_institution': val.candidateEducationInstitution,
          'ref_year_of_passing_id': val.refYearOfPassingId
        };
      }).toList()),
      'candidate_details': jsonEncode([
        {
          'candidate_description':
              snapshot.data.candidateDetails[0].candidateDescription,
          'candidate_key_skills': _skills.join(','),
          'candidate_preferred_location': _locations.join(','),
          'candidate_address1':
              snapshot.data.candidateDetails[0].candidateAddress1,
          'candidate_address2':
              snapshot.data.candidateDetails[0].candidateAddress2,
          'ref_district_id': snapshot.data.candidateDetails[0].refDistrictId,
          'candidate_pincode':
              snapshot.data.candidateDetails[0].candidatePincode,
          'ref_candidate_id': snapshot.data.candidateDetails[0].candidateId,
        }
      ])
    };

//    print('skills - $skills');

//    print('candidate - ${params['contact_number']}');
//    print('candidate - ${params['contact_email']}');
//    print('candidate - ${params['candidate_experience']}');
//    print('candidate - ${params['candidate_education']}');
//    print('candidate - ${params['candidate_details']}');
    CommonResponseModel model = await postCandidatePersonal(params);
    showDialog(context: context,builder: (context){
      if (model.response == "1") {
        return customBackDialog(context: context, type: RichAlertType.SUCCESS,title: 'Success',subtitle: 'Your Profile was updated successfully',doubleBack: true);
      } else {
        setState(() {
          isLoading = false;
        });
        return customBackDialog(context: context, type: RichAlertType.ERROR,title: 'Error',subtitle: 'Try Again Later',doubleBack: true);
      }
    });
  }

  void executeAfterBuild() {
    setState(() {
      _reset = false;
      print('reset - false');
    });
  }
}
