import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scp/utils/grapgQLconfig.dart';

final Color primaryColor = Color.fromARGB(255, 49, 68, 76);
final Color secondaryColor = Color.fromARGB(255, 158, 218, 224);
final Color lunchColor = Color.fromARGB(255, 238, 71, 89);

class ListDetails extends StatelessWidget {
  final String rollNo;
  ListDetails(this.rollNo);
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
                'Your Mentees',
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
        body: GraphQLProvider(
          client: valueclient,
          child: MenteeDetails(rollNo.toLowerCase()),
        ));
  }
}

class MenteeDetails extends StatefulWidget {
  final String rollNo;
  MenteeDetails(this.rollNo);
  @override
  State<MenteeDetails> createState() => _MenteeDetailsState();
}

class _MenteeDetailsState extends State<MenteeDetails> {
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
        late QueryDocumentSnapshot? data;
        try {
          data = query.docs.firstWhere((element) =>
              element['rollNumber'].toLowerCase() ==
              widget.rollNo.toLowerCase());
        } catch (e) {
          return Center(
            child: Text(
              "You are not a mentor",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
          );
        }
        if (!data.exists) {
          return Center(
            child: Text("No data found"),
          );
        }
        final List<dynamic> mentees = data['mentee'];
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data['name'],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primaryColor,
                fontSize: queryWidth * 0.1,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(widget.rollNo.toUpperCase(),
                style: TextStyle(
                    color: primaryColor,
                    fontSize: queryWidth * 0.075,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: queryWidth * 0.07,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: queryWidth * 0.05),
              child: ListTile(
                dense: true,
                title: Text(
                  "MENTEE NAME",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: queryWidth * 0.06, fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  "ROLL NO",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: queryWidth * 0.055,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: queryWidth * 0.05),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: mentees.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      dense: true,
                      title: Text(
                        mentees[index]["name"],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: queryWidth * 0.042,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        mentees[index]["rollNumber"],
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: queryWidth * 0.038,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
