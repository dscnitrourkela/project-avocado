import 'package:flutter/material.dart';
import 'package:scp/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mentor_page.dart';
import 'mentee_page.dart';

final Color primaryColor = Color.fromARGB(255, 49, 68, 76);
final Color secondaryColor = Color.fromARGB(255, 158, 218, 224);
final Color lunchColor = Color.fromARGB(255, 238, 71, 89);
String roll;

class Mentors extends StatefulWidget {
  @override
  _MentorsState createState() => _MentorsState();
}

class _MentorsState extends State<Mentors> {
  final TextEditingController rollNoController = TextEditingController();
  double queryWidth;
  double textScaleFactor;

  Future fetchRoll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getKeys();
    setState(() {
      roll = prefs.getString('roll_no');
    });
  }

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
                'Find Your Mentor/Mentees',
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
        body: FutureBuilder(
          future: fetchRoll(),
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Enter your Roll no.",
                      style: TextStyle(
                        fontFamily: 'PfDin',
                        fontSize: queryWidth * 0.06,
                      )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: TextFormField(
                    initialValue: roll,
                    onChanged: (value) {
                      setState(() {
                        roll = value;
                      });
                    },
                    textAlign: TextAlign.center,
                  ),
                ),
                //buildDetails(),
                Padding(
                  padding: EdgeInsets.all(40),
                  child: Ink(
                    decoration: ShapeDecoration(
                      color: secondaryColor,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.check,
                        color: primaryColor,
                      ),
                      iconSize: 40,
                      onPressed: () {
                        print(roll);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(roll.toString())));
                        /*  if (roll[2] == "0") {
                    print(roll[2]);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen(roll.toString())));
                  } else {
                    print(roll[2]);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ListDetails(roll.toString())));
                  } */
                      },
                    ),
                  ),
                )
              ],
            );
          },
        ));
  }
}
