import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sigmajobportal/main.dart';
import 'package:sigmajobportal/utils.dart';

class AdminDashboardScreen extends StatefulWidget {
  AdminDashboardScreen({Key key}) : super(key: key);

  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String baseURL;

  @override
  void dispose() {
    _auth.signOut();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, Admin'),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
              onPressed: () {
                _auth.signOut().then((val) {
                  push(
                      context: context,
                      pushReplacement: true,
                      toWidget: MyApp());
                });
              },
              child: Text('Logout'))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('baseURL').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error - ${snapshot.error}'),
              );
            } else {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _key,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter Base URL',
                          ),
                          initialValue: snapshot.data.docs[0]['baseURL'],
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Enter Base URL';
                            }
                          },
                          onSaved: (val) {
                            baseURL = val;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RaisedButton(
                          onPressed: () {
                            if(_key.currentState.validate()){
                              _key.currentState.save();
                              FirebaseFirestore.instance
                                  .collection('baseURL')
                                  .doc(snapshot.data.docs[0].id)
                                  .update({'baseURL': baseURL}).then((val){
                                setState(() {

                                });
                              });
                            }
                          },
                          child: Text('UPDATE'),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
