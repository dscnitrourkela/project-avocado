import 'package:flutter/material.dart';
import 'package:scp/ui/gradients.dart';
import 'package:scp/utils/routes.dart';

class TimetableCardSplit extends StatefulWidget {
  BuildContext cxt;
  double heightFactor, textSc;

  TimetableCardSplit(this.cxt, this.heightFactor, this.textSc);

  @override
  _TimetableCardSplitState createState() => _TimetableCardSplitState();
}

class _TimetableCardSplitState extends State<TimetableCardSplit> {
  bool isTapped;
  double width1, width2;

  @override
  void initState() {
    super.initState();
    isTapped = false;
    width1 = widget.heightFactor;
    width2 = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Flexible(
                child: timetableCard(widget.cxt, widget.heightFactor,
                    widget.textSc, width1, "Attendance Tracker", 1)),
          ],
        ),
        Row(
          children: <Widget>[
            Flexible(
                child: timetableCard(widget.cxt, widget.heightFactor,
                    widget.textSc, width1, "Regular Classes", 0)),
          ],
        ),
      ],
    );
  }

  Widget timetableCard(BuildContext context, double heightFactor,
      double textScaleFactor, double width, String onTapText, int cardType) {
    Gradients().init(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
      height: heightFactor * 0.58,
      width: width,
      child: InkWell(
        onLongPress: () {
          print(cardType);
        },
        onTap: () {
          setState(() {
            if (!isTapped) {
              isTapped = !isTapped;
              width1 = widget.heightFactor / 2;
              width2 = width1;
            } else {
              /*cardType helps us determine upon which card have we registered the tap
              0 is for left card, 1 is for right card*/
              if (cardType == 0) //Regular
                Navigator.pushNamed(context, Routes.rTimetable);
              if (cardType == 1) //Remedial

                Navigator.pushNamed(context, Routes.rAttendance);
            }
          });
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
                      child: Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              AnimatedOpacity(
                                opacity: isTapped ? 0 : 1,
                                duration: Duration(milliseconds: 100),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    title: ShaderMask(
                                      shaderCallback: (rect) {
                                        return LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.black,
                                            Colors.transparent
                                          ],
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
                                                color: Color.fromRGBO(
                                                    142, 40, 142, 1.0),
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedOpacity(
                                opacity: isTapped ? 0 : 1,
                                duration: Duration(milliseconds: 100),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 14.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(
                                      width: 200.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            'Set your personal timetable and track       your attendance',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: heightFactor * 0.038,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'PfDin',
                                            ),
                                          ),
                                          SizedBox(
                                            height: heightFactor * 0.055,
                                          ),
                                          Text(
                                            'Data will get reset on re-installation',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: heightFactor * 0.028,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'PfDin',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          AnimatedOpacity(
                            opacity: !isTapped ? 0 : 1,
                            duration: Duration(milliseconds: 100),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: SizedBox(
                                  height: heightFactor * 0.15,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      onTapText,
                                      style: TextStyle(
                                          fontFamily: 'PfDin',
                                          fontSize: heightFactor * 0.06,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ),
              Positioned(
                top: 10.0,
                right: 0.0,
                child: AnimatedOpacity(
                  opacity: isTapped ? 0 : 1,
                  duration: Duration(milliseconds: 100),
                  child: Image.asset(
                    'assets/scp_timetable.png',
                    width: heightFactor * 0.45,
                    height: heightFactor * 0.45,
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomRight,
                    colorBlendMode: BlendMode.color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
