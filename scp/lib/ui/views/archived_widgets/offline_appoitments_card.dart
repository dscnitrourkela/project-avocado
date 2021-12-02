import 'package:flutter/material.dart';
import 'package:scp/booking.dart';
import 'package:scp/ui/cards.dart';
import 'package:scp/ui/gradients.dart';
import 'package:scp/utils/routes.dart';
import 'package:scp/utils/sizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
