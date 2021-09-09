import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scp/main.dart';
import 'package:scp/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScpAuth {
  static String phoneNumber;
  static String smsCode;
  static String verificationId;

  final BuildContext context;

  ScpAuth(this.context);
  void init(String phoneNumber) {
    phoneNumber = phoneNumber;
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    print('enter smsdialog');
    var queryWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final otpController = TextEditingController();
    print(queryWidth);
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: AlertDialog(
                title: Text(
                  'Enter OTP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "PfDin",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                content: TextField(
                  textAlign: TextAlign.center,
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                    color: Color.fromRGBO(25, 39, 45, 1),
                  ))),
                  style: TextStyle(
                      fontSize: 20 * textScaleFactor,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'PfDin'),
                  onChanged: (value) {
                    smsCode = value;
                  },
                ),
                contentPadding: EdgeInsets.all(10.0),
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(25, 39, 45, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontFamily: 'PfDin'),
                    ),
                    onPressed: () {
                      if (firebaseInstance.currentUser == null) {
                        signIn(context);
                      } else {
                        Navigator.of(context).pushNamed(Routes.rUserData);
                      }
                    },
                  ),
                ],
              ),
            ));
  }

  Future<void> verifyPhone(String phoneNumber) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {
      verificationId = verId;
    };

    final PhoneCodeSent codeSent = (String verId, [int forceCodeResend]) {
      verificationId = verId;
      smsCodeDialog(context);
    };
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential credential) {
      print('verified');
      signInSpecial(context, credential);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException error) {
      print('${error.message}');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Booooo!')));
    };

    firebaseInstance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        codeAutoRetrievalTimeout: autoRetrievalTimeout,
        codeSent: codeSent,
        timeout: const Duration(
          seconds: 5,
        ),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed);
  }

  static signIn(BuildContext context) async {
    print(verificationId);
    print(smsCode);
    final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    await firebaseInstance.signInWithCredential(credential).then((user) {
      print(user.user.displayName);
      _storeUserData(context, user);
    }).catchError((error) {
      print(error);
    });
  }

  static signInSpecial(BuildContext context, AuthCredential credential) async {
    print(verificationId);
    print(smsCode);
    await firebaseInstance.signInWithCredential(credential).then((user) {
      _storeUserData(context, user);
    }).catchError((error) {
      print(error);
    });
  }

  static _storeUserData(
      BuildContext context, UserCredential firebaseUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('roll_no', firebaseUser.user.displayName);
    Navigator.of(context).pushNamed(Routes.rUserData);
  }
}
