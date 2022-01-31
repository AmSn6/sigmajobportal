import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sigmajobportal/models/job_details_model.dart';
import 'package:sigmajobportal/repository.dart';
import 'package:sigmajobportal/utils.dart';
import 'package:rich_alert/rich_alert.dart';

class JobDetailsScreen extends StatefulWidget {
  final String jobID;
  final bool  isJoListScreen ;

  JobDetailsScreen({Key key, this.jobID,this.isJoListScreen}) : super(key: key);

  @override
  _JobDetailsScreenState createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<JobDetailsModel>(
        future: getJobDetails(widget.jobID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return errorWidget(context);
          } else {
            return Scaffold(
              backgroundColor: grey,
              appBar: appbarMethod(snapshot.data.jobDetails[0].jobName),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        color: white,
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: orange,
                              child: Text(
                                snapshot.data.jobDetails[0].employerName[0],
                                style: TextStyle(
                                    color: red,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            h1Text(snapshot.data.jobDetails[0].employerName),
                            h2Text(snapshot.data.jobDetails[0].userName)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      jobDetailsItem(
                          FontAwesomeIcons.rupeeSign,
                          green,
                          'OFFERED SALARY',
                        '${snapshot.data.jobDetails[0].jobSalaryLakhsFrom} - ${snapshot.data.jobDetails[0].jobSalaryLakhsTo} Lakhs P.A'),
                      SizedBox(
                        height: 10,
                      ),
                      jobDetailsItem(
                          FontAwesomeIcons.graduationCap,
                          red,
                          'EXPERIENCE',

                              '${snapshot.data.jobDetails[0].jobExperienceYearFrom} - ${snapshot.data.jobDetails[0].jobExperienceYearTo} Years'),
                      SizedBox(
                        height: 10,
                      ),
                      jobDetailsItem(
                          FontAwesomeIcons.industry,
                          lightYellow,
                          'INDUSTRY',

                              '${snapshot.data.jobDetails[0].jobIndustryName}'),
                      SizedBox(
                        height: 10,
                      ),
                      jobDetailsItem(
                          FontAwesomeIcons.male,
                          Colors.brown,
                          'CONTACT PERSON',
                              '${snapshot.data.jobDetails[0].jobContactPerson}'),
                      SizedBox(
                        height: 10,
                      ),
                      jobDetailsItem(
                          FontAwesomeIcons.phone,
                          lightGreen,
                          'CONTACT NO',
                              '${snapshot.data.jobDetails[0].jobContactPersonNumber}'),
                      SizedBox(
                        height: 10,
                      ),
                      jobDetailsItem(
                          FontAwesomeIcons.calendar,
                          blue,
                          'INTERVIEW DATE',
                              '${DateFormat('dd-MM-yyyy hh:mm aa').format(snapshot.data.jobDetails[0].jobInterviewDateFrom)} - ${DateFormat('dd-MM-yyyy hh:mm aa').format(snapshot.data.jobDetails[0].jobInterviewDateTo)}'),
                      SizedBox(
                        height: 10,
                      ),
                      jobOverviewContainer('Job Overview',
                          snapshot.data.jobDetails[0].jobDescription),
                      SizedBox(
                        height: 10,
                      ),
                      jobOverviewContainer('Employer Profile',
                          snapshot.data.jobDetails[0].jobEmployerProfile),
                      SizedBox(
                        height: 10,
                      ),
                      jobOverviewContainer(
                          'Desire Candidate Profile',
                          snapshot
                              .data.jobDetails[0].jobDesiredCandidateProfile),
                      SizedBox(
                        height: 10,
                      ),
                      widget.isJoListScreen ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: RaisedButton(
                                  shape: buttonShape(30),
                                  onPressed: () {
                                    applyJob(snapshot.data.jobDetails[0].jobId).then((model){
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            if (model.status == 'success') {
                                              return customBackDialog(context: context, type: RichAlertType.SUCCESS,title: 'Job Applied Successfully',subtitle: 'We will get back to you soon');
                                            } else {
                                              return customBackDialog(context: context, type: RichAlertType.ERROR,title: 'Error',subtitle: 'Try again Later');
                                            }
                                          });
                                    });
                                  },
                                  color: purple,
                                  child: buttonText('Apply now!'),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            // CircleAvatar(
                            //   radius: 30,
                            //   backgroundColor: lightYellow,
                            //   child: Icon(
                            //     FeatherIcons.share2,
                            //     color: orange,
                            //   ),
                            // )
                          ],
                        ),
                      ) : Container()
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }

  Widget jobDetailsItem(IconData iconData, Color color, String title, String subtitle) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(
            iconData,
            color: Colors.white,
            size: 16,
          ),
          backgroundColor: color,
        ),
        title: Text(title),
        subtitle: h1Text(subtitle),
      ),
    );
  }

  Container jobOverviewContainer(String title, String desc) {
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
          h1Text(title),
          SizedBox(
            height: 10,
          ),
          h2Text(desc),
          SizedBox(
            height: 10,
          ),
          //SizedBox(height: 20,),
          // h2Text('Right Win Connect Jobs.in is here to make the hiring process easier than ever before. Our cutting-edge')
        ],
      ),
    );
  }
}
