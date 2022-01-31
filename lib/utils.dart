import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info/package_info.dart';
import 'package:sigmajobportal/main.dart';
import 'package:sigmajobportal/repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rich_alert/rich_alert.dart';

String skCandidateID = 'candidate_id';
String skCandidateName = 'candidate_name';
String skUserName = 'user_name';
String skBaseURL = 'base_url';
String passwordKey = 'password';

Color grey = Color(0xffEDECF4);
Color orange = Color(0xffff884d);
Color red = Colors.red;
Color blue = Color(0xff4da6ff);
//Color purple = Color(0xff9141E3);
Color purple = Color(0xff3c5a99);
Color violet = Color(0xff676688);
Color white = Colors.white;
Color black = Colors.black;
Color grey1 = Colors.grey;
Color transparent = Colors.transparent;
Color purple1 = Color(0xffd9b3ff);
Color lavender = Color(0xffeee6ff);
Color lightGreen = Colors.lightGreen;
Color green = Colors.green;
Color lightYellow = Color(0xffffcc66);
Color pink = Colors.pinkAccent;
//Color pink1 = Color(0xffEB4972);
//Color darkViolet = Color(0xff661B70);
//#6D3E6C
const MaterialColor primarySwatch = MaterialColor(
  _primaryValue,
  <int, Color>{
    50: Color(0xff3c5a99),
    100: Color(0xff3c5a99),
    200: Color(0xff3c5a99),
    300: Color(0xff3c5a99),
    400: Color(0xff3c5a99),
    500: Color(_primaryValue),
    600: Color(0xff3c5a99),
    700: Color(0xff3c5a99),
    800: Color(0xff3c5a99),
    900: Color(0xff3c5a99),
  },
);
const int _primaryValue = 0xff3c5a99;

Text h1Text(String title) {
  return Text(
    title,
    style: TextStyle(color: violet, fontWeight: FontWeight.bold, fontSize: 18),
  );
}

Text buttonText(String text) {
  return Text(
    text,
    style: TextStyle(
      color: white,
    ),
  );
}

Text bottomNavText(String bottomText) {
  return Text(
    bottomText,
    style: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  );
}

Text h2Text(String text) {
  return Text(
    text,
    style: TextStyle(fontSize: 16, color: grey1),
  );
}


Future<String> getAppVersion() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

Widget sigmaText({@required Color textColor}) {
  return GestureDetector(
    onTap: () {
      launch('http://www.sigmacomputers.in');
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FutureBuilder<String>(
            future: getAppVersion(),
            builder: (context, snapshot) {
              return Text(
                'App Version ${snapshot.data ?? ''}',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: textColor.withOpacity(.5)),
              );
            }),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/icons/mobileicon.jpg',
              height: 40,
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Powered By ',
                    style: TextStyle(
                        color: textColor.withOpacity(.5),
                        fontStyle: FontStyle.italic,
                        fontSize: 12)),
                Text(
                  'Sigma',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: textColor,
                      fontFamily: 'Font',
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )
              ],
            ),
// RichText(
//   text: TextSpan(
//       text: 'Powered by ',
//       style: TextStyle(
//           color: textColor, fontStyle: FontStyle.italic),
//       children: [
//         TextSpan(
//             text: 'SIGMA,Salem',
//             style: TextStyle(
//                 color: textColor,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16))
//       ]),
// )
          ],
        ),
        SizedBox(
          height: 15,
        )
      ],
    ),
  );
}

AppBar appbarMethod(String appbarTitle,
    {bool centerTitle = true, List<Widget> actions}) {
  return AppBar(
    elevation: 0,
    iconTheme: IconThemeData(color: white),
    // backgroundColor: grey,
    backgroundColor: purple,

    title: Text(
      appbarTitle,
      style: TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: 18),
    ),
    centerTitle: centerTitle,
    actions: actions,
  );
}

void push(
    {@required BuildContext context,
    @required bool pushReplacement,
    @required Widget toWidget}) {
  if (pushReplacement) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ConnectivityBuilder(
                  builder: (context, isConnected, status) {
                    return isConnected == null || !isConnected
                        ? noInternetWidget(context)
                        : toWidget;
                  },
                )));
  } else {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConnectivityBuilder(
                  builder: (context, isConnected, status) {
                    return isConnected == null || !isConnected
                        ? noInternetWidget(context)
                        : toWidget;
                  },
                )));
  }
}

noInternetWidget(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    color: Colors.white,
    child: Center(
      child: AlertDialog(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Check your Internet Connection',
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Lottie.asset('assets/json/no-internet.json', height: 200),
        actions: <Widget>[
          FlatButton(
              onPressed: () => SystemNavigator.pop(), child: Text('Exit App!'))
        ],
      ),
    ),
  );
}

RichAlertDialog customBackDialog(
    {@required BuildContext context,
    @required int type,
    bool isRestartApp = false,
    String title,
    String subtitle,
    bool doubleBack = true}) {
  return RichAlertDialog(
    alertTitle: richTitle(title),
    alertSubtitle: richSubtitle(subtitle),
    alertType: type,
    actions: <Widget>[
      RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: purple,
          textColor: white,
          onPressed: () {
            if (isRestartApp) {
              RestartWidget.restartApp(context);
            } else {
              Navigator.pop(context);
              if (doubleBack) Navigator.pop(context);
            }
          },
          child: Text('Okay'))
    ],
  );
}

Widget errorWidget(BuildContext context) {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Image.asset(
        'assets/images/error.png',
        height: 250,
        width: 250,
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        'Server Error!',
        style:
            TextStyle(color: orange, fontSize: 25, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 20,
      ),
      SizedBox(
        height: 50,
        width: 200,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          onPressed: () {
            getBaseURL().then((val) {
              push(context: context, pushReplacement: true, toWidget: MyApp());
            });
          },
          color: orange,
          child: buttonText('Retry'),
        ),
      )
    ],
  ));
}

RoundedRectangleBorder buttonShape(double radius) {
  return RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));
}

void showCustomSnackBar(
    {@required GlobalKey<ScaffoldState> key, @required String title}) {
  key.currentState
      .showSnackBar(SnackBar(content: Text(title), backgroundColor: red));
}

Widget imageWidget(String imageURL, double height) {
  return ExtendedImage.network(
    imageURL,
    height: height,
    shape: BoxShape.circle,
    borderRadius: BorderRadius.circular(20),
    loadStateChanged: (state) {
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          return Image.asset(
            'assets/images/load.gif',
            fit: BoxFit.fill,
          );
          break;
        case LoadState.completed:
          return ExtendedRawImage(
            image: state.extendedImageInfo?.image,
            fit: BoxFit.fill,
          );
          break;
        case LoadState.failed:
          return Image.asset(
            'assets/images/image-error.png',
            fit: BoxFit.fill,
          );
          break;
      }
    },
  );
}

// Future<bool> onBackPressed() {
//   DateTime now = DateTime.now();
//   if (currentBackPressTime == null ||
//       now.difference(currentBackPressTime) > Duration(seconds: 2)) {
//     currentBackPressTime = now;
//     showToast('Press Again to Exit', purple);
//     return Future.value(false);
//   }
//   return Future.value(true);
// }

void showToast(String message, Color color) async {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}
