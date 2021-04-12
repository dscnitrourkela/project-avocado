import 'package:flutter/material.dart';
import 'package:scp/HomePage.dart';
import 'package:scp/booking.dart';
import 'package:scp/chat.dart';
import 'package:scp/drawer_screens/about_scs.dart';
import 'package:scp/drawer_screens/dev_info.dart';
import 'package:scp/drawer_screens/important_documents.dart';
import 'package:scp/drawer_screens/notifications/notifications_view.dart';
import 'package:scp/drawer_screens/settings.dart';
import 'package:scp/login.dart';
import 'package:scp/timetable/theorySection.dart';
import 'package:scp/appointments.dart';
import 'package:scp/userdata.dart';

class Routes {
  static const String rHomepage = '/homePage';
  static const String rAppointments = '/appointments';
  static const String rTimetable = '/timetable';
  static const String rUserData = '/userdata';
  static const String rLogin = '/login';
  static const String rBooking = '/booking';
  static const String rAboutScp = '/about_scp';
  static const String rImpDocs = '/imp_docs';
  static const String rDevInfo = '/dev_info';
  static const String rNots = '/nots';
  static const String rAttendance = '/attendance';
  static const String rSettings = '/settings';
  static const String rChat = '/chat';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.rHomepage: (context) => HomePage(),
      Routes.rAppointments: (context) => Appointments(),
      Routes.rTimetable: (context) => TheorySection(0), //0 for left card
      Routes.rUserData: (context) => Userdata(),
      Routes.rLogin: (context) => Login(),
      Routes.rBooking: (context) => Booking(),
      Routes.rAboutScp: (context) => AboutSCP(),
      Routes.rImpDocs: (context) => ImpDocs(),
      Routes.rDevInfo: (context) => DevInfo(),
      Routes.rNots: (context) => Nots(),
      Routes.rSettings: (context) => Settings(),
      Routes.rAttendance: (context) => TheorySection(1), //1 for right card
      Routes.rChat: (context) => ChatView(),
    };
  }
}
