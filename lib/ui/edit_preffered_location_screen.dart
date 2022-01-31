import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:sigmajobportal/models/location_model.dart';
import 'package:sigmajobportal/models/personal_details_model.dart';
import 'package:sigmajobportal/utils.dart';

import '../repository.dart';

class EditPrefferedLocationScreen extends StatefulWidget {
  final List<Keylocation> skills;

  EditPrefferedLocationScreen({Key key, this.skills}) : super(key: key);

  @override
  _EditPrefferedLocationScreenState createState() => _EditPrefferedLocationScreenState();
}

class _EditPrefferedLocationScreenState extends State<EditPrefferedLocationScreen> {
  List<Location> _locationList = [];

  @override
  void initState() {
    widget.skills.forEach((element) {
      _locationList.add(
        Location(
          jobLocationId: element.jobLocationId,
          jobLocationName: element.jobLocationName
        )
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarMethod('Preffered Location'),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: h1Text('Preffered Location'),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                    color: grey, borderRadius: BorderRadius.circular(30)),
                child: FlutterTagging<Location>(
                  textFieldConfiguration: TextFieldConfiguration(
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
                    return await postKeyLocation({'filter_location': pattern});
                  },
                  onChanged: () {},
                ),
              ),
            ),
            SizedBox(height: 15,),
            SizedBox(
              height: 50,
              width: 300,
              child: RaisedButton(
                shape: buttonShape(30),
                onPressed: () {
                  addKeySkills();
                },
                color: purple,
                child: buttonText('Update Location'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void addKeySkills() {
    if(_locationList.isEmpty){
      Navigator.pop(context, null);
    } else {
      List<Keylocation> _skills = [];
      _locationList.forEach((val) => _skills.add(Keylocation(
        jobLocationName: val.jobLocationName,
        jobLocationId: val.jobLocationId
      )));
//      _skills = _skills + widget.skills;
      Navigator.pop(context, _skills);
    }
  }
}
