import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scp/utils/sizeConfig.dart';

class Nots extends StatefulWidget{
  @override
  _Nots createState() => _Nots();
}
List<Widget> v = [];
class _Nots extends State<Nots> {
  final databaseReference = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(25, 39, 45, 1),
            title: Text(
              "Notifications",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'PfDin',
                  fontWeight: FontWeight.w600),
            )
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: getData(),
            builder: (context,snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.done:
                  return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: v
                      )
                  );
                default:
                  return CircularProgressIndicator();

              }
            }
          )
        )
    );
  }
  var textScaleFactor = SizeConfig.drawerItemTextSize*0.05;

  Future getData() async {
    QuerySnapshot snapshot=await databaseReference
        .collection("nots")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => v.add(new Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Card(
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(f.data['title'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: textScaleFactor*20,
                          fontFamily: 'PfDin',
                          fontWeight: FontWeight.w800
                      ),),
                  ),

                  Center(
                      child: Text(f.data['description'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: textScaleFactor*15,
                            fontFamily: 'PfDin',
                            fontWeight: FontWeight.w500
                        ),)),
                ],
              ),
            ),
          ),
        ),
      )));
      return snapshot;
    });
    snapshot.documents.forEach((f) => print(snapshot.documents.length));
    return snapshot;
  }
}
