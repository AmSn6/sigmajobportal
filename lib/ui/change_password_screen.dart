import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sigmajobportal/models/common_response_model.dart';
import 'package:sigmajobportal/repository.dart';
import 'package:progress_button/progress_button.dart';
import 'package:rich_alert/rich_alert.dart';
import '../utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String currentPassword,newPassword,repeatPassword,user;
  bool isObscureOld = true;
  bool isObscureNew = true;
  bool isObscureConfirm = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarMethod('Change Password'),
      backgroundColor: grey,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Image.asset('assets/images/change-password.png',
                  height: MediaQuery.of(context).size.height / 3),
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(30)),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: isObscureOld
                          ? Icon(FeatherIcons.eye,size: 18)
                          : Icon(FeatherIcons.eyeOff,size: 18),
                      onPressed: () {
                        setState(() {
                          isObscureOld = !isObscureOld;
                        });
                      },
                    ),
                    hintText: 'Current Password',
                  ),
                  obscureText: isObscureOld,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Current Password';
                    }
                  },
                  onSaved: (value) {
                    currentPassword = value;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(30)),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: isObscureNew
                          ? Icon(FeatherIcons.eye,size: 18)
                          : Icon(FeatherIcons.eyeOff,size: 18),
                      onPressed: () {
                        setState(() {
                          isObscureNew = !isObscureNew;
                        });
                      },
                    ),
                    hintText: 'New Password',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter New Password';
                    }
                  },
                  onChanged: (val){
                    newPassword = val;
                  },
                  onSaved: (value) {
                    print(newPassword);
                    newPassword = value;
                  },
                  obscureText: isObscureNew,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(30)),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: isObscureConfirm
                          ? Icon(FeatherIcons.eye,size: 18,)
                          : Icon(FeatherIcons.eyeOff,size: 18),
                      onPressed: () {
                        setState(() {
                          isObscureConfirm = !isObscureConfirm;
                        });
                      },
                    ),
                    hintText: 'Repeat Password',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Repeat Password';
                    } else if (value != newPassword){
                      return 'Passwords doesn\'t match';
                    }
                  },
                  onSaved: (value) {
                    repeatPassword = value;
                  },
                  obscureText: isObscureConfirm,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ProgressButton(
                backgroundColor: purple,
                progressColor: white,
                child: buttonText('Save'),
                buttonState: isLoading ? ButtonState.inProgress : ButtonState.normal,
                onPressed: () async {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    String oldPass =await storage.read(key: passwordKey);

                    print('oldpass -$oldPass');
                    if(oldPass != currentPassword){
                      showToast('Incorrect Current Password!', red);
                    }else{
                       postChangePassword();
                    }

                  }
                },
              ),
              ]
              /*SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  shape: buttonShape(30),
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      postChangePassword();
                    }
                  },
                  color: purple,
                  child: Text(
                    'Save',
                    style: TextStyle(color: white),
                  ),
                ),
              ),
            ],*/
          ),
        ),
      ),
    );
  }

  void postChangePassword() async {
    setState(() {
      isLoading = true;
    });
    CommonResponseModel model = await changePassword(repeatPassword);
    showDialog(context: context,
    builder: (context){
      if(model.response == '1'){
        return customBackDialog(context: context, type: RichAlertType.SUCCESS,title: 'Success', subtitle: 'Password Changed Successfully', doubleBack: true);
      } else {
        setState(() {
          isLoading = false;
        });
        return customBackDialog(context: context, type: RichAlertType.ERROR,title: 'Error', subtitle: 'Try Again Later', doubleBack: true);
      }
    });
  }
}