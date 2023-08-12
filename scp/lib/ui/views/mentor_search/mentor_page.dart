import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scp/utils/urlLauncher.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:scp/utils/grapgQLconfig.dart';

final Color primaryColor = Color.fromARGB(255, 49, 68, 76);
final Color secondaryColor = Color.fromARGB(255, 158, 218, 224);
final Color lunchColor = Color.fromARGB(255, 238, 71, 89);

class DetailScreen extends StatelessWidget {
  final String roll;
  DetailScreen(this.roll);
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
        body: GraphQLProvider(
          client: valueclient,
          child: MentorDetails(roll),
        ));
  }
}

class MentorDetails extends StatefulWidget {
  final String rollNo;
  MentorDetails(this.rollNo);

  @override
  State<MentorDetails> createState() => _MentorDetailsState();
}

class _MentorDetailsState extends State<MentorDetails> {
  late Stream<QuerySnapshot> qSnapShot;

  @override
  void initState() {
    super.initState();
    qSnapShot = FirebaseFirestore.instance.collection('mentors').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    var queryWidth = MediaQuery.of(context).size.width;

    return StreamBuilder(
      stream: qSnapShot,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none) {
          return Center(child: const CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text("Please check your internet connection"),
          );
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text("No data found"),
          );
        }
        final query = snapshot.data as QuerySnapshot;
        if (query.docs.length == 0) {
          return Center(
            child: Text("No data found"),
          );
        }
        QueryDocumentSnapshot? data;
        try {
          query.docs.forEach((mentor) {
            List<dynamic> mentees = mentor['mentee'];
            mentees.forEach((mentee) {
              if (mentee['rollNumber'].toLowerCase() ==
                  widget.rollNo.toLowerCase()) {
                data = mentor;
              }
            });
          });
        } catch (e) {
          return Center(
            child: Text(
              "You have not been assigned a mentor yet",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
          );
        }
        if (data == null || !data!.exists) {
          return Center(
            child: Text("No data found"),
          );
        }

        var message = 'Save Contact';
        String mentorName = data!["name"].toString();
        String mentorRoll = data!["rollNumber"].toString();
        String mentorContact = data!["contact"].toString();
        String mentorEmail = data!["email"].toString();
        return Padding(
          padding: EdgeInsets.only(top: queryWidth * 0.3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
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
                    mentorRoll,
                    style: TextStyle(
                        fontFamily: 'PfDin', fontSize: queryWidth * 0.06),
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
                              fontSize: queryWidth * 0.06,
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
                              fontSize: queryWidth * 0.053,
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
                            heroTag: "btn1",
                            backgroundColor: Color.fromRGBO(74, 232, 190, 1),
                            shape: CircleBorder(),
                            child: Icon(Icons.call),
                            onPressed: () {
                              launchURL("tel:" + mentorContact);
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: FloatingActionButton(
                            heroTag: "btn2",
                            backgroundColor: Color.fromRGBO(74, 232, 190, 1),
                            shape: CircleBorder(),
                            child: Icon(Icons.mail),
                            onPressed: () async {
                              var url = "mailto:" + mentorEmail;
                              Uri uri = Uri.parse(url);
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: FloatingActionButton(
                            heroTag: "btn3",
                            backgroundColor: Color.fromRGBO(74, 232, 190, 1),
                            shape: CircleBorder(),
                            child: Icon(Icons.message),
                            onPressed: () async {
                              var url = "sms:" + mentorContact;
                              Uri uri = Uri.parse(url);
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri);
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
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(
                          54,
                          66,
                          87,
                          1.0,
                        ),
                        shape: StadiumBorder(),
                      ),
                      onPressed: () {
                        saveContact(
                            Contact(
                              name: Name(first: mentorName),
                              displayName: mentorName,
                              phones: [Phone(mentorContact)],
                              emails: [Email(mentorEmail)],
                            ),
                            context);
                      },
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  "For details about Prefect and Co-ordinator visit \"About ICS\" section ",
                  style: TextStyle(color: primaryColor),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void saveContact(Contact contact, BuildContext context) async {
    if (await FlutterContacts.requestPermission()) {
      // save contact
      // save contact with external app
      FlutterContacts.insertContact(contact).then((value) {
        FlutterContacts.openExternalEdit(value.id);
      }).catchError((error) {
        debugPrint(error);
      });
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Contact saved successfully",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "App need permission to create the contact",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      );
    }
  }
}
