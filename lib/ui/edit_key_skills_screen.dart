import 'package:flutter/material.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:sigmajobportal/models/personal_details_model.dart';
import 'package:sigmajobportal/models/skills_model.dart';
import 'package:sigmajobportal/utils.dart';

import '../repository.dart';

class EditKeySkillsScreen extends StatefulWidget {
  final List<Keyskill> skills;

  EditKeySkillsScreen({Key key, this.skills}) : super(key: key);

  @override
  _EditKeySkillsScreenState createState() => _EditKeySkillsScreenState();
}

class _EditKeySkillsScreenState extends State<EditKeySkillsScreen> {
  List<Skill> _skillList = [];

  @override
  void initState() {
    widget.skills.forEach((element) {
      _skillList
          .add(Skill(name: element.keySkillsName, id: element.keySkillsId));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarMethod('Key Skills'),
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
              title: h1Text('Key Skills'),
            ),
            ListTile(
              title: Wrap(
                runSpacing: 5,
                spacing: 5,
                children: widget.skills.map((skill) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                        color: pink,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          child: Text(
                            skill.keySkillsName,
                            style: TextStyle(color: white),
                          ),
                        )),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                    color: grey, borderRadius: BorderRadius.circular(30)),
                child: FlutterTagging<Skill>(
                  textFieldConfiguration: TextFieldConfiguration(
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Key Skills')),
                  configureChip: (skills) {
                    return ChipConfiguration(
                        backgroundColor: pink,
                        label: Text(skills.name),
                        deleteIconColor: white,
                        labelStyle: TextStyle(color: white));
                  },
                  configureSuggestion: (skill) {
                    return SuggestionConfiguration(title: Text(skill.name));
                  },
                  hideOnEmpty: true,
                  onChanged: () {},
                  initialItems: _skillList,
                  hideOnError: true,
                  findSuggestions: (pattern) async {
                    return await postKeySkills({'filter_skill': pattern});
                  },
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: RaisedButton(
                shape: buttonShape(30),
                onPressed: () {
                  addKeySkills();
                },
               color: purple,
                child: buttonText('Update Key Skills'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void addKeySkills() {
    if (_skillList.isEmpty) {
      Navigator.pop(context, null);
    } else {
      List<Keyskill> _list = [];
      _skillList.forEach((val) {
        _list.add(Keyskill(keySkillsName: val.name, keySkillsId: val.id));
      });
      Navigator.pop(context, _list);
    }
  }
}
