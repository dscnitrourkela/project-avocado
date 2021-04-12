import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:native_contact_dialog/native_contact_dialog.dart';
import 'package:scp/utils/grapgQLconfig.dart';

final Color primaryColor = Color.fromARGB(255, 49, 68, 76);
final Color secondaryColor = Color.fromARGB(255, 158, 218, 224);
final Color lunchColor = Color.fromARGB(255, 238, 71, 89);

final String readMentorDetails = """
query MentorDetails(\$roll : String){
  mentee(rollNumber : \$roll){
    mentor{
    name
    rollNumber
    contact
    email
    prefectDetails{
      name
      coordinatorDetails{
        name
      }
    }
  }
  }
}
""";

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

class MentorDetails extends StatelessWidget {
  final String roll;
  MentorDetails(this.roll);
  @override
  Widget build(BuildContext context) {
    var queryWidth = MediaQuery.of(context).size.width;
    return Query(
        options: QueryOptions(
            documentNode: gql(readMentorDetails),
            variables: <String, dynamic>{"roll": roll}),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.hasException) {
            return Center(
              child: Text("Please check your internet connection"),
            );
          }
          if (result.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (result.data["mentee"] != null) {
            var message = 'Save Contact';
            var dataRef = result.data["mentee"]["mentor"];
            var mentorName = dataRef["name"].toString();
            var mentorRoll = dataRef["rollNumber"].toString();
            var mentorContact = dataRef["contact"].toString();
            var mentorEmail = dataRef["email"].toString();
            var mentorPrefect = dataRef["prefectDetails"]["name"].toString();
            var mentorCoordinator = dataRef["prefectDetails"]
                    ["coordinatorDetails"]["name"]
                .toString();
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
                      Text(
                        "Prefect - " + mentorPrefect,
                        style: TextStyle(
                            fontFamily: 'PfDin', fontSize: queryWidth * 0.06),
                      ),
                      Text(
                        "Co-ordinator - " + mentorCoordinator,
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
                                backgroundColor:
                                    Color.fromRGBO(74, 232, 190, 1),
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
                                heroTag: "btn2",
                                backgroundColor:
                                    Color.fromRGBO(74, 232, 190, 1),
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
                                heroTag: "btn3",
                                backgroundColor:
                                    Color.fromRGBO(74, 232, 190, 1),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Text(
                      "For details about Prefect and Co-ordinator visit \"About ICS\" section ",
                      style: TextStyle(color: primaryColor),
                    ),
                  )
                ],
              ),
            );
          }

          if (result.data["mentee"] == null) {
            return Center(
              child: Text(
                "Re-Login with the correct Roll Number",
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
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
