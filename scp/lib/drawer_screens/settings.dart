import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String phoneNo = " ";
  bool state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(25, 39, 45, 1),
          title: Text(
            "Settings",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'PfDin',
                fontWeight: FontWeight.w600),
          )),
      body: FutureBuilder(
          future: fetchUserData(context),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Receive Non Academic Notifications',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      LiteRollingSwitch(
                        value: state,
                        textOff: 'No',
                        textOn: 'Yes',
                        colorOff: Colors.redAccent,
                        colorOn: Colors.green,
                        iconOff: Icons.notifications_off_outlined,
                        iconOn: Icons.notifications_outlined,
                        textSize: 16.0,
                        onChanged: (state) async {
                          unSubOther(state);
                        },
                      )
                    ],
                  ),
                );
              default:
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
            }
          }),
    );
  }

  Future fetchUserData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phoneNo = prefs.getString('phone_no');
    DocumentSnapshot qn =
        await Firestore.instance.collection('tokens').document(phoneNo).get();
    state = await qn.data['optionalSub'];

    return qn;
  }

  FirebaseMessaging _fcm = FirebaseMessaging();

  unSubOther(state) {
    if (state == false) {
      Firestore.instance
          .collection('tokens')
          .document(phoneNo)
          .updateData({'optionalSub': false});
      _fcm.unsubscribeFromTopic('other');
    } else {
      Firestore.instance
          .collection('tokens')
          .document(phoneNo)
          .updateData({'optionalSub': true});
      _fcm.subscribeToTopic('other');
    }
  }
}
