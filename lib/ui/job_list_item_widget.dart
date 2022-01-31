import 'package:flutter/material.dart';
import 'package:sigmajobportal/models/job_list_model.dart';
import 'package:random_color/random_color.dart';

import '../utils.dart';
import 'job_details_screen.dart';

class JobListItemWidget extends StatefulWidget {
  const JobListItemWidget(
      {Key key, @required List<JobList> joblist, @required String baseURL})
      : _jobList = joblist,
        baseURL = baseURL,
        super(key: key);

  final List<JobList> _jobList;
  final String baseURL;

  @override
  _JobListItemWidgetState createState() => _JobListItemWidgetState();
}

class _JobListItemWidgetState extends State<JobListItemWidget> {
  RandomColor _randomColor = RandomColor();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: h1Text(widget._jobList[0].jobCategoryName),
            trailing: Text(
              '${widget._jobList.length}',
              style: TextStyle(color: grey1, fontSize: 16),
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemCount: widget._jobList.length,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: Colors.grey,
                    onTap: () {
                      push(
                          context: context,
                          pushReplacement: false,
                          toWidget: JobDetailsScreen(
                            jobID: widget._jobList[index].jobId,
                            isJoListScreen: true,
                          ));
                    },
                    child: Card(
                      elevation: 1,
                      shape: buttonShape(4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                                backgroundColor: purple,
                                child: widget._jobList[index].employerImage ==
                                            '-' ||
                                        widget._jobList[index].employerImage
                                            .isEmpty
                                    ? Text(
                                        widget._jobList[index].jobName[0]
                                                .isNotEmpty
                                            ? widget._jobList[index].jobName[0]
                                            : '-',
                                        style: TextStyle(
                                            color: white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : imageWidget(
                                        widget.baseURL +
                                            widget
                                                ._jobList[index].employerImage,
                                        60)),
//                            leading: CircleAvatar(
//                              backgroundColor: _randomColor.randomColor(
//                                colorSaturation: ColorSaturation.highSaturation,
//                                colorBrightness: ColorBrightness.veryDark,
//                              ),
//                              child: Text(
//                                widget._jobList[index].jobName[0],
//                                style: TextStyle(
//                                    fontSize: 18,
//                                    fontWeight: FontWeight.bold,
//                                    color: white),
//                              ),
//                            ),
                            title: h1Text(widget._jobList[index].jobName),
                            subtitle: Text(
                                '${widget._jobList[index].employerName}, ${widget._jobList[index].jobLocationName ?? ''}'),
                          ),
                          if (widget._jobList[index].keySkillsName.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Wrap(
                                children: widget._jobList[index].keySkillsName
                                    .map((val) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: lavender),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 4),
                                        child: Text(
                                          val,
                                          style: TextStyle(color: violet),
                                        )),
                                  );
                                }).toList(),
                                spacing: 5,
                                runSpacing: 5,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
