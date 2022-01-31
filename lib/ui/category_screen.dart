import 'package:after_layout/after_layout.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sigmajobportal/models/category_model.dart';
import 'package:sigmajobportal/repository.dart';
import 'package:sigmajobportal/ui/category_search_screen.dart';
import 'package:sigmajobportal/ui/dashboard_drawer.dart';
import 'package:sigmajobportal/ui/dashboard_screen.dart';
import 'package:sigmajobportal/ui/job_list_screen.dart';
import 'package:sigmajobportal/utils.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> with AfterLayoutMixin {
  String baseURL, candidateName = '', userName = '', candidateID = '';
  Future _future;
  bool _isList = false;
DateTime currentBackPressTime;
  @override
  void initState() {
    super.initState();
    setBaseURL();
    _future = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        appBar: appbarMethod('Sigma Job Portal', centerTitle: false, actions: [
          IconButton(
              icon: Icon(
                FeatherIcons.bell,
              ),
              onPressed: () {})
        ]),
        backgroundColor: grey,
        drawer: DashboardDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<CategoryModel>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return errorWidget(context);
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/search.png',
                          height: MediaQuery.of(context).size.height / 4.5,
                        ),
                        SizedBox(
                          height: 10,
                        ),
//                      Container(
////                          width: MediaQuery.of(context).size.width / 1.3,
//                        child: RaisedButton.icon(
//                            shape: buttonShape(30),
//                            color: pink,
//                            textColor: white,
//                            onPressed: () {
//                              push(
//                                  context: context,
//                                  pushReplacement: false,
//                                  toWidget: DashboardScreen());
//                            },
//                            icon: Icon(FeatherIcons.search),
//                            label: Text('Find a Right Job')),
//                      ),
//                      SizedBox(
//                        height: 10,
//                      ),
                        Container(
                          width: double.infinity,
                          child: Card(
                              elevation: 1,
                              child: ListTile(
                                title: h1Text('Choose a Category'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                        icon: Icon(_isList
                                            ? FeatherIcons.grid
                                            : FeatherIcons.list),
                                        onPressed: () {
                                          setState(() {
                                            _isList = !_isList;
                                          });
                                        }),
                                    IconButton(
                                        icon: Icon(FeatherIcons.search),
                                        onPressed: () {
                                          showSearch(
                                              context: context,
                                              delegate: CategorySearchScreen(
                                                  baseURL: baseURL,
                                                  categoryList:
                                                      snapshot.data.jobCategory));
                                        }),
                                  ],
                                ),
                              )),
                        ),
                        _isList
                            ? ListView.builder(
                                itemCount: snapshot.data.jobCategory.length,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 1,
                                    child: ListTile(
                                      onTap: () => openJobList(
                                          context,
                                          snapshot.data.jobCategory[index]
                                              .refJobCategoryId,
                                          index),
                                      title: Text(
                                          '${snapshot.data.jobCategory[index].jobName} (${snapshot.data.jobCategory[index].total})'),
                                      leading: imageWidget(
                                          baseURL +
                                              snapshot.data.jobCategory[index]
                                                  .jobCategoryImage,
                                          40),
                                      trailing: Icon(FeatherIcons.chevronRight),
                                    ),
                                  );
                                })
                            : StaggeredGridView.countBuilder(
                                physics: ScrollPhysics(),
                                crossAxisCount: 3,
                                staggeredTileBuilder: (int index) =>
                                    new StaggeredTile.fit(1),
                                itemCount: snapshot.data.jobCategory.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      openJobList(
                                          context,
                                          snapshot.data.jobCategory[index]
                                              .refJobCategoryId,
                                          index);
                                    },
                                    splashColor: Colors.grey,
                                    child: categoryItem(
                                        '${snapshot.data.jobCategory[index].jobName} (${snapshot.data.jobCategory[index].total})',
                                        baseURL +
                                            snapshot.data.jobCategory[index]
                                                .jobCategoryImage),
                                  );
                                },
                              ),
                      ],
                    ),
                  );
                }
              }),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: purple, boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(0, -2)),
          ]),
          child: FlatButton.icon(
            onPressed: () {
              push(
                  context: context,
                  pushReplacement: false,
                  toWidget: DashboardScreen());
            },
            icon: Icon(FeatherIcons.search),
            label: Text('Find a Right Job'),
            textColor: white,
          ),
        ),
//      floatingActionButton: FloatingActionButton.extended(onPressed: (){
//        push(context: context, pushReplacement: false, toWidget: DashboardScreen());
//      }, label: Text('Find A Job'),icon: Icon(FeatherIcons.search),backgroundColor: pink),
      ),
    );
  }
  Future<bool> onBackPressed() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      showToast('Press Again to Exit', purple);
      return Future.value(false);
    }
    return Future.value(true);
  }


  void openJobList(BuildContext context, String categoryID, int index) {
    push(
        context: context,
        pushReplacement: false,
        toWidget: JobListScreen(
          isCategory: true,
          categoryID: categoryID,
          baseURL: baseURL,
        ));
  }

  Widget categoryItem(String text, String imageURL) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            imageWidget(imageURL, 60),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: grey1, fontSize: 13),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  void setBaseURL() async {
    final storage = FlutterSecureStorage();
    baseURL = await storage.read(key: skBaseURL);
    candidateName = await storage.read(key: skCandidateName);
    userName = await storage.read(key: skUserName);
    candidateID = await storage.read(key: skCandidateID);
    print('candidate Name - $candidateName');
  }

  @override
  void afterFirstLayout(BuildContext context) {
    setBaseURL();
  }
}
