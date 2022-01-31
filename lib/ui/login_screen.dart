import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sigmajobportal/models/login_response_model.dart';
import 'package:sigmajobportal/repository.dart';
import 'package:sigmajobportal/ui/admin_dashboard_screen.dart';
import 'package:sigmajobportal/ui/register_screen.dart';
import 'package:progress_button/progress_button.dart';
import 'package:rich_alert/rich_alert.dart';

import '../utils.dart';
import 'category_screen.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String username, password, baseURL;
  bool isObscure = true, urlError = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getBaseURL();
  }
  DateTime currentBackPressTime;
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
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
          backgroundColor: grey,
          body: urlError
              ? errorWidget(context)
              : Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(8),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          Image.asset('assets/images/sample-one.png',
                              height: MediaQuery.of(context).size.height / 3),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 12),
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(30)),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: Icon(FeatherIcons.user),
                                hintText: 'Username',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please Enter Username';
                                }else if(!value.contains('.') && !value.contains('@')){
                                  return 'Invalid Email-Id';
                                }else{
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                username = value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 12),
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(30)),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  icon: isObscure
                                      ? Icon(FeatherIcons.eye)
                                      : Icon(FeatherIcons.eyeOff),
                                  onPressed: () {
                                    setState(() {
                                      isObscure = !isObscure;
                                    });
                                  },
                                ),
                                hintText: 'Password',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please Enter Password';
                                }
                              },
                              onSaved: (value) {
                                password = value;
                              },
                              obscureText: isObscure,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Spacer(),
                              FlatButton(
                                  onPressed: () {
                                    push(
                                        context: context,
                                        pushReplacement: false,
                                        toWidget: ForgetPasswordScreen());
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(color: violet, fontSize: 16),
                                  ))
                            ],
                          ),
                          ProgressButton(
                            backgroundColor: purple,
                            progressColor: white,
                            child: buttonText('Login'),
                            buttonState: isLoading
                                ? ButtonState.inProgress
                                : ButtonState.normal,
                            onPressed: () async {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();
                                checkForAdmin();
                              }
                            },
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'New user?',
                                style: TextStyle(color: violet, fontSize: 16),
                              ),
                              FlatButton(
                                  onPressed: () {
                                    push(
                                        context: context,
                                        pushReplacement: false,
                                        toWidget: RegisterScreen());
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(color: purple, fontSize: 16),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
    );
  }

  void login() async {
    var params = {'user_name': username, 'password': password};

    print('params -$params');
    LoginResponseModel model = await postLoginDetails(params);
    if (model == null) {
      setState(() {
        urlError = true;
      });

    } else if (model.status == 'success') {
      final storage = FlutterSecureStorage();
      await storage.write(key: skCandidateID, value: model.result.candidateId);
      await storage.write(key: skCandidateName, value: model.result.candidateName);
      await storage.write(key: passwordKey, value: password);
      await storage.write(key: skUserName, value: username);
      push(context: context, pushReplacement: true, toWidget: CategoryScreen());
    } else {
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return customBackDialog(
                context: context,
                type: RichAlertType.ERROR,
                title: 'Error',
                subtitle: model.message,
                doubleBack: false);
          });
    }
  }

  void checkForAdmin() async {
    setState(() {
      isLoading = true;
    });
    if (username == 'tl@sigmaprestantia.com') {
      _auth
          .signInWithEmailAndPassword(email: username, password: password)
          .then((result) {
        push(
            context: context,
            pushReplacement: true,
            toWidget: AdminDashboardScreen());
      }).catchError((error) {
        print('auth error - $error');
        showDialog(
            context: context,
            builder: (context) {
              return customBackDialog(
                  context: context,
                  type: RichAlertType.ERROR,
                  title: 'Error',
                  subtitle: 'Invalid Username or Password',
                  doubleBack: false);
            });
      });
    } else {
      login();
    }
  }
}
