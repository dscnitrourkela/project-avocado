import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              title: Text('Enter SMS Code'),
              content: TextField(
                onChanged: (value) {
                  smsCode = value;
                },
              ),
              contentPadding: EdgeInsets.all(10.0),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'DONE',
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    FirebaseAuth.instance.currentUser().then((user) {
                      if (user != null) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacementNamed('/homePage');
                      } else {
                        Navigator.of(context).pop();
                        signIn(context);
                      }
                    });
                  },
                ),
              ],
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
    };

    final PhoneVerificationFailed verificationFailed = (AuthException error) {
      print('${error.message}');
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Booooo!')));
    };

    FirebaseAuth.instance.verifyPhoneNumber(
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
    final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);
    final FirebaseUser user = await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((user) {
          Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/homePage');
    }).catchError((error) {
      print(error);
    });
  }
}
