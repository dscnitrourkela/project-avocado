import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
                IconButton(
                  padding: EdgeInsets.only(
                      top: SizeConfig.screenWidth * 0.048,
                      right: SizeConfig.screenWidth * 0.06),
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.black,
                    size: 35.0,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.rNots);
                  },
                )
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
    fetchUserData(context);
    reset();
    _fcm.subscribeToTopic('ics-not');
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

    /*if(DateTime.now().weekday == 3){
     if(DateTime.now().hour >= 4){
       slotsRefMain = FirebaseDatabase.instance.reference().child("slots").child('week1').child('counselor');
       ScpDatabase.pushNewWeek(slotsRefMain);
     }
    }*/
  }

  @override
  void dispose() {
    super.dispose();
    //ScpDatabase.pushNewWeek(slotsRefMain).clear();
  }

  Future fetchUserData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username');
    rollNo = prefs.getString('roll_no');
    phoneNo = prefs.getString('phone_no');
    prefs.setBool('hasBooked', prefs.getBool('hasBooked') ?? false);
    print(username + rollNo + phoneNo);
  }

  _launchURL() async {
    if (await canLaunch(privacyPolicy)) {
      await launch(privacyPolicy);
    } else {
      throw 'Could not launch $privacyPolicy';
    }
  }

// _startFAQActivity() async {
//   try {
//     await platform.invokeMethod('startFaqActivity');
//   } on PlatformException catch (e) {
//     print(e.message);
//   }
// }
}
