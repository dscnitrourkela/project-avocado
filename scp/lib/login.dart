import 'package:flutter/material.dart';
import 'package:scp/background.dart';

import 'package:scp/firebase/firebaseAuthHelper.dart';

final Shader linearGradient = LinearGradient(
  colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final phoneController = TextEditingController();
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color.fromRGBO(142, 40, 142, 1.0),
      Color.fromRGBO(36, 34, 97, 1.0),
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  void dispose() {
    //phoneController.dispose();
    super.dispose();
  }

  String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Background(),
          Align(
            alignment: Alignment(-0, -0.5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                            fontSize: 40.0,
                            fontFamily: "PfDin",
                            foreground: Paint()..shader = linearGradient,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "To SCP NITR app",
                        style: TextStyle(
                            fontSize: 32.0,
                            fontFamily: "PfDin",
                            foreground: Paint()..shader = linearGradient,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Material(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                child: TextField(
                  enableInteractiveSelection: true,
                  style: TextStyle(
                    fontFamily: "PfDin",
                  ),
                  autofocus: false,
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: 'Enter Phone number', border: InputBorder.none),
                  onChanged: (value) {
                    this.phoneNumber = value;
                  },
                  controller: phoneController,
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                  onPressed: () {
                    ScpAuth(context).verifyPhone(phoneController.text);
                  },
                  child: Text('Verify'),
                  textColor: Colors.white,
                  elevation: 7.0,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
              ],
    ),
    );
  }
}
