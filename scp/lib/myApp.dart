import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';
import 'package:scp/connectivity/connectivity_handler_widget.dart';
import 'package:scp/firebase/firebaseDBHandler.dart';
import 'login.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ScpDatabase scpDatabase;
  bool _loggedin;
  @override
  Widget build(BuildContext context) {
    // Added connectivity handler Widget to display snackbars for connection status as required
    return ConnectivityHandlerWidget(
      child: FutureBuilder(
          future: checkLogin(),
          builder: (context, response) {
            if (response.connectionState == ConnectionState.done) {
              if (_loggedin) {
                return HomePage(
                  title: "SCP",
                ); //Navigator.pushNamed(context, '/homePage');
              } else {
                return Login(); //Navigator.pushNamed(context, '/login');
              }
            } else
              return CircularProgressIndicator();
          }),
    );
  }

  Future checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getKeys();
    _loggedin = (prefs.getBool('loggedin') ?? false);
    print(_loggedin);
  }

  @override
  void initState() {
    super.initState();
    // ...
  }
}
