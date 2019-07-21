import 'package:flutter/material.dart';

import 'package:scp/firebase/firebaseAuthHelper.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final phoneController = TextEditingController();

  @override
  void dispose() {
    //phoneController.dispose();
    super.dispose();
  }

  String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
            padding: EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: 'Enter Phone number'),
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
              ],
            )),
      ),
    );
  }
}
