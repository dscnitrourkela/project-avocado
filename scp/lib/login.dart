import 'package:flutter/material.dart';
import 'package:scp/background.dart';
import 'package:scp/background_gradient.dart';

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
  final countryCodeController = TextEditingController();
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

  String countryCode="91";
  String phoneNumber;

  @override
  Widget build(BuildContext context) {
    var queryWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    countryCodeController.text=countryCode;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          //BackgroundGrad(),
          Align(
            alignment: Alignment(-0, -0.7),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset('assets/nit.png',
                      height: queryWidth*0.2,
                      width:queryWidth*0.2,
                      color: Colors.black,),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "SCP NIT ROURKELA",
                        style: TextStyle(
                            fontSize: 32.0,
                            fontFamily: "PfDin",
                            color: Color.fromRGBO(25, 39, 45, 1),
                            fontWeight: FontWeight.w900),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0,-0.15),
            child: Text(
              "SIGN IN",
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "PfDin",
                  color: Color.fromRGBO(74, 232, 190, 1),
                  fontWeight: FontWeight.w600),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("+",
                            style: TextStyle(
                                fontSize: 30*textScaleFactor,
                                color: Color.fromRGBO(25, 39, 45, 1),
                                fontFamily: 'PfDin',
                              fontWeight: FontWeight.w600
                            ),),
                        ),
                        Flexible(
                          child: Container(
                            width: queryWidth*0.1,
                            child: TextField(
                              maxLength: 2,
                              enableInteractiveSelection: true,
                              style: TextStyle(
                                  fontSize: 30*textScaleFactor,
                                  color: Color.fromRGBO(25, 39, 45, 1),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'PfDin'
                              ),
                              keyboardType: TextInputType.phone,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(border: InputBorder.none, counterText: '',hintStyle:TextStyle(
                                  fontSize: 30*textScaleFactor,
                                  color: Color.fromRGBO(25, 39, 45, 1),
                                  fontFamily: 'PfDin'
                              ), ),
                              onChanged: (value) {
                                this.countryCode = value;
                              },
                              controller: countryCodeController,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Container(
                      width: queryWidth*0.4,
                      child: TextField(
                        maxLength: 10,
                        enableInteractiveSelection: true,
                        style:TextStyle(
                            fontSize: 30*textScaleFactor,
                            color: Color.fromRGBO(25, 39, 45, 1),
                            fontFamily: 'PfDin',
                            fontWeight: FontWeight.w600
                        ),
                        autofocus: true,
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                            hintText: 'Phone no', border: InputBorder.none,counterText: '',hintStyle: TextStyle(
                          fontWeight:FontWeight.w200,
                        )),
                        onChanged: (value) {
                          this.phoneNumber = value;
                        },
                        controller: phoneController,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.25),
            child: ButtonTheme(
              minWidth: 200,
              height: 40,
              child: RaisedButton(

                  onPressed: () {
                    String finalPhoneNo="+" + countryCodeController.text+ " "+phoneController.text;
                    ScpAuth(context).verifyPhone(finalPhoneNo);
                  },
                  child: Text('SEND OTP',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily:'PfDin',
                    fontSize: 20*textScaleFactor
                  ),),
                  textColor: Colors.white,

                  elevation: 7.0,
                  shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(8.0)
                  ),
                  color: Color.fromRGBO(25, 39, 45, 1)),
            ),
          ),
        ],
      ),
    );
  }
}