import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scp/utils/sizeConfig.dart';
import 'package:url_launcher/url_launcher.dart';

final String aboutText =
    "Institute Counselling Services, NIT Rourkela is a noble initiative by the former Director, Prof. Animesh Biswas. This service deals with various important aspects of a student’s life. It addresses Academic, Financial, Mental and Socio-cultural issues, ensuring a seamless transition from home to hostel life for the freshmen and making life at NITR more enjoyable. \n\n"
    "The objective of ICS is to prepare the students for a confident approach towards life and to bring about a voluntary change in themselves. The goal of counselling is to help individuals overcome their immediate problems and also to equip them to meet future problems. The goals of counselling are appropriately concerned with fundamental and basic aspects such as self-understanding and self-actualization.\n\n"
    "The service has 7 faculty members, including the Head of Unit, Prof. Pawan Kumar and 12 Student Coordinators and 11 Prefects. The Coordinators monitor the overall functioning, manage the events, programs and initiatives of ICS. Each Prefect has been assigned a set number of mentors who in turn take care of the mentees from the freshman year. Experienced mentors interact with the freshers to bridge the Junior-Senior gap and also provide personal and professional support. Professional support is provided to all the students and faculty of the institute through online counselling platform YourDOST. Institute Counselling Services also has at their premises at campus a Counsellor and a Psychiatrist, who professionally deal with various students and faculty isssues. ";

class AboutSCP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 39, 45, 1),
        title: Text(
          "About ICS",
          style: TextStyle(
            fontFamily: 'PfDin',
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: Center(
                child: Text(
                  "ABOUT",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PfDin',
                    color: Color.fromRGBO(74, 232, 190, 1),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, top: 20, bottom: 30),
              child: Text(
                aboutText,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'PfDin',
                  color: Color.fromRGBO(25, 39, 45, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Center(
                child: Text(
                  "FACULTY MEMBERS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: SizeConfig.screenWidth * 0.05,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PfDin',
                    color: Color.fromRGBO(74, 232, 190, 1),
                  ),
                ),
              ),
            ),
            StreamBuilder(
              stream: getAbout('faculty'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(
                    child: Text("No data found"),
                  );
                }
                final List<dynamic> faculty = (snapshot.data as List)[0];
                if (faculty.length == 0) {
                  return Center(
                    child: Text("No data found"),
                  );
                }
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: faculty.length,
                  itemBuilder: (BuildContext context, int index) {
                    String contact = (faculty[index] as Map<String, dynamic>)
                            .containsKey('contact')
                        ? faculty[index]['contact']
                        : "";
                    String designation =
                        (faculty[index] as Map<String, dynamic>)
                                .containsKey('designation')
                            ? faculty[index]['designation']
                            : "";
                    return contactCard(
                      context,
                      faculty[index]['name'],
                      designation,
                      contact,
                    );
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 15),
              child: Center(
                child: Text(
                  "ADVISOR",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PfDin',
                    color: Color.fromRGBO(74, 232, 190, 1),
                  ),
                ),
              ),
            ),
            StreamBuilder(
              stream: getAbout('advisor'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(
                    child: Text("No data found"),
                  );
                }
                final List<dynamic> advisor = (snapshot.data as List)[0];
                if (advisor.length == 0) {
                  return Center(
                    child: Text("No data found"),
                  );
                }
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: advisor.length,
                  itemBuilder: (BuildContext context, int index) {
                    return contactCard(
                      context,
                      advisor[index]['name'],
                      advisor[index]['email'],
                      advisor[index]['contact'],
                    );
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 15),
              child: Center(
                child: Text(
                  "COORDINATORS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PfDin',
                    color: Color.fromRGBO(74, 232, 190, 1),
                  ),
                ),
              ),
            ),
            StreamBuilder(
              stream: getAbout('coord'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(
                    child: Text("No data found"),
                  );
                }
                final List<dynamic> coord = (snapshot.data as List)[0];
                if (coord.length == 0) {
                  return Center(
                    child: Text("No data found"),
                  );
                }
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: coord.length,
                  itemBuilder: (BuildContext context, int index) {
                    String contact = (coord[index] as Map<String, dynamic>)
                            .containsKey('contact')
                        ? coord[index]['contact']
                        : "";
                    return contactCard(
                      context,
                      coord[index]['name'],
                      coord[index]['email'],
                      contact,
                    );
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 15),
              child: Center(
                child: Text(
                  "PREFECTS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PfDin',
                    color: Color.fromRGBO(74, 232, 190, 1),
                  ),
                ),
              ),
            ),
            StreamBuilder(
              stream: getAbout('prefect'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(
                    child: Text("No data found"),
                  );
                }
                final List<dynamic> prefect = (snapshot.data as List)[0];
                if (prefect.length == 0) {
                  return Center(
                    child: Text("No data found"),
                  );
                }
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: prefect.length,
                  itemBuilder: (BuildContext context, int index) {
                    String contact = (prefect[index] as Map<String, dynamic>)
                            .containsKey('contact')
                        ? prefect[index]['contact']
                        : "";
                    return contactCard(
                      context,
                      prefect[index]['name'],
                      prefect[index]['email'],
                      contact,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget contactCard(
      BuildContext context, String name, String position, String contact) {
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return InkWell(
      onTap: () {
        if (contact != "") {
          launchUrl(Uri.parse("tel://" + contact));
        } else {}
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: textScaleFactor * 20,
                    fontFamily: 'PfDin',
                    fontWeight: FontWeight.w800),
              ),
            ),
            Text(
              position,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: textScaleFactor * 15,
                  fontFamily: 'PfDin',
                  fontWeight: FontWeight.w500),
            ),
            Text(
              contact,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: textScaleFactor * 15,
                  fontFamily: 'PfDin',
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Stream<List> getAbout(String s) {
    return (FirebaseFirestore.instance.collection('about').snapshots().map(
          (event) => event.docs
              .map(
                (e) => e.data()[s],
              )
              .toList(),
        ));
  }
}
