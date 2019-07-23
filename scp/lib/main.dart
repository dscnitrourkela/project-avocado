import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scp/booking.dart';
import 'package:scp/cards.dart';
import 'package:scp/drawer_screens/about_scp.dart';
import 'package:scp/drawer_screens/dev_info.dart';
import 'package:scp/drawer_screens/important_documents.dart';
import 'package:scp/login.dart';
import 'package:scp/gradients.dart';
import 'package:scp/appointments.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:scp/mentors.dart';
import 'package:scp/userdata.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'timetable/theorySection.dart';

import 'package:scp/time_table.dart';

var firebaseInstance = FirebaseAuth.instance;
final PRIVACY_POLICY="https://google.com";
void main() => runApp(MaterialApp(
      title: 'SCP Demo',
      routes: <String, WidgetBuilder>{
        '/homePage': (BuildContext context) => HomePage(title: 'SCP Home Page'),
        '/loginPage': (BuildContext context) => Login(),
        '/appointments': (BuildContext context) => Appointments(),
        '/timetable': (BuildContext context) => TheorySection(),
        '/userdata': (BuildContext context) => Userdata(),
        '/login': (BuildContext context) => Login(),
        '/booking': (BuildContext context) => Booking(),
        '/about_scp':(BuildContext context)=>AboutSCP(),
        '/mentors':(BuildContext context)=>Mentors(),
        '/imp_docs':(BuildContext context)=>ImpDocs(),
        '/dev_info':(BuildContext context)=>DevInfo()

      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyApp(),
    ));

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
    }
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = " ", rollNo = " ", phoneNo = " ";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static const platform = const MethodChannel("FAQ_ACTIVITY");
  @override
  Widget build(BuildContext context) {
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    var queryWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return FutureBuilder(
      future: fetchUserData(context),
      builder: (context,snap){
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
                            style: TextStyle(fontSize: 25.0, fontFamily: 'PfDin'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(phoneNo,style: TextStyle(fontSize: 15.0, fontFamily: 'PfDin'),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(rollNo,style: TextStyle(fontSize: 15.0, fontFamily: 'PfDin'),),
                          )
                        ],
                      )),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ListTile(
                          onTap:(){
                            Navigator.of(context).pushNamed('/imp_docs');
                         },
                          title: Text("Important Documents",style: TextStyle(fontSize: 18.0, fontFamily: 'PfDin'),),
                        ),
                        ListTile(
                          onTap:(){
                            Navigator.pushNamed(context, '/about_scp');
                          },
                          title: Text("About SCP",style: TextStyle(fontSize: 18.0, fontFamily: 'PfDin'),),
                        ),
                        ListTile(
                          onTap:(){
                            _launchURL();
                          },
                          title: Text("Privacy Policy",style: TextStyle(fontSize: 18.0, fontFamily: 'PfDin'),),
                        ),
                        ListTile(
                          onTap:(){
                            Navigator.of(context).pushNamed('/dev_info');
                          },
                          title: Text("Developer Info",style: TextStyle(fontSize: 18.0, fontFamily: 'PfDin'),),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: ButtonTheme(
                          minWidth: 200,
                          height: 40,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:BorderRadius.circular(8.0)
                              ),
                              color: Color.fromRGBO(25, 39, 45, 1),
                            onPressed:(){
                              _removeUserData(context);
                            },
                            child: Text("Log Out",style:TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily:'PfDin',
                                color: Colors.white,
                                fontSize: 20*textScaleFactor
                            ),),
                          ),
                        ),
                      ))
                ],
              )),
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.menu,color:Colors.black,),onPressed: ()=>_scaffoldKey.currentState.openDrawer()),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'SCP',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'PfDin',
                  letterSpacing: 2),
            ),
          ),
          backgroundColor: Colors.white,
          body: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              appointmentCard(context, queryWidth, textScaleFactor),
              timetableCard(context, queryWidth, textScaleFactor),
              faqCard(context, queryWidth, textScaleFactor),
              mentorsCard(context, queryWidth, textScaleFactor),

            ],
          ),
        );
      },
    );
  }

  _removeUserData(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await firebaseInstance.signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  _startFAQActivity() async {
    try {
      await platform.invokeMethod('startFaqActivity');
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  @override
  void initState() {
    fetchUserData(context);
       super.initState();
  }

  Future fetchUserData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username');
    rollNo = prefs.getString('roll_no');
    phoneNo = prefs.getString('phone_no');
    print(username + rollNo + phoneNo);
  }

  _launchURL() async {
    if (await canLaunch(PRIVACY_POLICY)) {
      await launch(PRIVACY_POLICY);
    } else {
      throw 'Could not launch $PRIVACY_POLICY';
    }
  }
}
