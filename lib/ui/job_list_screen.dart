import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sigmajobportal/models/job_list_model.dart';
import 'package:sigmajobportal/repository.dart';
import 'package:sigmajobportal/ui/job_list_item_widget.dart';
import 'package:sigmajobportal/ui/search_job_screen.dart';
import 'package:sigmajobportal/utils.dart';
import 'package:random_color/random_color.dart';

class JobListScreen extends StatefulWidget {
  final String categoryID;
  final Map<String, String> params;
  final bool isCategory;
  final String baseURL;

  JobListScreen(
      {Key key,
      @required this.isCategory,
      this.categoryID,
      this.params,
      this.baseURL})
      : super(key: key);

  @override
  _JobListScreenState createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RandomColor _randomColor = RandomColor();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<JobListModel>(
        future: widget.isCategory
            ? getJobList(widget.categoryID)
            : searchJob(widget.params),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            print('error - ${snapshot.error}');
            return errorWidget(context);
          } else {
            return Scaffold(
              backgroundColor: grey,
              key: scaffoldKey,
              endDrawer: Drawer(),
              appBar: appbarMethod('Job List', centerTitle: false, actions: [
                snapshot.data.jobList.isNotEmpty ? IconButton(
                  icon: Icon(FeatherIcons.search, ),
                  onPressed: () {
                    showSearch(
                        context: context,
                        delegate: SearchJobScreen(
                            jobList: snapshot.data.jobList,
                            baseURL: widget.baseURL));
                  },
                ): Container()
              ]),
              body: snapshot.data.jobList.isNotEmpty
                  ? new JobListItemWidget(
                      joblist: snapshot.data.jobList,
                      baseURL: widget.baseURL,
                    )
                  : Center(
                      child: h1Text(
                          'No matching jobs found... Try some other key words...')
                  ),
            );
          }
        });
  }
}
