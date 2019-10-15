import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:scp/appointments.dart';
import 'package:scp/booking.dart';
import 'package:scp/drawer_screens/about_scs.dart';
import 'package:scp/drawer_screens/dev_info.dart';
import 'package:scp/drawer_screens/important_documents.dart';
import 'package:scp/login.dart';
import 'package:scp/userdata.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'mentor_search/mentors.dart';
import 'timetable/theorySection.dart';

var firebaseInstance = FirebaseAuth.instance;

void main() {
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runZoned<Future<void>>(() async {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SCS',
      routes: <String, WidgetBuilder>{
        '/homePage': (BuildContext context) => HomePage(title: 'SCS Home Page'),
        '/loginPage': (BuildContext context) => Login(),
        '/appointments': (BuildContext context) => Appointments(),
        '/timetable': (BuildContext context) => TheorySection(),
        '/userdata': (BuildContext context) => Userdata(),
        '/login': (BuildContext context) => Login(),
        '/booking': (BuildContext context) => Booking(),
        '/about_scp': (BuildContext context) => AboutSCP(),
        '/mentors': (BuildContext context) => Mentors(),
        '/imp_docs': (BuildContext context) => ImpDocs(),
        '/dev_info': (BuildContext context) => DevInfo()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyApp(),
    ));
  }, onError: Crashlytics.instance.recordError);
  FlutterError.onError = (FlutterErrorDetails details) {
    Crashlytics.instance.recordFlutterError(details);
  };
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _loggedin = (prefs.getBool('loggedin') ?? false);
    print(_loggedin);
    if (_loggedin) {
      Navigator.pushNamed(context, '/homePage');
    } else {
      Navigator.pushNamed(context, '/login');
//      Navigator.pushNamed(context, '/timetable');
    }
  }
}
