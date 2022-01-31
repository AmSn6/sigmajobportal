import 'dart:convert';
import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sigmajobportal/models/candidate_personal_model.dart'
    as candidatePersonal;
import 'package:sigmajobportal/models/common_response_model.dart';
import 'package:sigmajobportal/models/personal_details_model.dart'
    as personalDetails;
import 'package:sigmajobportal/repository.dart';
import 'package:sigmajobportal/utils.dart';
import 'package:progress_button/progress_button.dart';

class EditPersonalDetailsScreen extends StatefulWidget {
  final personalDetails.CandidateDetails candidateDetails;
  final String baseURL;

  EditPersonalDetailsScreen({Key key, this.candidateDetails, this.baseURL})
      : super(key: key);

  @override
  _EditPersonalDetailsScreenState createState() =>
      _EditPersonalDetailsScreenState();
}

class _EditPersonalDetailsScreenState extends State<EditPersonalDetailsScreen> {
  String value;
  Future _future;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController salutationCntlr = new TextEditingController();
  TextEditingController maritalStatusCntlr = new TextEditingController();
  DateTime dobDateTime;
  String salutationID, maritalStatusID, username, email;
  final format = DateFormat("dd-MM-yyyy");
  File _profileImage;
  bool imageProcessing = false, isPicTaken = false;
  String base64Image = '';
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    salutationCntlr.dispose();
    maritalStatusCntlr.dispose();
  }

  @override
  void initState() {
    super.initState();
    _future = getCandidatePersonal();
    initializeVariables();
  }

  void initializeVariables() {
    salutationCntlr =
        new TextEditingController(text: widget.candidateDetails.salutationName);
    salutationID = widget.candidateDetails.refSalutationId ?? '';
    maritalStatusCntlr = new TextEditingController(
        text: widget.candidateDetails.maritalStatusName);
    maritalStatusID = widget.candidateDetails.refMaritalStatusId;
    if (widget.candidateDetails.candidateGender == 'male') {
      value = 'Male';
    } else {
      value = 'Female';
    }
    dobDateTime = widget.candidateDetails.candidateDob;
    username = widget.candidateDetails.candidateUsername;
    email = widget.candidateDetails.candidateUsername;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: appbarMethod('Personal details'),
      body: FutureBuilder<candidatePersonal.CandidatePersonalModel>(
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
              if (imageProcessing) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          profileImageContainer(context),
                          SizedBox(
                            height: 10,
                          ),
                          salutationContainer(snapshot),
                          SizedBox(
                            height: 10,
                          ),
                          usernameContainer(),
                          SizedBox(
                            height: 10,
                          ),
                          genderContainer(),
                          SizedBox(
                            height: 10,
                          ),
                          dobContainer(),
                          SizedBox(
                            height: 10,
                          ),
                          emailContainer(),
                          SizedBox(
                            height: 10,
                          ),
                          maritalStatusContainer(snapshot),
                          SizedBox(
                            height: 20,
                          ),
                          ProgressButton(
                            backgroundColor: purple,
                            progressColor: white,
                            child: buttonText('Save'),
                            buttonState: isLoading
                                ? ButtonState.inProgress
                                : ButtonState.normal,
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                setState(() {
                                  isLoading = true;
                                });
                                final storage = FlutterSecureStorage();
                                String candidateID =
                                    await storage.read(key: skCandidateID);
                                String fileName =
                                    '${candidateID}_${DateFormat('yyyyMMddhhmmss').format(DateTime.now())}';
                                Map<String, String> params = {
                                  'candidate_name' : widget.candidateDetails.candidateName,
                                  'profile_image': base64Image,
                                  'ref_salutation_id': salutationID,
                                  'candidate_username': username,
                                  'candidate_gender':
                                      value == 'Male' ? 'male' : 'female',
                                  'candidate_dob': DateFormat('yyyy-MM-dd')
                                      .format(dobDateTime),
                                  'ref_marital_status_id': maritalStatusID,
                                  'candidate_filename': fileName,
                                  'candidate_id': candidateID,
                                };
                                CommonResponseModel model =
                                    await postCandidatePersonalDetails(params);
                                if (model.response == "1") {
                                  Navigator.pop(context, true);
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pop(context, false);
                                }
                              }
                            },
                          ),
                          //button(context),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }
          }),
    );
  }

/*
  SizedBox button(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 300,
      child: RaisedButton(
        shape: buttonShape(30),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            final storage = FlutterSecureStorage();
            String candidateID = await storage.read(key: skCandidateID);
            String fileName =
                '${candidateID}_${DateFormat('yyyyMMddhhmmss').format(DateTime.now())}';
            Map<String, String> params = {
              'profile_image': base64Image,
              'ref_salutation_id': salutationID,
              'candidate_username': username,
              'candidate_gender': value == 'Male' ? 'male' : 'female',
              'candidate_dob': DateFormat('yyyy-MM-dd').format(dobDateTime),
              'ref_marital_status_id': maritalStatusID,
              'candidate_filename': fileName,
              'candidate_id': candidateID,
            };
            CommonResponseModel model =
                await postCandidatePersonalDetails(params);
            if (model.response == "1") {

              Navigator.pop(context, true);
            } else {
              Navigator.pop(context, false);
            }
          }
        },
        color: purple,
        child: buttonText('Add Personal details'),
      ),
    );
  }
*/

  Container maritalStatusContainer(
      AsyncSnapshot<candidatePersonal.CandidatePersonalModel> snapshot) {
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
          h1Text('Martial Status'),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                color: grey, borderRadius: BorderRadius.circular(30)),
            child: TypeAheadFormField<candidatePersonal.MaritalStatus>(
              textFieldConfiguration: TextFieldConfiguration(
                controller: maritalStatusCntlr,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Martial Status',
                    hintStyle: TextStyle(color: grey1)),
              ),
              autoFlipDirection: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Select Marital Status';
                }
              },
              onSuggestionSelected: (mStatus) async {
                maritalStatusID = mStatus.maritalStatusId;
                maritalStatusCntlr.text = mStatus.maritalStatusName;
              },
              itemBuilder: (context, mStatus) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(mStatus.maritalStatusName),
                );
              },
              getImmediateSuggestions: true,
              suggestionsCallback: (pattern) {
                return snapshot.data.maritalStatus
                    .where((val) => val.maritalStatusName
                        .toLowerCase()
                        .contains(pattern.toLowerCase()))
                    .toList();
              },
            ),
          )
        ],
      ),
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
              initialValue: email,
              validator: (val) {
                if (val.isEmpty) {
                  return 'Enter E-Mail';
                }else if(!val.contains('.') && !val.contains('@')){
                  return 'Invalid Email-Id';
                }else{
                  return null;
                }
              },
              onSaved: (val) {
                email = val;
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Email',
                  hintStyle: TextStyle(color: grey1)),
            ),
          )
        ],
      ),
    );
  }

  Container dobContainer() {
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
          h1Text('DOB'),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                color: grey, borderRadius: BorderRadius.circular(30)),
            child: DateTimeField(
                validator: (date) {
                  if (date == null) {
                    return 'Pick a Month';
                  }
                },
                readOnly: true,
                format: format,
                initialValue: dobDateTime,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'DOB',
                    hintStyle: TextStyle(color: grey1)),
                onChanged: (date) {
                  dobDateTime = date;
                },
                onShowPicker: (context, currentValue) {
                  if(currentValue == null) currentValue = widget.candidateDetails.candidateDob;
                  return showDatePicker(
                    firstDate: DateTime(1900),
                    context: context,
                    initialDatePickerMode: DatePickerMode.day,
                    initialDate: currentValue.year == 0001
                        ? currentValue.add(Duration(days: 366))
                        : currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                }),
          )
        ],
      ),
    );
  }

  Container genderContainer() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          h1Text('Gender'),
          Row(
            children: <Widget>[
              Expanded(
                child: RadioListTile(
                  title: Text('Male'),
                  groupValue: value,
                  onChanged: (value) => setState(() => this.value = value),
                  value: 'Male',
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: Text('Female'),
                  groupValue: value,
                  onChanged: (value) => setState(() => this.value = value),
                  value: 'Female',
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Container usernameContainer() {
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
          h1Text('Username'),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                color: grey, borderRadius: BorderRadius.circular(30)),
            child: TextFormField(
              initialValue: username,
              validator: (val) {
                if (val.isEmpty) {
                  return 'Enter Username';
                }
              },
              onSaved: (val) {
                username = val;
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Username',
                  hintStyle: TextStyle(color: grey1)),
            ),
          ),
        ],
      ),
    );
  }

  Container salutationContainer(
      AsyncSnapshot<candidatePersonal.CandidatePersonalModel> snapshot) {
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
          h1Text('Salutation'),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                color: grey, borderRadius: BorderRadius.circular(30)),
            child: TypeAheadFormField<candidatePersonal.Salutation>(
              textFieldConfiguration: TextFieldConfiguration(
                controller: salutationCntlr,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Icon(FeatherIcons.chevronDown),
                    hintText: 'Select Salutation',
                    hintStyle: TextStyle(color: grey1)),
              ),
              autoFlipDirection: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Select Salutation';
                }
              },
              onSuggestionSelected: (salutation) async {
                salutationID = salutation.salutationId;
                salutationCntlr.text = salutation.salutationName;
              },
              itemBuilder: (context, salutation) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(salutation.salutationName),
                );
              },
              getImmediateSuggestions: true,
              suggestionsCallback: (pattern) {
                return snapshot.data.salutation
                    .where((val) => val.salutationName
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

  Container profileImageContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
                radius: 30,
                backgroundColor: purple,
                child: isPicTaken
                    ? ClipOval(
                        child: Image(
                          image: FileImage(_profileImage),
                        ),
                      )
                    : widget.candidateDetails.candidateImage.isEmpty ||
                            widget.candidateDetails.candidateImage == '-'
                        ? Text(
                            widget.candidateDetails.candidateName[0],
                            style: TextStyle(
                                color: white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )
                        : imageWidget(
                            widget.baseURL +
                                widget.candidateDetails.candidateImage,
                            100)),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: FlatButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: Text('Choose an Action'),
                            ),
                            Divider(),
                            ListTile(
                              leading: Icon(FontAwesomeIcons.camera),
                              title: Text('Take a Photo'),
                              onTap: () {
                                openImagePicker(true);
                              },
                            ),
                            ListTile(
                              leading: Icon(FontAwesomeIcons.photoVideo),
                              title: Text('Choose from Gallery'),
                              onTap: () {
                                openImagePicker(false);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      });
                },
                child: h1Text('Edit Profile Image'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openImagePicker(bool takePhoto) async {
    Navigator.pop(context);
    setState(() {
      imageProcessing = true;
    });
    XFile image = await ImagePicker().pickImage(
        source: takePhoto ? ImageSource.camera : ImageSource.gallery);
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        cropStyle: CropStyle.circle,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    setState(() {
      imageProcessing = false;
      isPicTaken = true;
      _profileImage = croppedFile;
    });
    List<int> imageBytes = await _profileImage.readAsBytesSync();
    base64Image = base64Encode(imageBytes);
  }
}
