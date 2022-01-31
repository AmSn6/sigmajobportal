import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sigmajobportal/models/job_list_model.dart';
import 'package:sigmajobportal/ui/job_list_item_widget.dart';

class SearchJobScreen extends SearchDelegate {
  final List<JobList> jobList;
  final String baseURL;

  SearchJobScreen({@required this.jobList, this.baseURL});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(FeatherIcons.x),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(FeatherIcons.arrowLeft),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<JobList> _suggestionList = [];
    jobList.forEach((val) {
      if (val.jobName.toLowerCase().contains(query.toLowerCase())) {
        _suggestionList.add(val);
      }
    });
    return JobListItemWidget(joblist: _suggestionList,baseURL: baseURL,);
  }
}
