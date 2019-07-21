import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:scp/main.dart';

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
              content: PinCodeTextField(
                maxLength:6,
                autofocus: true,
                isCupertino: true,
                pinBoxHeight: 40.0,
                pinBoxWidth: 40.0,
                defaultBorderColor: Colors.lightBlue,
                hasTextBorderColor: Colors.blueAccent,
                onDone:(String otp){
                  smsCode=otp;
                }

              ),
              contentPadding: EdgeInsets.all(10.0),
              actions: <Widget>[
                RaisedButton(
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color:Colors.white,
                      fontFamily:'PfDin'
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(30.0)
                ),
                color: Colors.blue,
                  onPressed: () {
                    firebaseInstance.currentUser().then((user) {
                      if (user == null) {
                        signIn(context);

                      } else {Navigator.of(context).pushNamed('/userdata');
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
    final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);
    final FirebaseUser user = await firebaseInstance
        .signInWithCredential(credential)
        .then((user) {
      
      Navigator.of(context).pushNamed('/userdata');
    }).catchError((error) {
      print(error);
    });
  }
}
