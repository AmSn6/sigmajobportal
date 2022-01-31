import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sigmajobportal/ui/category_screen.dart';
import 'package:sigmajobportal/ui/login_screen.dart';
import 'package:sigmajobportal/ui/register_screen.dart';
import 'package:sigmajobportal/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sigmajobportal/utils.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(RestartWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sigma Job Portal',
      debugShowCheckedModeBanner: false,
      // builder: (context, child) => ResponsiveWrapper.builder(
      //     BouncingScrollWrapper.builder(context, child),
      //     maxWidth: 1200,
      //     minWidth: 450,
      //     defaultScale: true,
      //     breakpoints: [
      //       ResponsiveBreakpoint.resize(450, name: MOBILE),
      //       ResponsiveBreakpoint.autoScale(800, name: TABLET),
      //       ResponsiveBreakpoint.autoScale(1000, name: TABLET),
      //       ResponsiveBreakpoint.resize(1200, name: DESKTOP),
      //       ResponsiveBreakpoint.autoScale(2460, name: "4K"),
      //     ],
      //     background: Container(color: Color(0xFFF5F5F5))),

      theme: ThemeData(primarySwatch: primarySwatch, fontFamily: 'Calibri'),
// home: RegisterScreen()
//
      home: MyHomePage(
//        random_user_imageM6Provider: AssetImage('assets/images/search.png'),
          ),
    );
  }
}
//72597

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isUpdateAvailable = false;
  String appURL = "https://play.google.com/store/apps/details?id=in.sigmacomputers.sigmajobportal";
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) async {
      checkUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purple,
      body: SafeArea(
        top: true,
        child: isUpdateAvailable ? oldVersionWidget(update: ()async{
          await launch(appURL);
        }):Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
                child: Image.asset(
              'assets/icons/mobileicon.jpg',
              height: 80,
            )),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'Sigma Job Portal',
                style: TextStyle(
                    color: white, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
            Spacer(),
            sigmaText(textColor: white)
          ],
        ),
      ),
    );
  }

  void checkUser() async {
    final storage = FlutterSecureStorage();
    if (await checkApkVersion()) {
      setState(() {
        isUpdateAvailable = true;
      });
    } else {
      setState(() {
        isUpdateAvailable = false;
      });
      String userID = await storage.read(key: skCandidateID);
      if (userID == null || userID.isEmpty) {
        push(context: context, pushReplacement: true, toWidget: LoginScreen());
      } else {
        push(
            context: context,
            pushReplacement: true,
            toWidget: CategoryScreen());
      }
    }
  }

  static Future<bool> checkApkVersion() async {
    try {
      AppUpdateInfo info = await InAppUpdate.checkForUpdate();
      print('info - ${info.updateAvailability == UpdateAvailability.updateAvailable}');
      return info.updateAvailability == UpdateAvailability.updateAvailable;
    } catch (e) {
      print('e - $e');
      return false;
    }
  }
  Widget oldVersionWidget({@required Function update}) {
    return Center(
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text('New Update Available'),
        content: Text(
            'Please Download the new Version of the App from Google Play Store'),
        actions: <Widget>[
          FlatButton(
            child: Text('Exit App'),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
          FlatButton(onPressed: update, child: Text('Update'))
        ],
      ),
    );
  }

}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
