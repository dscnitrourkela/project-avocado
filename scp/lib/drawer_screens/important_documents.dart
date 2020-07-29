import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ImpDocs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(25, 39, 45, 1),
          title: Text(
            "Important Documents",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'PfDin',
                fontWeight: FontWeight.w600),
          )
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            docCard(context, "Academic Calendar", "https://nitrkl.ac.in/Academics/AcademicProcess/AcademicCalendar.aspx"),
            docCard(context, "Academic Forms", "https://nitrkl.ac.in/Academics/AcademicProcess/AcademicForms.aspx"),
            docCard(context, "Academic Regulations", "https://nitrkl.ac.in/Academics/AcademicProcess/AcademicRegulations.aspx"),
            docCard(context, "Branch-wise Syllabus", "https://nitrkl.ac.in/Academics/AcademicProcess/Curricula-Syllabi/aspx"),
            docCard(context, "Communication Handbook", "https://nitrkl.ac.in/docs/Misc/CommunicationHandBook.pdf"),
            docCard(context, "Curriculum", "https://nitrkl.ac.in/Academics/AcademicProcess/Curricula.aspx"),
            docCard(context, "Faculty Directory", "https://nitrkl.ac.in/FacultyStaff/EmployeeDirectory/Faculty.aspx"),
            docCard(context, "Timetable", "https://nitrkl.ac.in/Academics/AcademicProcess/AcademicTimeTable.aspx"),
            docCard(context, "Counsellor Slot Booking for Online Session", "https://bit.ly/slot_booking"),
          ],
        ),
      )
    );
  }

  Widget docCard(BuildContext context,String name,String contact){
    //var queryWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          if(contact!=""){
            _launchURL(contact);
          }
          else{}
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
                  child: Text(name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: textScaleFactor*20,
                        fontFamily: 'PfDin',
                        fontWeight: FontWeight.w800
                    ),),
                ),

                Center(
                    child: Text(contact,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      fontSize: textScaleFactor*15,
                      color: Colors.blue,
                      fontFamily: 'PfDin',
                      fontWeight: FontWeight.w500
                  ),)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


}
