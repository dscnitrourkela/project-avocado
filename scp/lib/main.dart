import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  cardBuilder(heightFactor) => SizedBox(
        height: heightFactor * 0.5,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.blue),
              child: Container(
                height: heightFactor * 0.3,
                child: Center(
                  child: ListTile(

                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    title: Container(
                      height: heightFactor*0.1,
                      color: Colors.white,
                      child: Center(child: Text('APPOINTMENTS',textAlign: TextAlign.left,)),
                    ),
                    trailing: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      child: Icon(Icons.apps, color: Colors.white,size: 50.0,),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    var queryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Text(
              'SCP',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold),
            ),
          ),
          cardBuilder(queryWidth),
        ],
      ),
    );
  }
}
