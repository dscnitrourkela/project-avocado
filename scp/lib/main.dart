import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scp/booking.dart';
import 'package:scp/drawer_screens/about_scs.dart';
import 'package:scp/drawer_screens/notifications.dart';
import 'package:scp/drawer_screens/dev_info.dart';
import 'package:scp/drawer_screens/important_documents.dart';
import 'package:scp/login.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:scp/appointments.dart';
import 'dart:async';
import 'mentor_search/mentors.dart';
import 'package:scp/userdata.dart';
import 'timetable/theorySection.dart';
import 'package:scp/timetable/tutorialSection.dart';
import 'HomePage.dart';
import 'myApp.dart';

var firebaseInstance = FirebaseAuth.instance;
final privacyPolicy = "https://project-avocado-8b3e1.firebaseapp.com";

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }
  // Or do other work.
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runZoned<Future<void>>(() async {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ICS',
      routes: <String, WidgetBuilder>{
        HomePage.id: (BuildContext context) => HomePage(title: 'ICS Home Page'),
        Appointments.id: (BuildContext context) => Appointments(),
        TheorySection.id: (BuildContext context) => TheorySection(),
        Userdata.id: (BuildContext context) => Userdata(),
        Login.id: (BuildContext context) => Login(),
        Booking.id: (BuildContext context) => Booking(),
        AboutSCP.id: (BuildContext context) => AboutSCP(),
        Mentors.id: (BuildContext context) => Mentors(),
        ImpDocs.id: (BuildContext context) => ImpDocs(),
        DevInfo.id: (BuildContext context) => DevInfo(),
        Nots.id: (BuildContext context) => Nots(),
        TutorialSection.id: (BuildContext context) => TutorialSection()
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
