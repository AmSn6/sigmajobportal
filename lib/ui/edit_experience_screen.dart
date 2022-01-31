import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sigmajobportal/models/personal_details_model.dart';
import 'package:sigmajobportal/utils.dart';

class EditExperienceScreen extends StatefulWidget {
  final CandidateExperience candidateExperience;
  EditExperienceScreen({Key key, this.candidateExperience}) : super(key: key);

  @override
  _EditExperienceScreenState createState() => _EditExperienceScreenState();
}

class _EditExperienceScreenState extends State<EditExperienceScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final format = DateFormat("MMM yyyy");
  DateTime fromMonth, toMonth;
  String companyName, designation, jobProfile;

  @override
  void initState() {
    super.initState();
    fromMonth = widget.candidateExperience.candidateExperienceDateFrom;
    toMonth = widget.candidateExperience.candidateExperienceDateTo;
    companyName = widget.candidateExperience.candidateExperienceCompany;
    designation = widget.candidateExperience.candidateExperienceDesignation;
    jobProfile = widget.candidateExperience.candidateExperienceProfile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: appbarMethod('Add experience'),
      body: SingleChildScrollView(
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
                      h1Text('Work period'),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 12),
                              decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(30)),
                              child: DateTimeField(
                                  validator: (date){
                                    if(date == null){
                                      return 'Pick a Month';
                                    }
                                  },
                                  format: format,
                                  initialValue: fromMonth,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      suffixIcon:
                                          Icon(FeatherIcons.chevronDown),
                                      hintText: 'From',
                                      hintStyle: TextStyle(
                                        color: grey1,
                                      )),
                                  onChanged: (date){
                                    fromMonth = date;
                                  },
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                      context: context,
                                      initialDatePickerMode: DatePickerMode.year,
                                      initialDate:
                                          currentValue ?? DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100),
                                    );
                                  }),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 12),
                              decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(30)),
                              child: DateTimeField(
                                validator: (date){
                                  if(date == null){
                                    return 'Pick a Month';
                                  }
                                },
                                  initialValue: toMonth,
                                  format: format,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      suffixIcon:
                                      Icon(FeatherIcons.chevronDown),
                                      hintText: 'Up To',
                                      hintStyle: TextStyle(
                                        color: grey1,
                                      )),
                                  onChanged: (date){
                                    toMonth = date;
                                  },
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                      context: context,
                                      initialDatePickerMode: DatePickerMode.year,
                                      initialDate:
                                      currentValue ?? DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100),
                                    );
                                  }),
                            ),
                          ),
                        ],
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
                      h1Text('Company name'),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                            color: grey,
                            borderRadius: BorderRadius.circular(30)),
                        child: TextFormField(
                          validator: (val){
                            if(val.isEmpty){
                              return 'Enter Company Name';
                            }
                          },
                          initialValue: companyName,
                          onSaved: (val){
                            companyName = val;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Company name',
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
                      h1Text('Designation'),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                            color: grey,
                            borderRadius: BorderRadius.circular(30)),
                        child: TextFormField(
                          validator: (val){
                            if(val.isEmpty){
                              return 'Enter Designation';
                            }
                          },
                          initialValue: designation,
                          onSaved: (val){
                            designation = val;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Designation',
                              hintStyle: TextStyle(color: grey1)),
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
                      h1Text('Job Profile'),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                            color: grey,
                            borderRadius: BorderRadius.circular(30)),
                        child: TextFormField(
                          validator: (val){
                            if(val.isEmpty){
                              return 'Enter Job Profile';
                            }
                          },
                          onSaved: (val){
                            jobProfile = val;
                          },
                          initialValue: jobProfile,
                          maxLines: 3,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Job Profile',
                              hintStyle: TextStyle(color: grey1)),
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
                      if(_formKey.currentState.validate()){
                        _formKey.currentState.save();
                        Navigator.pop(context, CandidateExperience(
                          candidateExperienceCompany: companyName,
                          candidateExperienceProfile: jobProfile,
                          candidateExperienceDateFrom: fromMonth,
                          candidateExperienceDateTo: toMonth,
                          candidateExperienceDesignation: designation
                        ));
                      }
                    },
                    color: purple,
                    child: buttonText('Add experience'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
