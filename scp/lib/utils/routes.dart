import 'package:flutter/material.dart';
import 'package:scp/acadVault.dart';
import 'package:scp/counselling/counsellingPage.dart';
import 'package:scp/drawer_screens/notifications/notifications_view.dart';
import 'package:scp/faqPage.dart';
import 'package:scp/home_page.dart';
import 'package:scp/chat.dart';
import 'package:scp/drawer_screens/about_scs.dart';
import 'package:scp/drawer_screens/dev_info.dart';
import 'package:scp/drawer_screens/important_documents.dart';
import 'package:scp/drawer_screens/settings.dart';
import 'package:scp/login.dart';
import 'package:scp/timetable/theorySection.dart';
import 'package:scp/drawer_screens/policies.dart';
import 'package:scp/ui/views/ics_events/events_view.dart';
import 'package:scp/userdata.dart';

class Routes {
  static const String rHomepage = '/homePage';
  static const String rAppointments = '/appointments';
  static const String rTimetable = '/timetable';
  static const String rCounselling = '/counselling';
  static const String rUserData = '/userdata';
  static const String rLogin = '/login';
  static const String rBooking = '/booking';
  static const String rAboutScp = '/about_scp';
  static const String rImpDocs = '/imp_docs';
  static const String rDevInfo = '/dev_info';
  static const String rNots = '/nots';
  static const String rAcadVault = '/acad_vault';
  static const String rPolicies = '/policies';
  static const String rAttendance = '/attendance';
  static const String rFaq = '/faq';
  static const String rSettings = '/settings';
  static const String rChat = '/chat';
  static const String rEvents = '/events';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.rHomepage: (context) => HomePage(),
      // Routes.rAppointments: (context) => Appointments(),
      Routes.rTimetable: (context) => TheorySection(0), //0 for left card
      Routes.rUserData: (context) => Userdata(),
      Routes.rCounselling: (context) => CounsellingPage(),
      Routes.rFaq: (context) => FaqPage(),
      Routes.rLogin: (context) => Login(),
      Routes.rPolicies: (context) => PoliciesPage(),
      Routes.rAcadVault: (context) => AcadVaultPage(),
      // Routes.rBooking: (context) => Booking(),
      Routes.rAboutScp: (context) => AboutSCP(),
      Routes.rImpDocs: (context) => ImpDocs(),
      Routes.rDevInfo: (context) => DevInfo(),
      Routes.rNots: (context) => Nots(),
      Routes.rSettings: (context) => Settings(),
      Routes.rAttendance: (context) => TheorySection(1), //1 for right card
      Routes.rChat: (context) => ChatView(),
      Routes.rEvents: (context) => EventsPage(),
    };
  }
}
