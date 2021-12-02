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
  bool isAutumn;
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
                  margin: EdgeInsets.all(0),
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
                  ),
                ),
                Expanded(
                  flex: 8,
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
                      ListTile(
                        onTap: () {
                          _launchLink('https://ics.nitrkl.ac.in/');
                        },
                        title: Text(
                          "ICS Website",
                          style: TextStyle(
                              fontSize: SizeConfig.drawerItemTextSize,
                              fontFamily: 'PfDin'),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          _launchLink('https://www.youtube.com/c/ICSNITR');
                        },
                        title: Text(
                          "ICS YouTube",
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
                      child: ElevatedButton(
                        onPressed: () {
                          _removeUserData(context);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          primary: Color.fromRGBO(25, 39, 45, 1),
                        ),
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
                  ),
                )
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
              child: (snap.connectionState == ConnectionState.done)
                  ? ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        appointmentCard(context),
                        TimetableCardSplit(
                            context,
                            MediaQuery.of(context).size.width,
                            MediaQuery.of(context).textScaleFactor),
                        faqCard(context),
                        eventsCard(context),
                        mentorsCard(context, rollNo),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
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
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage();
    }

    FirebaseMessaging.onMessage.listen((event) {
      Navigator.pushNamed(context, Routes.rNots);
    });
    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(
      (event) => _handleMessage(),
    );
  }

  void _handleMessage() {
    Navigator.pushNamed(context, Routes.rNots);
  }

  @override
  void initState() {
    super.initState();
    DateConfig().init();
    FirebaseMessaging.instance.subscribeToTopic('academic');
    setupInteractedMessage();
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
    remoteConfig = RemoteConfig.instance;
    remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: Duration.zero,
    ));
    try {
      await remoteConfig.fetch();
      await remoteConfig.fetchAndActivate();

      isChat = remoteConfig.getBool('is_chat_active');
      publishVersion = remoteConfig.getInt('publishVersion');
      chatUrl = remoteConfig.getString('chatLink');
      isAutumn = remoteConfig.getBool('is_autumn');

      publishVersion = int.parse(remoteConfig.getString("version"));
      print(publishVersion);
      await prefs.setBool('is_chat_active', isChat);
      await prefs.setString('chatLink', chatUrl);
      await prefs.setBool('is_autumn', isAutumn);
    } on PlatformException catch (exception) {
      isChat = prefs.getBool('is_chat_active');
      chatUrl = prefs.getString('chatLink');
      isAutumn = prefs.getBool('is_autumn');
      // Fetch throttled.
      print(exception);
    } catch (exception) {
      isChat = prefs.getBool('is_chat_active');
      chatUrl = prefs.getString('chatLink');
      isAutumn = prefs.getBool('is_autumn');
    }

    isChat = remoteConfig.getBool('is_chat_active');
    chatUrl = remoteConfig.getString('chatLink');
    username = prefs.getString('username');
    isAutumn = prefs.getBool('is_autumn');
    rollNo = prefs.getString('roll_no');
    phoneNo = prefs.getString('phone_no');
    await prefs.setBool('hasBooked', prefs.getBool('hasBooked') ?? false);
    print(username + rollNo + phoneNo + isAutumn.toString());
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
              TextButton(
                  child: Text("Update"), onPressed: () => _launchUpdate()),
              TextButton(
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

  _launchLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
