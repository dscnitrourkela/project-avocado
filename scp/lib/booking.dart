import 'dart:async';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:scp/firebase/firebaseDBHandler.dart';
import 'package:scp/utils/sizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Booking extends StatefulWidget {
  final String time;
  final String counselDay;

  Booking({this.time, this.counselDay});

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  bool hasBooked;
  String bookedDate, bookedTime, bookedSlot;
  double screenWidth;
  String counselDay, time, counselorName, psychName, psychDay, type;

  _BookingState({this.time, this.counselDay});

  @override
  void initState() {
    _setupRemoteConfig();
    getSharedPrefs();
    super.initState();
  }
  
  getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    type = prefs.getString('bookingType');
    hasBooked = prefs.getBool('hasBooked');
    bookedDate = prefs.getString('bookedDate');
    bookedTime = prefs.getString('bookedTime');
    //return prefs.getString('type');
  }

  // void cancelBooking() async {
  //   String bookedSlot;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   bookedSlot = prefs.getString('bookedSlot');

  //   if (type == "psych") {
  //     ScpDatabase.psychRef.child(bookedSlot).update({
  //       "phoneNo": "",
  //       "rollNo": "",
  //       "status": "0",
  //       "timestamp": DateTime.now().toString(),
  //     }).then((_) {
  //       print("Booking canceled");
  //       prefs.setBool('hasBooked', false);
  //       Navigator.of(context).pop();
  //       Navigator.of(context).pushNamed('/appointments');
  //     });
  //   } else {
  //     ScpDatabase.counselRef.child(bookedSlot).update({
  //       "phoneNo": "",
  //       "rollNo": "",
  //       "status": "0",
  //       "timestamp": DateTime.now().toString(),
  //     }).then((_) {
  //       print("Booking canceled");
  //       prefs.setBool('hasBooked', false);
  //       Navigator.of(context).pop();
  //       Navigator.of(context).pushNamed('/appointments');
  //     });
  //   }
  // }

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
    if (hasBooked) {}
    return remoteConfig;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    screenWidth = SizeConfig.screenWidth;
    //print(type + "Smarak");

    return Scaffold(
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
              'Confirmation',
              style: TextStyle(
                  fontSize: screenWidth * 0.065,
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
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/homePage');
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
          builder:
              (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot) {
            return (snapshot.hasData)
                ? Container(
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          bottom: 0.0,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: MaterialButton(
                              height: screenWidth * 0.116,
                              minWidth: screenWidth,
                              autofocus: false,
                              clipBehavior: Clip.none,
                              padding: EdgeInsets.all(8.0),
                              onPressed: () async {
                                String bookedSlot;
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();

                                bookedSlot = prefs.getString('bookedSlot');

                                if (type == "psych") {
                                  ScpDatabase.psychRef
                                      .child(bookedSlot)
                                      .update({
                                    "phoneNo": "",
                                    "rollNo": "",
                                    "status": "0",
                                    "timestamp": DateTime.now().toString(),
                                  }).then((_) {
                                    print("Booking canceled");
                                    prefs.setBool('hasBooked', false);
                                    prefs.setString('bookedSlot',"");
                                    Navigator.of(context).pop();
                                    Navigator.of(context)
                                        .pushNamed('/appointments');
                                  });
                                } else {
                                  ScpDatabase.counselRef
                                      .child(bookedSlot)
                                      .update({
                                    "phoneNo": "",
                                    "rollNo": "",
                                    "status": "0",
                                    //"timestamp": DateTime.now().toString(),
                                  }).then((_) {
                                    print("Booking canceled");
                                    prefs.setBool('hasBooked', false);
                                    Navigator.of(context).pop();
                                    Navigator.of(context)
                                        .pushNamed('/appointments');
                                  });
                                }
                              },
                              child: Text(
                                "Cancel Booking",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'PfDin',
                                    fontSize: screenWidth * 0.050),
                              ),
                              elevation: 4.0,
                              highlightElevation: 8.0,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Your Appointment with',
                                style: TextStyle(
                                  color: Colors.cyan,
                                  fontFamily: 'PfDin',
                                  fontSize: screenWidth * 0.060,
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                (type == "psych") ? psychName : counselorName,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenWidth * 0.12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'PfDin',
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'has been booked on',
                                style: TextStyle(
                                  color: Colors.cyan,
                                  fontFamily: 'PfDin',
                                  fontSize: screenWidth * 0.050,
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                '${(type == "psych") ? psychDay : counselDay} | $bookedDate | $bookedTime',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'PfDin',
                                    fontSize: screenWidth * 0.050,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
      backgroundColor: Colors.white,
    );
  }
}
