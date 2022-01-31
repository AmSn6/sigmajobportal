import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sigmajobportal/utils.dart';

class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({Key key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/forget-password.png',
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 12),
                    decoration:
                    BoxDecoration(  color: white,borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(FeatherIcons.mail),
                        hintText: 'Email',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Email';
                        }else if(!value.contains('.') && !value.contains('@')){
                          return 'Invalid Email-Id';
                        }else{
                          return null;
                        }
                      },
                      onSaved: (value) {
                        email = value;
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                        }
                      },
                      color: purple,
                      child: buttonText('Send'),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Back to',
                        style: TextStyle(color: violet,fontSize: 16),
                      ),
                      FlatButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child:   Text(
                            'Login',
                            style: TextStyle(color: purple,fontSize: 16),
                          )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),


    );
  }
}