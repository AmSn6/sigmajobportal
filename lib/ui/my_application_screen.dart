import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sigmajobportal/models/my_application_model.dart';
import 'package:sigmajobportal/repository.dart';
import 'package:sigmajobportal/ui/job_details_screen.dart';
import 'package:sigmajobportal/utils.dart';
import 'package:random_color/random_color.dart';

class MyApplicationScreen extends StatefulWidget {

  MyApplicationScreen({Key key}) : super(key: key);

  @override
  _MyApplicationScreenState createState() => _MyApplicationScreenState();
}

class _MyApplicationScreenState extends State<MyApplicationScreen> {
  RandomColor _randomColor = RandomColor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarMethod('My Applications'),
      body: FutureBuilder<MyApplicationModel>(
          future: getMyApplicationList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              print('error - ${snapshot.error}');
              return errorWidget(context);
            }
            return snapshot.data.applyDetails.isEmpty ? Center(child: Text('Applied Details Not Found...',style: TextStyle(fontSize: 18),),):ListView.separated(
              separatorBuilder: (context,index)=>Divider(),
                itemCount: snapshot.data.applyDetails.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: (){
                      push(context: context, pushReplacement: false, toWidget: JobDetailsScreen(jobID: snapshot.data.applyDetails[index].refJobId,isJoListScreen: false,));
                    },
                    title: Text(snapshot.data.applyDetails[index].jobName),
                    subtitle: Text('Applied Date: '+DateFormat('dd-MM-yyyy').format(snapshot.data.applyDetails[index].jobApplyDate)),
                    leading: CircleAvatar(
                      child: Text(snapshot.data.applyDetails[index].jobName[0],style: TextStyle(color: Colors.white),),
                      backgroundColor: _randomColor.randomColor(
                        colorSaturation: ColorSaturation.highSaturation,
                        colorBrightness: ColorBrightness.veryDark
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
