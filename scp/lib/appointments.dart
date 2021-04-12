import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:scp/ui/cards.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:scp/firebase/firebaseDBHandler.dart';
import 'package:scp/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Appointments extends StatefulWidget {
  @override
  _AppointmentsState createState() => _AppointmentsState();
}

bool isBookingAnonymously;

class _AppointmentsState extends State<Appointments> {
  double queryWidth;
  double textScaleFactor;
  static String counselDay, counselorName, psychName, psychDay;
  StreamSubscription<Event> _onCounselChangedSubscription,
      _onPsychChangedSubscription;
  ScpDatabase scpDatabase;
  String psychDate, counselDate;

  void _onSlotsUpdated(Event event) async {
    setState(() {});
  }

  @override
  void initState() {
    /*ScpDatabase().init();*/
    getDate();
    //isBookingAnonymously = false;
    scpDatabase = ScpDatabase();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _onCounselChangedSubscription.cancel();
    _onPsychChangedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    queryWidth = MediaQuery.of(context).size.width;
    textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          60.0,
        ),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
            ),
            child: Text(
              'Book your appointment',
              style: TextStyle(
                  fontSize: queryWidth * 0.065,
                  fontFamily: 'PfDin',
                  fontWeight: FontWeight.w500),
            ),
          ),
          backgroundColor: Color.fromRGBO(
            54,
            66,
            87,
            1.0,
          ),
          leading: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context);
                Navigator.pushNamed(context, Routes.rHomepage);
              },
              icon: Icon(
                Icons.arrow_back_ios,
              ),
            ),
          ),
          elevation: 0.0,
        ),
      ),
      body: FutureBuilder(
        future: _setupRemoteConfig(),
        builder: (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot) {
          return Center(
            child: snapshot.hasData
                ? appointmentScreen(context, snapshot.data)
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        },
      ),
    );
  }

  Widget appointmentScreen(BuildContext context, RemoteConfig remoteConfig) {
    return ListView(
      physics: AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 30.0),
      children: <Widget>[
        //anonymousButton(),
        SizedBox(
          height: 20.0,
        ),
        slotCard(context, counselorName, 'counsel', 'Counsellor',
            ScpDatabase.counselCount, 0.85),
        SizedBox(
          height: 40.0,
        ),
        slotCard(context, psychName, 'psych', 'Psychiatrist',
            ScpDatabase.psychCount, 1.1),
      ],
    );
  }

  getDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getKeys();
    psychDate = prefs.getString('psychDate');
    counselDate = prefs.getString('counselDate');
  }

  Future<RemoteConfig> _setupRemoteConfig() async {
    RemoteConfig remoteConfig = await RemoteConfig.instance;
    // Enable developer mode to relax fetch throttling
    remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
    await remoteConfig.fetch(expiration: const Duration(seconds: 0));
    await remoteConfig.activateFetched();
    counselDay = remoteConfig.getString('counsel_day');
    counselorName = remoteConfig.getString('counselor_name');
    psychName = remoteConfig.getString('psych_name');
    psychDay = remoteConfig.getString('psych_day');
    print(counselDay + 'hola');
    await scpDatabase.init();
    _onCounselChangedSubscription =
        ScpDatabase.counselRef.onChildChanged.listen(_onSlotsUpdated);
    _onPsychChangedSubscription =
        ScpDatabase.psychRef.onChildChanged.listen(_onSlotsUpdated);
    return remoteConfig;
  }
}
