
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sigmajobportal/models/category_model.dart';

import '../utils.dart';
import 'job_list_screen.dart';

class CategorySearchScreen extends SearchDelegate{
  List<JobCategory> categoryList;
  String baseURL;
  CategorySearchScreen({this.categoryList, this.baseURL});
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(FeatherIcons.x), onPressed: (){
        query = '';
      })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(FeatherIcons.arrowLeft), onPressed: (){
      Navigator.pop(context);
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<JobCategory> _list = [];
    categoryList.forEach((val){
      if(val.jobName.toLowerCase().contains(query.toLowerCase())){
        _list.add(val);
      }
    });
    return ListView.builder(
        itemCount: _list.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            elevation: 1,
            child: ListTile(
              onTap: () =>
                  openJobList(context, _list[index].refJobCategoryId, index),
              title: Text(
                  '${_list[index].jobName} (${_list[index].total})'),
              leading: imageWidget(
                  baseURL +
                      _list[index]
                          .jobCategoryImage,
                  40),
              trailing: Icon(FeatherIcons.chevronRight),
            ),
          );
        });
  }

  openJobList(BuildContext context, String refJobCategoryId, int index) {
    push(
        context: context,
        pushReplacement: false,
        toWidget: JobListScreen(
          isCategory: true,
          categoryID: refJobCategoryId,
          baseURL: baseURL,
        ));
  }
  
}