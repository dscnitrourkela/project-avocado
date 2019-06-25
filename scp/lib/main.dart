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
  cardBuilder(heightFactor,textScaleFactor) => SizedBox(
        height: heightFactor * 0.58,
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0)),
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
            child: Stack(
              fit: StackFit.passthrough,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(24.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Container(
                      height: heightFactor * 0.3,
                      child: Center(
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0),
                          title: ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Colors.black, Colors.transparent],
                              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                            },
                              blendMode: BlendMode.dstIn,
                            child: Container(
                              height: heightFactor * 0.15,
                              color: Colors.white,
                              padding: EdgeInsets.only(left: 20.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'APPOINTMENT',
                                  style: TextStyle(fontSize: 23.0*textScaleFactor,color: Colors.blueAccent,fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(child: Image.asset('assets/scp_app.png',alignment: Alignment.centerRight,),
                ),],
            ),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
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
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
          ),
          cardBuilder(queryWidth,textScaleFactor),
          cardBuilder(queryWidth,textScaleFactor),
          cardBuilder(queryWidth,textScaleFactor),
          cardBuilder(queryWidth,textScaleFactor),
        ],
      ),
    );
  }
}
