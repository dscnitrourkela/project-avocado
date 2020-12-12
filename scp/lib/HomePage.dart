import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ndialog/ndialog.dart';
import 'package:scp/utils/chatArgs.dart';
import 'package:scp/utils/routes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scp/utils/sizeConfig.dart';
import 'package:scp/timetablecardsplit.dart';
import 'package:scp/ui/cards.dart';
import 'package:scp/dateConfig.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:in_app_review/in_app_review.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = " ", rollNo = " ", phoneNo = " ";
  DatabaseReference slotsRefMain;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  RemoteConfig remoteConfig;
  bool isChat = false;
  String chatUrl;
  int buildNumber;
  int publishVersion;

  static const platform = const MethodChannel("FAQ_ACTIVITY");

  @override
  Widget build(BuildContext context) {
    print(DateTime.now().weekday);
    print(DateTime.now().hour);
    SizeConfig().init(context);
    //ScpDatabase.pushNewWeek(slotsRefMain);

    //Map jMap = json.decode(jsonT);
    //print(jMap);

    FirebaseDatabase.instance.setPersistenceEnabled(true);
    // var queryWidth = MediaQuery.of(context).size.width;
    // var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: FutureBuilder(
        future: fetchUserData(context),
        builder: (context, snap) {
          checkUpdate();
          return Scaffold(
            key: _scaffoldKey,
            drawer: Drawer(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                DrawerHeader(
                    child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      username,
                      style: TextStyle(
                          fontSize: SizeConfig.screenWidth * 0.058,
                          fontFamily: 'PfDin'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        phoneNo,
                        style: TextStyle(
                            fontSize: SizeConfig.screenWidth * 0.035,
                            fontFamily: 'PfDin'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        rollNo,
                        style: TextStyle(
                            fontSize: SizeConfig.screenWidth * 0.035,
                            fontFamily: 'PfDin'),
                      ),
                    )
                  ],
                )),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(Routes.rImpDocs);
                        },
                        title: Text(
                          "Important Documents",
                          style: TextStyle(
                              fontSize: SizeConfig.drawerItemTextSize,
                              fontFamily: 'PfDin'),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.rNots);
                        },
                        title: Text(
                          "Notifications",
                          style: TextStyle(
                              fontSize: SizeConfig.drawerItemTextSize,
                              fontFamily: 'PfDin'),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(Routes.rSettings);
                        },
                        title: Text(
                          "Settings",
                          style: TextStyle(
                              fontSize: SizeConfig.drawerItemTextSize,
                              fontFamily: 'PfDin'),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.rAboutScp);
                        },
                        title: Text(
                          "About ICS",
                          style: TextStyle(
                              fontSize: SizeConfig.drawerItemTextSize,
                              fontFamily: 'PfDin'),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          _launchURL();
                        },
                        title: Text(
                          "Privacy Policy",
                          style: TextStyle(
                              fontSize: SizeConfig.drawerItemTextSize,
                              fontFamily: 'PfDin'),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(Routes.rDevInfo);
                        },
                        title: Text(
                          "Developer Info",
                          style: TextStyle(
                              fontSize: SizeConfig.drawerItemTextSize,
                              fontFamily: 'PfDin'),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: ButtonTheme(
                        minWidth: SizeConfig.screenWidth * 0.463,
                        height: SizeConfig.screenWidth * 0.093,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          color: Color.fromRGBO(25, 39, 45, 1),
                          onPressed: () {
                            _removeUserData(context);
                          },
                          child: Text(
                            "Log Out",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'PfDin',
                                color: Colors.white,
                                fontSize: SizeConfig.screenWidth * 0.046),
                          ),
                        ),
                      ),
                    ))
              ],
            )),
            appBar: AppBar(
              leading: Padding(
                padding: EdgeInsets.only(top: SizeConfig.screenWidth * 0.037),
                child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.black,
                      size: 35.0,
                    ),
                    onPressed: () => _scaffoldKey.currentState.openDrawer()),
              ),
              actions: <Widget>[
                (snap.connectionState != ConnectionState.waiting ||
                        snap.connectionState != ConnectionState.waiting)
                    ? (isChat
                        ? IconButton(
                            padding: EdgeInsets.only(
                                top: SizeConfig.screenWidth * 0.048,
                                right: SizeConfig.screenWidth * 0.06),
                            icon: Icon(
                              Icons.chat,
                              color: Colors.black,
                              size: 35.0,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.rChat,
                                  arguments: ChatArguments(chatUrl));
                            },
                          )
                        : Container())
                    : Container(),
              ],
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Padding(
                padding: EdgeInsets.only(top: SizeConfig.screenWidth * 0.037),
                child: Text(
                  'ICS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'PfDin',
                      letterSpacing: 2),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  appointmentCard(context),
                  TimetableCardSplit(context, MediaQuery.of(context).size.width,
                      MediaQuery.of(context).textScaleFactor),
                  faqCard(context),
                  mentorsCard(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _removeUserData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getKeys();
    prefs.clear();
    await firebaseInstance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.rLogin, (Route<dynamic> route) => false);
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
  }

  // _startFAQActivity() async {
  //   try {
  //     await platform.invokeMethod('startFaqActivity');
  //   } on PlatformException catch (e) {
  //     print(e.message);
  //   }
  // }

  FirebaseMessaging _fcm = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
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
  }

  @override
  void dispose() {
    super.dispose();
    //ScpDatabase.pushNewWeek(slotsRefMain).clear();
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
  }

  void checkUpdate() async {
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

  _launchUpdate() async {
    if (await canLaunch(playstoreURL)) {
      await launch(playstoreURL);
    } else {
      throw 'Could not launch $playstoreURL';
    }
  }

  _launchURL() async {
    if (await canLaunch(privacyPolicy)) {
      await launch(privacyPolicy);
    } else {
      throw 'Could not launch $privacyPolicy';
    }
  }
}
