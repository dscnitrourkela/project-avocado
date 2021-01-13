import 'package:stacked/stacked.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scp/dateConfig.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info/package_info.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:scp/utils/routes.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeViewModel extends BaseViewModel {
  String username = " ", rollNo = " ", phoneNo = " ";
  DatabaseReference slotsRefMain;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  RemoteConfig remoteConfig;
  bool isChat = false;
  String chatUrl;
  int buildNumber;
  int publishVersion;

  removeUserData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getKeys();
    prefs.clear();
    await firebaseInstance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.rLogin, (Route<dynamic> route) => false);
    notifyListeners();
  }

  reset() async {
    var wednesday = 3;
    var now = DateTime.now();
    //var bookedDate = DateTime.parse(formattedString)
    // int dayFromEpoch = (DateTime.now().millisecondsSinceEpoch/(fac)).floor();
    // print("Smarak ${((dayFromEpoch - 1)/7).floor()}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.getBool('hasBooked')) {
      prefs.setString('bookDate', DateTime.now().toString());
    }

    if (now.day > (DateTime.parse(prefs.getString('bookDate')).day)) {
      prefs.setBool('hasBooked', false);
    }
    /*if(DateTime.now().weekday > 3)*/
    while (now.weekday != wednesday) {
      now = now.add(new Duration(days: 1));
      //print(now);
    }

    print(DateFormat.d().format(now) + " " + DateFormat.MMM().format(now));
    prefs.setString('psychDate',
        DateFormat.d().format(now) + " " + DateFormat.MMM().format(now));
    prefs.setString(
        'counselDate',
        DateFormat.d().format(now.subtract(Duration(days: 1))) +
            " " +
            DateFormat.MMM().format(now.subtract(Duration(days: 1))));
    notifyListeners();
  }

  // _startFAQActivity() async {
  //   try {
  //     await platform.invokeMethod('startFaqActivity');
  //   } on PlatformException catch (e) {
  //     print(e.message);
  //   }
  // }

  FirebaseMessaging _fcm = new FirebaseMessaging();

  void initState(BuildContext context) {
    DateConfig().init();
    _fcm.subscribeToTopic('academic');
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        Navigator.pushNamed(context, Routes.rNots);
      },
      onLaunch: (Map<String, dynamic> message) async {
        Navigator.pushNamed(context, Routes.rNots);
      },
      onResume: (Map<String, dynamic> message) async {
        Navigator.pushNamed(context, Routes.rNots);
      },
    );
    rateApp(context);
    notifyListeners();
  }

  void rateApp(BuildContext context) async {
    RateMyApp rateMyApp = RateMyApp(
      preferencesPrefix: 'rateMyApp_',
      minDays: 7,
      minLaunches: 10,
      remindDays: 7,
      remindLaunches: 10,
      googlePlayIdentifier: 'in.ac.nitrkl.scp.scp',
    );
    final InAppReview inAppReview = InAppReview.instance;
    rateMyApp.init().then((value) async {
      if (await inAppReview.isAvailable()) {
        inAppReview.requestReview();
      }
    });
    notifyListeners();
  }

  Future fetchUserData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getKeys();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    buildNumber = int.parse(packageInfo.buildNumber);
    remoteConfig = await RemoteConfig.instance;
    remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
    try {
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      isChat = remoteConfig.getBool('is_chat_active');
      chatUrl = remoteConfig.getString('chatLink');
      publishVersion = int.parse(remoteConfig.getString("version"));
      await prefs.setBool('is_chat_active', isChat);
      await prefs.setString('chatLink', chatUrl);
    } on FetchThrottledException catch (exception) {
      isChat = prefs.getBool('is_chat_active');
      chatUrl = prefs.getString('chatLink');
      // Fetch throttled.
      print(exception);
    } catch (exception) {
      isChat = prefs.getBool('is_chat_active');
      chatUrl = prefs.getString('chatLink');
    }

    isChat = remoteConfig.getBool('is_chat_active');
    chatUrl = remoteConfig.getString('chatLink');
    username = prefs.getString('username');
    rollNo = prefs.getString('roll_no');
    phoneNo = prefs.getString('phone_no');
    await prefs.setBool('hasBooked', prefs.getBool('hasBooked') ?? false);
    print(username + rollNo + phoneNo);
    reset();
    print(
        "Version number is $buildNumber and version on remote config is $publishVersion");
    if (buildNumber < publishVersion) {}
    notifyListeners();
  }

  _launchUpdate() async {
    if (await canLaunch(playstoreURL)) {
      await launch(playstoreURL);
    } else {
      throw 'Could not launch $playstoreURL';
    }
    notifyListeners();
  }

  launchURL() async {
    if (await canLaunch(privacyPolicy)) {
      await launch(privacyPolicy);
    } else {
      throw 'Could not launch $privacyPolicy';
    }
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    notifyListeners();
    //ScpDatabase.pushNewWeek(slotsRefMain).clear();
  }

  void checkUpdate(BuildContext context) async {
    if (buildNumber < publishVersion) {
      Future.delayed(const Duration(milliseconds: 2000), () async {
        print("It should update");
        await DialogBackground(
          dismissable: true,
          blur: 2.0,
          dialog: AlertDialog(
            title: Text("Update Available"),
            content: Text(
                "The current version of the ICS app is outdated. Kindly update the app to get new features/bug fixes."),
            actions: <Widget>[
              FlatButton(
                  child: Text("Update"), onPressed: () => _launchUpdate()),
              FlatButton(
                child: Text("Later"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ).show(context);
      });
    } else
      print("Not updating");
  }
}
