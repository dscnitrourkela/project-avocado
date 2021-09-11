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
  String username = " ", rollNo = " ", phoneNo = " ";
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
    username = prefs.getString('username');
    rollNo = prefs.getString('roll_no');
    DocumentSnapshot qn = await FirebaseFirestore.instance
        .collection('tokens')
        .doc(phoneNo)
        .get();
    Map<String, dynamic> mp = qn.data();
    state = await mp['optionalSub'];

    return qn;
  }

  //FirebaseMessaging _fcm = FirebaseMessaging();

  saveTokenToFirestore(String token) async {
    FirebaseFirestore.instance
        .collection('tokens')
        .where('mobile', isEqualTo: phoneNo)
        .get()
        .then((QuerySnapshot deviceToken) async {
      if (deviceToken.docs.isEmpty) {
        await FirebaseFirestore.instance.collection('tokens').doc(phoneNo).set({
          'devToken': token,
          'displayName': username,
          'roll': rollNo,
          'mobile': phoneNo,
          'optionalSub': true,
          'createdAt': FieldValue.serverTimestamp(),
        });
      } else {
        await FirebaseFirestore.instance
            .collection('tokens')
            .doc(phoneNo)
            .update({
          'devToken': token,
          'displayName': username,
        });
      }
    });
  }

  unSubOther(state) {
    if (state == false) {
      FirebaseFirestore.instance
          .collection('tokens')
          .doc(phoneNo)
          .update({'optionalSub': false});
      FirebaseMessaging.instance.unsubscribeFromTopic('other');
    } else {
      FirebaseFirestore.instance
          .collection('tokens')
          .doc(phoneNo)
          .update({'optionalSub': true});
      FirebaseMessaging.instance.subscribeToTopic('other');
    }
  }

  @override
  void initState() {
    super.initState();
    if (state == null) {
      state = true;
      final token = FirebaseMessaging.instance
          .getToken()
          .then((token) async => await saveTokenToFirestore(token.toString()));
    }
  }
}
