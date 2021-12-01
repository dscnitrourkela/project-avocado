import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scp/utils/sizeConfig.dart';

class ImpDocs extends StatefulWidget {
  @override
  _ImpDocsState createState() => _ImpDocsState();
}

List<Widget> doc = [];

class _ImpDocsState extends State<ImpDocs> {
  final fireDocs = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    doc = [];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 39, 45, 1),
        title: Text(
          "Important Documents",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'PfDin',
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: doc,
                ));
              default:
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
            }
          },
        ),
      ),
    );
  }

  var textScaleFactor = SizeConfig.drawerItemTextSize * 0.05;

  Future fetchData() async {
    QuerySnapshot snapshot = await fireDocs
        .collection("impdocs")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((f) {
        Map<String, dynamic> d = f.data();
        doc.add(new Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              if (d['link'] != null) _launchURL(d['link']);
            },
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
                      child: Text(
                        d['title'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: textScaleFactor * 20,
                            fontFamily: 'PfDin',
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Center(
                      child: Text(
                        d['link'] == null ? "" : d['link'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: textScaleFactor * 15,
                          fontFamily: 'PfDin',
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
      });
      return snapshot;
    });
    snapshot.docs.forEach((f) => print(snapshot.docs.length));
    return snapshot;
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
