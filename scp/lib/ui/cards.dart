import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scp/booking.dart';
import 'package:scp/ui/views/mentor_search/mentee_page.dart';
import 'package:scp/ui/views/mentor_search/mentor_page.dart';
import 'package:scp/ui/gradients.dart';
import 'package:scp/firebase/firebaseDBHandler.dart';
import 'package:scp/utils/routes.dart';
import 'package:scp/utils/sizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/models.dart';
import 'package:scp/upload_image.dart';

const platform = const MethodChannel("FAQ_ACTIVITY");
Widget appointmentCard(BuildContext context) {
  Gradients().init(context);
  SizeConfig().init(context);
  double heightFactor = SizeConfig.screenWidth;
  return SizedBox(
    height: heightFactor * 0.58,
    child: Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: InkWell(
        onTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (prefs.getBool('hasBooked') == true) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    Booking(counselDay: gCounselDay, time: gTime)));
          } else
            Navigator.of(context).pushNamed(Routes.rAppointments);
        },
        // onTap: () async {
        //   SharedPreferences prefs = await SharedPreferences.getInstance();
        //   if (prefs.getBool('hasBooked') == true) {
        //     Navigator.of(context).push(MaterialPageRoute(
        //         builder: (BuildContext context) => Booking(
        //             /*keyCode: gKey,*/ counselDay: gCounselDay, time: gTime)));
        //   } else
        //     Navigator.of(context).pushNamed('/appointments');
        // },
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
                                  /*decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0, color: Colors.white),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                  ),*/
                                  child: Text(
                                    'BOOK',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
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
                                  const EdgeInsets.only(top: 20.0, left: 0.0),
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'YOUR',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
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
                                  //textScaleFactor: textScaleFactor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 14.0),
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: heightFactor * 0.47,
                            child: Text(
                              'Feel like talking to someone? Meet a counsellor today!',
                              style: TextStyle(
                                  fontSize: heightFactor * 0.037,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'PfDin'),
                            ),
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

Widget mentorsCard(BuildContext context, String roll) {
  Gradients().init(context);
  SizeConfig().init(context);
  if (roll == null) {
    return Center(child: CircularProgressIndicator());
  }
  double heightFactor = SizeConfig.screenWidth;
  print(roll);
  return SizedBox(
    height: heightFactor * 0.58,
    child: InkWell(
      onTap: () {
        if (roll.toString()[2] == '1') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailScreen(roll.toString())));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ListDetails(roll.toString())));
        }
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
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          title: ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
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
                                  (roll[2] == "0") ? 'MENTOR' : "MENTEES",
                                  style: TextStyle(
                                      fontFamily: 'PfDin',
                                      fontSize: heightFactor * 0.07,
                                      color: Color.fromRGBO(142, 40, 142, 1.0),
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
                              (roll[2] == "0")
                                  ? 'Find more about your ICS Mentor'
                                  : 'Find the list of your Mentees',
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
  );
}

Widget eventsCard(BuildContext context) {
  Gradients().init(context);
  SizeConfig().init(context);
  double heightFactor = SizeConfig.screenWidth;

  return SizedBox(
    height: heightFactor * 0.58,
    child: InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.rEvents),
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
                  gradient: Gradients.eventsCardGradient,
                ),
                child: Container(
                  height: heightFactor * 0.58,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          title: ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
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
                                  'ICS Events',
                                  style: TextStyle(
                                      fontFamily: 'PfDin',
                                      fontSize: heightFactor * 0.07,
                                      color: Color.fromRGBO(142, 40, 142, 1.0),
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
                              'Catch up with our upcoming events',
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
                'assets/scp_events.png',
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

_startFAQActivity() async {
  try {
    await platform.invokeMethod('startFaqActivity');
  } on PlatformException catch (e) {
    print(e.message);
  }
}

Widget faqCard(BuildContext context) {
  Gradients().init(context);
  SizeConfig().init(context);
  double heightFactor = SizeConfig.screenWidth;
  return SizedBox(
    height: heightFactor * 0.58,
    child: InkWell(
      onTap: () {
        _startFAQActivity();
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
                  gradient: Gradients.faqCardGradient,
                ),
                child: Container(
                  height: heightFactor * 0.58,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 18.0,
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
                        padding: const EdgeInsets.only(left: 20.0),
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
            ),
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

Widget timetableCard(BuildContext context) {
  Gradients().init(context);
  SizeConfig().init(context);
  double heightFactor = SizeConfig.screenWidth;
  return SizedBox(
    height: heightFactor * 0.58,
    child: InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.rTimetable);
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
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          title: ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
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
                                  'MY TIMETABLE',
                                  style: TextStyle(
                                      fontFamily: 'PfDin',
                                      fontSize: heightFactor * 0.07,
                                      color: Color.fromRGBO(142, 40, 142, 1.0),
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
  );
}

var gKey, gCounselDay, gTime;

Widget slotCard(BuildContext context, String titleText, String type,
    String designation, int count, double scaleHeight) {
  SizeConfig().init(context);
  double heightFactor = SizeConfig.screenWidth;
  Widget slotWidget(String status, String key, String time, String index,
      String date, String day) {
    final bool visible = false;
    bool isSelected = false;
    SizeConfig().init(context);
    double heightFactor = SizeConfig.screenWidth;
    print('$day' + 'smarak');

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setSlotWidgetState) {
        return InkWell(
          onTap: () {
            switch (status) {
              case "0":
                setSlotWidgetState(() {
                  isSelected = !isSelected;
                });
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UploadImageScreen(
                              bookingKey: key,
                              time: time,
                              counselDay: day,
                              date: date,
                              type: type,
                              index: index,
                            )));
                break;
              case "1":
                ScaffoldMessenger.of(context).showSnackBar(
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
                        '$day | $date | $time',
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
        );
      },
    );
  }

  return Container(
    color: Colors.white,
    child: SizedBox(
      height: heightFactor * scaleHeight,
      width: heightFactor * 0.85,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            12.0,
          ),
        ),
        elevation: 5.0,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Center(
                child: Text(
                  titleText,
                  style: TextStyle(
                      fontFamily: 'PfDin',
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: heightFactor * 0.065),
                ),
              ),
            ),
            Center(
              child: Text(
                designation,
                style: TextStyle(
                    fontFamily: 'PfDin',
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: heightFactor * 0.05),
              ),
            ),
            SizedBox(
              height: heightFactor * 0.047,
            ),
            StreamBuilder(
                stream: (type == "psych")
                    ? ScpDatabase.psychRef.once().asStream()
                    : ScpDatabase.counselRef.once().asStream(),
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
                      itemCount: count, //ScpDatabase.slotsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var slot =
                            Slot.map(_slotsSnapshot.value['slot${index + 1}']);
                        return slotWidget(slot.status, slot.key, slot.time,
                            (index + 1).toString(), slot.date, slot.day);
                      });
                }),
          ],
        ),
      ),
    ),
  );
}
