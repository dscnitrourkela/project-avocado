import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scp/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userdata extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserdataState();
  }
}

class UserdataState extends State<Userdata> {
  final rollController = TextEditingController();
  var usernameController = TextEditingController();
  String rollNo = "", username = "", phoneNo = "";
  bool isEarlierLoggedIn = false;
  RegExp pattern = new RegExp(
    r'[0-9][0-9][0-9][a-zA-Z][a-zA-Z][0-9][0-9][0-9][0-9]',
    multiLine: false,
    caseSensitive: false,
  );

  @override
  Widget build(BuildContext context) {
    //var queryWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    _fetchUserData(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(25, 39, 45, 1),
          title: Text(
            "Enter your details here",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'PfDin',
                fontWeight: FontWeight.w600),
          )),
      body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                  future: inputData(),
                  builder: (context, list) {
                    if (list.hasData) {
                      return Center(
                        child: Column(children: <Widget>[
                          Text(
                            "Phone Number",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'PfDin',
                              color: Color.fromRGBO(74, 232, 190, 1),
                            ),
                          ),
                          Text(
                            phoneNo,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'PfDin',
                              color: Color.fromRGBO(25, 39, 45, 1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40.0, right: 40.0, top: 20),
                            child: Material(
                              elevation: 10.0,
                              shadowColor: Colors.white70,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              child: TextField(
                                enableInteractiveSelection: false,
                                style: TextStyle(
                                  fontFamily: "PfDin",
                                ),
                                autofocus: !isEarlierLoggedIn,
                                textCapitalization:
                                    TextCapitalization.characters,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: 'Enter Roll No.',
                                    border: InputBorder.none),
                                onChanged: (value) {
                                  rollNo = value.trim();
                                },
                                controller: rollController,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40.0, right: 40.0, top: 20),
                            child: Material(
                              elevation: 10.0,
                              shadowColor: Colors.white70,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              child: TextField(
                                enableInteractiveSelection: false,
                                style: TextStyle(
                                  fontFamily: "PfDin",
                                ),
                                autofocus: isEarlierLoggedIn,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                textInputAction: TextInputAction.done,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: 'Enter Name',
                                    border: InputBorder.none),
                                onChanged: (value) {
                                  username = value;
                                },
                                controller: usernameController,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(36.0),
                            child: ButtonTheme(
                              height: 40,
                              minWidth: 100,
                              child: RaisedButton(
                                  onPressed: () {
                                    //FirebaseUser fireuser;
                                    //fireuser.displayName;

                                    if (rollNo != "" &&
                                        rollNo != null &&
                                        rollNo != "null" &&
                                        (rollNo.length == 9) &&
                                        (pattern.hasMatch(rollNo))) {
                                      {
                                        FirebaseAuth.instance
                                            .currentUser()
                                            .then((val) {
                                          UserUpdateInfo updateUser =
                                              UserUpdateInfo();
                                          updateUser.displayName = rollNo;
                                          val.updateProfile(updateUser);
                                          _storeUserData(context);
                                          final token = _fcm.getToken().then(
                                              (token) async =>
                                                  await saveTokenToFirestore(
                                                      token.toString()));
                                        });
                                      }
                                    } else {
                                      Scaffold.of(context)
                                          .showSnackBar(new SnackBar(
                                        content:
                                            Text("Roll Number not correct"),
                                      ));
                                    }
                                    if (username == "") {
                                      // Scaffold.of(context).showSnackBar(new SnackBar(
                                      //   content:Text("Username can't be empty"),));
                                    }
                                  },
                                  child: Text(
                                    'Confirm',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'PfDin',
                                        fontSize: 20 * textScaleFactor),
                                  ),
                                  textColor: Colors.white,
                                  elevation: 7.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  color: Color.fromRGBO(25, 39, 45, 1)),
                            ),
                          ),
                        ]),
                      );
                    } else if (!list.hasData) {
                      return CircularProgressIndicator();
                    } else if (list.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ]),
      ),
    );
  }

  _storeUserData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getKeys();
    await prefs.setString('username', username);
    await prefs.setString('roll_no', rollNo.toUpperCase());
    await prefs.setString('phone_no', phoneNo);
    await prefs.setBool('loggedin', true);
    await prefs.setBool('show_timetable', false);
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.rHomepage, (Route<dynamic> route) => false);
  }

  void _fetchUserData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    rollNo = prefs.getString('roll_no');
    if (rollNo != "" && rollNo != null && rollNo != "null") {
      isEarlierLoggedIn = true;
      rollController.text = rollNo;
    }
  }

  Future<String> inputData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    phoneNo = user.phoneNumber;
    return "return";
  }

  FirebaseMessaging _fcm = new FirebaseMessaging();

  Future<void> saveTokenToFirestore(String token) async {
    Firestore.instance
        .collection('tokens')
        .where('mobile', isEqualTo: phoneNo)
        .getDocuments()
        .then((QuerySnapshot deviceToken) async {
      if (deviceToken.documents.isEmpty) {
        await Firestore.instance
            .collection('tokens')
            .document(phoneNo)
            .setData({
          'devToken': token,
          'displayName': username,
          'roll': rollNo,
          'mobile': phoneNo,
          'optionalSub': true,
          'createdAt': FieldValue.serverTimestamp(),
        });
      } else {
        await Firestore.instance
            .collection('tokens')
            .document(phoneNo)
            .updateData({
          'devToken': token,
          'displayName': username,
        });
      }
    });
  }
}
