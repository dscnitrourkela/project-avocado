import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:scp/SplashScreen.dart';
import 'package:scp/app/locator.dart';
import 'package:scp/utils/routes.dart';
import 'dart:async';

var firebaseInstance = FirebaseAuth.instance;
final privacyPolicy = "https://project-avocado-8b3e1.firebaseapp.com";
final playstoreURL =
    "https://play.google.com/store/apps/details?id=in.ac.nitrkl.scp.scp";

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
    setupLocator();
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ICS',
      routes: Routes.getRoutes(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    ));
  }, onError: Crashlytics.instance.recordError);
  FlutterError.onError = (FlutterErrorDetails details) {
    Crashlytics.instance.recordFlutterError(details);
  };
}
