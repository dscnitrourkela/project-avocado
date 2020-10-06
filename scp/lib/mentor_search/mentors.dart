import 'package:flutter/material.dart';
import 'package:scp/mentor_search/appbase_search_manager.dart';
import 'package:scp/utils/routes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:native_contact_dialog/native_contact_dialog.dart';
import 'dart:io';

class Mentors extends StatefulWidget {
  @override
  _MentorsState createState() => _MentorsState();
}

class _MentorsState extends State<Mentors> {
  final TextEditingController rollNoController = TextEditingController();
  double queryWidth;
  double textScaleFactor;

  @override
  Widget build(BuildContext context) {
    queryWidth = MediaQuery.of(context).size.width;
    textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          60.0,
        ),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
            ),
            child: Text(
              'Find Your Mentor',
              style: TextStyle(
                  fontSize: queryWidth * 0.065,
                  fontFamily: 'PfDin',
                  fontWeight: FontWeight.w500),
            ),
          ),
          backgroundColor: Color.fromRGBO(
            54,
            66,
            87,
            1.0,
          ),
          leading: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context);
                Navigator.pushNamed(context, Routes.rHomepage);
              },
              icon: Icon(
                Icons.arrow_back_ios,
              ),
            ),
          ),
          elevation: 0.0,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Enter Mentee Roll no.",
                style: TextStyle(
                  fontFamily: 'PfDin',
                  fontSize: queryWidth * 0.06,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "e.g - 118AR0001",
                  hintStyle: TextStyle(
                    fontFamily: 'PfDin',
                    fontSize: queryWidth * 0.06,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                  )),
              controller: rollNoController,
              textAlign: TextAlign.center,
            ),
          ),
          //buildDetails(),
          Padding(
            padding: EdgeInsets.all(40),
            child: Ink(
              decoration: ShapeDecoration(
                color: Colors.lightBlueAccent,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: Icon(Icons.check),
                iconSize: 40,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailScreen(rollNoController.text)));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  final String text;
  DetailScreen(this.text);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final Color primaryColor = Color.fromARGB(255, 49, 68, 76);
  final Color secondaryColor = Color.fromARGB(255, 158, 218, 224);
  final Color lunchColor = Color.fromARGB(255, 238, 71, 89);
  @override
  Widget build(BuildContext context) {
    var queryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            60.0,
          ),
          child: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
              ),
              child: Text(
                'Your Mentor',
                style: TextStyle(
                    fontSize: queryWidth * 0.065,
                    fontFamily: 'PfDin',
                    fontWeight: FontWeight.w500),
              ),
            ),
            backgroundColor: Color.fromRGBO(
              54,
              66,
              87,
              1.0,
            ),
            leading: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context);
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            ),
            elevation: 0.0,
          ),
        ),
        backgroundColor: Colors.white,
        body: Center(child: buildDetails()));
  }

  Widget buildDetails() {
    var queryWidth = MediaQuery.of(context).size.width;
    var mentorName, mentorContact, mentorEmail;
    mentorName = 'NA';
    mentorContact = 'NA';
    mentorEmail = 'NA';
    String message = 'Incorrect Input';
    return Container(
      child: FutureBuilder(
        future: AppBaseSearchHandler.searchRollNo(widget.text),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if ((snapshot.hasData) && ((snapshot.data.hits.hits.length > 0))) {
              //print('abelmps'+snapshot.data.hits.hits[0].source.mentorName);
              mentorName = snapshot.data.hits.hits[0].source.mentorName;
              mentorContact = snapshot.data.hits.hits[0].source.mentorContact;
              mentorEmail = snapshot.data.hits.hits[0].source.mentorEmail;
              message = 'Save Contact';
              return Padding(
                padding: EdgeInsets.only(top: queryWidth * 0.3),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: queryWidth * 0.047,
                    ),
                    Text(
                      mentorName,
                      style: TextStyle(
                          fontFamily: 'PfDin', fontSize: queryWidth * 0.1),
                    ),
                    SizedBox(
                      height: queryWidth * 0.03,
                    ),
                    Text(
                      "e.g.- 118AR001",
                      style: TextStyle(
                          fontFamily: 'PfDin', fontSize: queryWidth * 0.06),
                    ),
                    //Text('Mentor Roll No.: ${snapshot.data.hits.hits[0].source.rollNo}'),
                    SizedBox(
                      height: queryWidth * 0.047,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: queryWidth * 0.07),
                      child: Card(
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25.0),
                        child: ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                              width: 1.0,
                              color: secondaryColor,
                            ))),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Icon(
                                Icons.phone,
                                color: Color.fromRGBO(74, 232, 190, 1),
                              ),
                            ),
                          ),
                          title: Center(
                            child: Text(
                              mentorContact,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'PfDin',
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: queryWidth * 0.027,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: queryWidth * 0.07),
                      child: Card(
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25.0),
                        child: ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                              width: 1.0,
                              color: secondaryColor,
                            ))),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Icon(
                                Icons.email,
                                color: Color.fromRGBO(74, 232, 190, 1),
                              ),
                            ),
                          ),
                          title: Center(
                            child: Text(
                              mentorEmail,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'PfDin',
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: queryWidth * 0.027,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: FloatingActionButton(
                              backgroundColor: Color.fromRGBO(74, 232, 190, 1),
                              shape: CircleBorder(),
                              child: Icon(Icons.call),
                              onPressed: () async {
                                var url = "tel:" + mentorContact;
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: FloatingActionButton(
                              backgroundColor: Color.fromRGBO(74, 232, 190, 1),
                              shape: CircleBorder(),
                              child: Icon(Icons.mail),
                              onPressed: () async {
                                var url = "mailto:" + mentorEmail;
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: FloatingActionButton(
                              backgroundColor: Color.fromRGBO(74, 232, 190, 1),
                              shape: CircleBorder(),
                              child: Icon(Icons.message),
                              onPressed: () async {
                                var url = "sms:" + mentorContact;
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: queryWidth * 0.1,
                      child: RaisedButton(
                        color: Color.fromRGBO(
                          54,
                          66,
                          87,
                          1.0,
                        ),
                        shape: StadiumBorder(),
                        onPressed: () {
                          saveContact(Contact(
                              givenName: mentorName,
                              phones: [Item(value: mentorContact)],
                              emails: [Item(value: mentorEmail)]));
                        },
                        child: Text(
                          message,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              if (snapshot.hasError) {
                message = 'Check Connectivity';
              }
              return Padding(
                padding: EdgeInsets.only(top: queryWidth * 0.3),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: queryWidth * 0.047,
                    ),
                    Text(
                      mentorName,
                      style: TextStyle(
                          fontFamily: 'PfDin', fontSize: queryWidth * 0.08),
                    ),
                    //Text('Mentor Roll No.: ${snapshot.data.hits.hits[0].source.rollNo}'),
                    SizedBox(
                      height: queryWidth * 0.047,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: queryWidth * 0.07),
                      child: SizedBox(
                        height: queryWidth * 0.1,
                        child: RaisedButton(
                          color: secondaryColor,
                          shape: StadiumBorder(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.call,
                                color: primaryColor,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(mentorContact,
                                    style: TextStyle(
                                        fontFamily: 'PfDin',
                                        color: primaryColor,
                                        fontSize: queryWidth * 0.06)),
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      height: queryWidth * 0.047,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: queryWidth * 0.07),
                      child: SizedBox(
                        height: queryWidth * 0.1,
                        child: RaisedButton(
                          shape: StadiumBorder(),
                          color: secondaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.email,
                                color: primaryColor,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(mentorEmail,
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontFamily: 'PfDin',
                                        fontSize: queryWidth * 0.04)),
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      height: queryWidth * 0.07,
                    ),
                    SizedBox(
                      height: queryWidth * 0.1,
                      child: RaisedButton(
                        color: primaryColor,
                        shape: StadiumBorder(),
                        child: Text(
                          message,
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context);
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              );
            }
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  void saveContact(Contact newContact) async {
    NativeContactDialog.addContact(newContact).then((result) {
      // NOTE: The user could cancel the dialog, but not add
      // them to their addressbook. Whether or not the user decides
      // to add [contactToAdd] to their addressbook, you will end up
      // here.

      print('add contact dialog closed.');
    }).catchError((error) {
      // FlutterError, most likely unsupported operating system.
      print('Error adding contact!');
    });
  }
}
