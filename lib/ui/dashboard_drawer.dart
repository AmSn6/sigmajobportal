import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sigmajobportal/models/personal_details_model.dart';
import 'package:sigmajobportal/repository.dart';
import 'package:sigmajobportal/ui/change_password_screen.dart';
import 'package:sigmajobportal/ui/create_job_alert_screen.dart';
import 'package:sigmajobportal/ui/dashboard_screen.dart';
import 'package:sigmajobportal/ui/my_application_screen.dart';
import 'package:sigmajobportal/ui/resume_screen.dart';
import 'package:rich_alert/rich_alert.dart';

import '../main.dart';
import '../utils.dart';

class DashboardDrawer extends StatefulWidget {
  @override
  _DashboardDrawerState createState() => _DashboardDrawerState();
}

class _DashboardDrawerState extends State<DashboardDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          FutureBuilder<PersonalDetailModel>(
              future: getPersonalDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SafeArea(
                    top: true,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  print('error - ${snapshot.error}');
                  return errorWidget(context);
                }
                return UserAccountsDrawerHeader(
                  accountName:
                  Text(
                    snapshot.data.candidateDetails[0].candidateName,
                    style: TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                      // h1Text(snapshot.data.candidateDetails[0].candidateName),
                  accountEmail: Text(
                    snapshot.data.candidateDetails[0].candidateUsername,
                    style: TextStyle(fontSize: 16, color: white),
                  ),
                  // h2Text(snapshot.data.candidateDetails[0].candidateUsername),
                  // currentAccountPicture: CircleAvatar(
                  //   backgroundColor: purple,
                  //     child: snapshot.data.candidateDetails[0].candidateImage.isEmpty || snapshot.data.candidateDetails[0].candidateImage == '-'
                  //         ? Text(
                  //             snapshot
                  //                 .data.candidateDetails[0].candidateName[0],
                  //             style: TextStyle(
                  //                 color: white,
                  //                 fontSize: 25,
                  //                 fontWeight: FontWeight.bold),
                  //           )
                  //         : imageWidget(snapshot.data.image, 100)
                  // ),
                  currentAccountPicture: Image.asset('assets/icons/mobileicon.jpg'),
                  // decoration: BoxDecoration(color: white),
                );
              }),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      push(
                          context: context,
                          pushReplacement: false,
                          toWidget: DashboardScreen());
                    },
                    title: h1Text('Search Job'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      push(
                          context: context,
                          pushReplacement: false,
                          toWidget: ResumeScreen());
                    },
                    title: h1Text('My Resume'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      push(
                          context: context,
                          pushReplacement: false,
                          toWidget: CreateJobAlertScreen());
                    },
                    title: h1Text('Create Job Alert'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      push(
                          context: context,
                          pushReplacement: false,
                          toWidget: MyApplicationScreen());
                    },
                    title: h1Text('My Applications'),
                  ),
                  ListTile(
                    onTap: () {
                      push(
                          context: context,
                          pushReplacement: false,
                          toWidget: ChangePasswordScreen());
                    },
                    title: h1Text('Change Password'),
                  ),
                  ListTile(
                    onTap: () {
                      onLogoutPress(context);
                    },
                    title: h1Text('Logout'),
                  ),
                ],
              ),
            ),
          ),
          sigmaText(textColor: purple)
        ],
      ),
    );
  }

  void onLogoutPress(BuildContext context) async {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (context) {
          return RichAlertDialog(
            alertTitle: richTitle('Warning!'),
            alertSubtitle: richSubtitle('Are you sure\nwant to Logout?'),
            alertType: RichAlertType.WARNING,
            actions: <Widget>[
              RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: green,
                  textColor: white,
                  onPressed: () async {
                    await logoutUser(context);
                  },
                  child: Text('YES')),
              SizedBox(
                width: 5,
              ),
              RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: red,
                  textColor: white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('NO')),
            ],
          );
        });
  }

  Future logoutUser(BuildContext context) async {
    final storage = FlutterSecureStorage();
    await storage.deleteAll();
    RestartWidget.restartApp(context);
  }
}
