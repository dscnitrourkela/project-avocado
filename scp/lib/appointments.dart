import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scp/cards.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class Appointments extends StatefulWidget {
  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  double queryWidth;
  double textScaleFactor;
  static String counselDay;

  /*Future<RemoteConfig> _initRemoteConfig() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      counselDay = remoteConfig.getString('counsel_day');
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      print(exception);
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
    //print(remoteConfig.getString('counsel_day') + 'hola');
    return remoteConfig;
  }*/

  @override
  Widget build(BuildContext context) {
    queryWidth = MediaQuery.of(context).size.width;
    textScaleFactor = MediaQuery.of(context).textScaleFactor;
    //_initRemoteConfig();

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
              child: Icon(
                Icons.arrow_back_ios,
              ),
            ),
            elevation: 0.0,
          ),
        ),
        body: FutureBuilder(
            future: _setupRemoteConfig(),
            builder: (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot) {
              return Center(child: snapshot.hasData ? bookingScreen(snapshot.data): CircularProgressIndicator());
            }));
  }

  Future<RemoteConfig> _setupRemoteConfig() async{
    RemoteConfig remoteConfig = await RemoteConfig.instance;
    // Enable developer mode to relax fetch throttling
    remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      counselDay = remoteConfig.getString('counsel_day');
    print(counselDay + 'hola');
    return remoteConfig;
  }

  Widget bookingScreen(RemoteConfig remoteConfig){
    return ListView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 30.0),
      children: <Widget>[
        slotCard(this.queryWidth, this.textScaleFactor, counselDay,
            'Pyschiatrist'),
        SizedBox(
          height: 40.0,
        ),
        slotCard(this.queryWidth, this.textScaleFactor, 'Dr. Jane Doe',
            'Counsellor'),
      ],
    );
  }
}
