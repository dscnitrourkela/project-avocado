import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final String ABOUT_TEXT="Student Counselling Services, NIT Rourkela is a noble initiative by the current Director, Prof. Animesh Biswas. This service deals with various important aspects of a student’s life. It addresses Academic, Financial, Mental and Socio-cultural issues, ensuring a seamless transition from home to hostel life for the freshmen and making life at NITR more enjoyable. \n\n"
    "The objective of SCS is to prepare the students for a confident approach towards life and to bring about a voluntary change in themselves. The goal of counselling is to help individuals overcome their immediate problems and also to equip them to meet future problems. The goals of counselling are appropriately concerned with fundamental and basic aspects such as self-understanding and self-actualization.\n\n"
"The service has 8 faculty members, including the Professor in Charge, Prof. K. C. Pati and 11 Student Coordinators. Each coordinator has been assigned a set number of mentors who in turn take care of mentees from the freshman year. Experienced mentors interact with the newbies to bridge the Junior-Senior gap and also personal and professional support. Student Counselling Services also has at their services a Counsellor and a Psychiatrist, who professionally deal with various student issues. ";
class AboutSCP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 39, 45, 1),
        title: Text("About SCS",
        style: TextStyle(
          fontFamily: 'PfDin'
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:30,bottom: 10),
              child: Center(
                child: Text("ABOUT",
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
              padding: const EdgeInsets.only(left: 25,right: 25, top: 20,bottom: 30),
              child: Text(ABOUT_TEXT,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'PfDin',
                  color: Color.fromRGBO(25, 39, 45, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10,bottom: 20),
              child: Center(
                child: Text("FACULTY MEMBERS",
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                contactCard(context, "Prof. Animesh Biswas", "Director", ""),
                contactCard(context, "Prof. K.C. Pati", "Professor-In-Charge", ""),
                contactCard(context, "Prof. Alok Satpathy", "Faculty Coordinator", ""),
                contactCard(context, "Prof. A.K Rath", "Faculty Coordinator", ""),
                contactCard(context, "Prof. Suvendu Ranjan Pattnaik", "Faculty Coordinator", ""),
                contactCard(context, "Prof. Dipti Patra", "Faculty Coordinator", ""),
                contactCard(context, "Prof. Usha Rani Subudhi", "Faculty Coordinator", ""),
                contactCard(context, "Prof. K.R. Subhashini", "Faculty Coordinator", ""),
                contactCard(context, "Prof. Snehanshu Pal", "Faculty Coordinator", ""),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top:30,bottom: 15),
              child: Center(
                child: Text("COORDINATORS",
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
            Column(
              children: <Widget>[
                contactCard(context, "Amlan Das", "Senior Coordinator", "+91 9438226363"),
                contactCard(context, "Aalisha Padhy", "Student Coordinator", "+91 7894522431"),
                contactCard(context, "Amrit Jena", "Student Coordinator", "+91 9658636724"),
                contactCard(context, "Dakarapu Rishi", "Student Coordinator", "+91 9938776163"),
                contactCard(context, "Mirza Khalid Baig", "Student Coordinator", "+91 7894083120"),
                contactCard(context, "Nikhil Gupta", "Student Coordinator", "+91 7873744718"),
                contactCard(context, "Kuldeep Namdeo", "Student Coordinator", "+91 9009204239"),
                contactCard(context, "Payal Das", "Student Coordinator", "+91 8895561515"),
                contactCard(context, "Siddharth Swarup", "Student Coordinator", "+91 7008947727"),
                contactCard(context, "Shweta Kedas", "Student Coordinator", "+91 8500290908"),
                contactCard(context, "Sravya Sridhar", "Student Coordinator", "+91 7008118925"),
                contactCard(context, "Zakiya Ali", "Student Coordinator", "+91 9337002705"),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget contactCard(BuildContext context,String name,String position,String contact){
    var queryWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return InkWell(
      onTap: (){
        if(contact!=""){
          launch("tel://"+contact);
        }
        else{}
      },
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
            Text(position,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: textScaleFactor*15,
                fontFamily: 'PfDin',
                fontWeight: FontWeight.w500
            ),),
            Text(contact,
              style: TextStyle(
                  fontSize: textScaleFactor*15,
                  fontFamily: 'PfDin',
                  fontWeight: FontWeight.w500
              ),)
          ],
        ),
      ),
    );
  }
}
