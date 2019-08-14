import 'package:flutter/material.dart';
import 'package:scp/mentor_search/appbase_search_manager.dart';

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
              'Find Your Mentor/Mentee',
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
                Navigator.pushNamed(context, '/homePage');
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
        children: <Widget>[
          Text("Enter Roll no."),
          TextField(
            controller: rollNoController,
            textAlign: TextAlign.center,
          ),
          buildDetails(),
          IconButton(
            icon: Icon(Icons.check),
            iconSize: 40,
            onPressed: () {
              AppBaseSearchHandler.searchRollNo(rollNoController.text);
              buildDetails();
            },
          ),
        ],
      ),
    );
  }

  Widget buildDetails() {
    return Container(
      child: FutureBuilder(
        future: AppBaseSearchHandler.searchRollNo(rollNoController.text),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
          if (snapshot.hasData) {
            return Text(snapshot.data.hits.hits[0].source.mentorName);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }}
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
