import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:scp/booking.dart';
import 'package:scp/gradients.dart';
import 'package:scp/firebase/firebaseDBHandler.dart';

import 'models.dart';

Widget appointmentCard(
    BuildContext context, double heightFactor, double textScaleFactor) {
  Gradients().init(context);
  return SizedBox(
    height: heightFactor * 0.58,
    child: Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/appointments');
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: Gradients.appointmentCardGradient,
                  ),
                  child: Container(
                    height: heightFactor * 0.58,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 14.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 65.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0, color: Colors.white),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                  ),
                                  child: Text(
                                    'BOOK',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontFamily: 'PfDin',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 5.0),
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'YOUR',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontFamily: 'PfDin',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(bottom: 0.0),
                          title: ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Colors.black, Colors.transparent],
                              ).createShader(
                                  Rect.fromLTRB(0, 0, rect.width, rect.height));
                            },
                            blendMode: BlendMode.dstIn,
                            child: Container(
                              height: heightFactor * 0.15,
                              color: Colors.white,
                              padding: EdgeInsets.only(left: 18.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'APPOINTMENT',
                                  style: TextStyle(
                                      fontFamily: 'PfDin',
                                      fontSize: heightFactor * 0.07,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.left,
                                  textScaleFactor: textScaleFactor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 14.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Feel like talking to someone?',
                            style: TextStyle(
                                fontSize: heightFactor * 0.037,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'PfDin'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 18.0,
                bottom: 0.0,
                right: 0.0,
                child: Image.asset(
                  'assets/scp_app.png',
                  width: heightFactor * 0.45,
                  height: heightFactor * 0.45,
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomRight,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget mentorsCard(
    BuildContext context, double heightFactor, double textScaleFactor) {
  Gradients().init(context);
  return SizedBox(
    height: heightFactor * 0.58,
    child: Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: InkWell(
        onTap: () {
          FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(context, '/loginPage');
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: Gradients.mentorsCardGradient,
                  ),
                  child: Container(
                    height: heightFactor * 0.58,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0),
                            title: ShaderMask(
                              shaderCallback: (rect) {
                                return LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.black, Colors.transparent],
                                ).createShader(Rect.fromLTRB(
                                    0, 0, rect.width, rect.height));
                              },
                              blendMode: BlendMode.dstIn,
                              child: Container(
                                height: heightFactor * 0.15,
                                color: Colors.white,
                                padding: EdgeInsets.only(left: 18.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'MENTORS',
                                    style: TextStyle(
                                        fontFamily: 'PfDin',
                                        fontSize: heightFactor * 0.07,
                                        color:
                                            Color.fromRGBO(142, 40, 142, 1.0),
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: 200.0,
                              child: Text(
                                'Find the complete database of SCP Mentors',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: heightFactor * 0.038,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'PfDin',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 16.0,
                bottom: -10.0,
                right: 0.0,
                child: Image.asset(
                  'assets/scp_mentors.png',
                  width: heightFactor * 0.45,
                  height: heightFactor * 0.45,
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomRight,
                  colorBlendMode: BlendMode.color,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget faqCard(
    BuildContext context, double heightFactor, double textScaleFactor) {
  Gradients().init(context);
  return SizedBox(
    height: heightFactor * 0.58,
    child: Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: InkWell(
        onTap: () {},
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: Gradients.faqCardGradient,
                  ),
                  child: Container(
                    height: heightFactor * 0.58,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 28.0,
                            top: 32.0,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'FAQs',
                              style: TextStyle(
                                fontSize: heightFactor * 0.15,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'PfDin',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: 200.0,
                              child: Text(
                                'Find the answers to our most frequently asked questions',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: heightFactor * 0.038,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'PfDin',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),),
              Positioned(
                top: 16.0,
                bottom: -10.0,
                right: 0.0,
                child: Image.asset(
                  'assets/scp_faq.png',
                  width: heightFactor * 0.45,
                  height: heightFactor * 0.45,
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomRight,
                  colorBlendMode: BlendMode.color,
                ),
              ),
        ],
      ),
    ),
  ),
  );
}

Widget timetableCard(
    BuildContext context, double heightFactor, double textScaleFactor) {
  Gradients().init(context);
  return SizedBox(
    height: heightFactor * 0.58,
    child: Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/timetable');
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: Gradients.timetableCardGradient,
                  ),
                  child: Container(
                    height: heightFactor * 0.58,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0),
                            title: ShaderMask(
                              shaderCallback: (rect) {
                                return LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.black, Colors.transparent],
                                ).createShader(Rect.fromLTRB(
                                    0, 0, rect.width, rect.height));
                              },
                              blendMode: BlendMode.dstIn,
                              child: Container(
                                height: heightFactor * 0.15,
                                color: Colors.white,
                                padding: EdgeInsets.only(left: 18.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'MY TIMETABLE',
                                    style: TextStyle(
                                        fontFamily: 'PfDin',
                                        fontSize: heightFactor * 0.07,
                                        color:
                                            Color.fromRGBO(142, 40, 142, 1.0),
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: 200.0,
                              child: Text(
                                'Set your personal timetable and get information about class timings and location',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: heightFactor * 0.038,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'PfDin',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10.0,
                right: 0.0,
                child: Image.asset(
                  'assets/scp_timetable.png',
                  width: heightFactor * 0.45,
                  height: heightFactor * 0.45,
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomRight,
                  colorBlendMode: BlendMode.color,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget slotCard(
    BuildContext context,
    double heightFactor,
    double textScaleFactor,
    String counselDay,
    String titleText,
    String designation) {
  Widget slotWidget(String status, String key, String time) {
    final bool visible = false;
    bool isSelected = false;

    void bookAppointment(String key) async{
      await ScpDatabase.slotsRef.child(key).update({
        "phoneNo" : "",
        "rollNo" : "",
        "status" : "1",
      }).then((_){
        print("Value updated");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                Booking(keyCode: key)));
      });
    }

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setSlotWidgetState) =>
          InkWell(
        onTap: () {
          switch (status) {
            case "0":
              setSlotWidgetState(() {
                isSelected = !isSelected;
              });

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirm Slot Booking?'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          setSlotWidgetState(() {
                            isSelected = !isSelected;
                          });
                          Navigator.pop(context);
                        },
                        child: Text('CANCEL'),
                        textColor: Colors.cyan,
                      ),
                      RaisedButton(
                        color: Colors.cyan,
                        onPressed: () {
                          Navigator.pop(context);
                          bookAppointment(key);
                        },
                        child: Text('BOOK'),
                        textColor: Colors.white,
                      ),
                    ],
                  );
                },
              );
              break;
            case "1":
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Selected slot is full. Please choose another slot.'),
                ),
              );
              break;
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: heightFactor * 0.02),
          child: SizedBox(
            width: heightFactor * 0.70,
            height: heightFactor * 0.09,
            child: Container(
              padding: const EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: (status == "0")
                      ? (isSelected ? Colors.black : Colors.cyan)
                      : Colors.red,
                ),
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '$counselDay | 26th July | $time',
                      style: TextStyle(
                          color: (status == "0")
                              ? (isSelected ? Colors.black : Colors.cyan)
                              : Colors.red,
                          fontFamily: 'PfDin',
                          fontSize: heightFactor * 0.038,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Visibility(
                    visible: (status == "0") ? visible : !visible,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Container(
                        child: Text(
                          'Slot full',
                          style: TextStyle(
                            fontSize: heightFactor * 0.038,
                            fontFamily: 'PfDin',
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  return Container(
    color: Colors.white,
    child: SizedBox(
      height: heightFactor * 1.1,
      width: heightFactor * 0.85,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            12.0,
          ),
        ),
        elevation: 4.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Text(
                titleText,
                style: TextStyle(
                    fontFamily: 'PfDin',
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: heightFactor * 0.065),
              ),
            ),
            Text(
              designation,
              style: TextStyle(
                  fontFamily: 'PfDin',
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: heightFactor * 0.05),
            ),
            SizedBox(
              height: heightFactor * 0.047,
            ),
            StreamBuilder(
                stream: ScpDatabase.slotsRef.once().asStream(),
                builder: (context, snapshot) {
                  DataSnapshot _slotsSnapshot = snapshot.data;
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  return ListView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: heightFactor * 0.047),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 6, //ScpDatabase.slotsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var slot =
                            Slot.map(_slotsSnapshot.value['slot${index + 1}']);
                        return slotWidget(slot.status, slot.key, slot.time);
                      });
                }),
          ],
        ),
      ),
    ),
  );
}