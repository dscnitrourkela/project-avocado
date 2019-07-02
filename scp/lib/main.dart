import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scp/cards.dart';
import 'package:scp/gradients.dart';


import 'package:scp/time_table.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'SCP Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'SCP Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Gradients().init(context);
    var queryWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Text(
              'SCP',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w500, fontFamily: 'PfDin',letterSpacing: 2),
            ),
          ),
          RaisedButton(
              child: Text('TimeTable'),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TimeTable()
                  ),
              ),
          ),
          appointmentCard(context, queryWidth, textScaleFactor),
          faqCard(context, queryWidth, textScaleFactor),
          mentorsCard(context, queryWidth, textScaleFactor),
        ],
      ),
    );
  }
}
