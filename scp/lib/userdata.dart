import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userdata extends StatelessWidget {
  var rollController = TextEditingController();
  var usernameController = TextEditingController();
  String rollNo, username = "", phoneNo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchUserData(context),
      builder: (context, snapshot) {
      if(snapshot.data==null) {
        return Scaffold(
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
                        String phoneNumber = phoneNo;
                        if (list.hasData) {
                          return Center(
                            child: Column(children: <Widget>[
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
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
                                    phoneNumber,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'PfDin',
                                      color: Color.fromRGBO(25, 39, 45, 1),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: rollNo == "" ||
                                            rollNo == null ||
                                            rollNo == "null"
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 40.0,
                                                right: 40.0,
                                                bottom: 20.0,
                                                top: 30.0),
                                            child: Material(
                                              elevation: 10.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30.0)),
                                              ),
                                              child: TextField(
                                                enableInteractiveSelection:
                                                    false,
                                                style: TextStyle(
                                                  fontFamily: "PfDin",
                                                ),
                                                autofocus: false,
                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        'Enter Roll Number',
                                                    border: InputBorder.none),
                                                onChanged: (value) {
                                                  this.rollNo = value;
                                                },
                                                controller: rollController,
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  "Roll Number",
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'PfDin',
                                                    color: Color.fromRGBO(
                                                        74, 232, 190, 1),
                                                  ),
                                                ),
                                                Text(
                                                  rollNo,
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'PfDin',
                                                    color: Color.fromRGBO(
                                                        25, 39, 45, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40.0, right: 40.0),
                                    child: Material(
                                      elevation: 10.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                      ),
                                      child: TextField(
                                        style: TextStyle(
                                          fontFamily: "PfDin",
                                        ),
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                            hintText: 'Enter name',
                                            border: InputBorder.none),
                                        onChanged: (value) {
                                          this.username = value;
                                        },
                                        controller: usernameController,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: RaisedButton(
                                  onPressed: () {
                                    if (rollNo != "" ||
                                        rollNo != null ||
                                        rollNo != "null") {
                                      FirebaseAuth.instance
                                          .currentUser()
                                          .then((val) {
                                        UserUpdateInfo updateUser =
                                            UserUpdateInfo();
                                        updateUser.displayName = rollNo;
                                        val.updateProfile(updateUser);
                                      });
                                    } else {
                                      // Scaffold.of(context).showSnackBar(new SnackBar(
                                      //   content:Text("Roll Number can't be empty"),

                                      // ));
                                    }
                                    if (username == "") {
                                      // Scaffold.of(context).showSnackBar(new SnackBar(
                                      //   content:Text("Username can't be empty"),));
                                    }
                                    if (rollNo != "" ||
                                        rollNo != null ||
                                        rollNo != "null" && username != "") {
                                      _storeUserData(context);
                                      Navigator.of(context).pushReplacementNamed("/homePage");
                                    }
                                  },
                                  child: Text(
                                    'Verify',
                                    style: TextStyle(
                                      fontFamily: 'PfDin',
                                    ),
                                  ),
                                  textColor: Colors.white,
                                  elevation: 7.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  color: Color.fromRGBO(74, 232, 190, 1),
                                ),
                              ),
                            ]),
                          );
                        } else if (!list.hasData) {
                          return CircularProgressIndicator();
                        } else if (list.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        else{
                          return CircularProgressIndicator();
                        }
                      }),
                ]),
          ),
        );
      }
      else{
        return HomePage();
      }
    });
  }

  _storeUserData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('roll_no', rollNo);
    await prefs.setString('phone_no', phoneNo);
  }

  Future<String> _fetchUserData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Future<String> inputData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    rollNo = user.displayName;
    print(rollNo+"Printed in userdata");
    print(phoneNo);
    print(username);
    phoneNo = user.phoneNumber;
    return "return";
  }
}