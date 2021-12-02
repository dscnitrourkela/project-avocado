import 'package:flutter/material.dart';
import 'package:scp/ui/dsc_social.dart';
import 'package:scp/ui/gradients.dart';

class SlotCardSplit extends StatefulWidget {
  final BuildContext cxt;
  final double heightFactor, textSc;
  const SlotCardSplit(this.cxt, this.heightFactor, this.textSc);

  @override
  _SlotCardSplitState createState() => _SlotCardSplitState();
}

class _SlotCardSplitState extends State<SlotCardSplit> {
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
                child: slotCard(
              widget.cxt,
              widget.heightFactor,
              widget.textSc,
              width1,
              "OFFLINE Counselling",
              1,
              'assets/icon-white.png',
            )),
          ],
        ),
        Row(
          children: <Widget>[
            Flexible(
                child: slotCard(
              widget.cxt,
              widget.heightFactor,
              widget.textSc,
              width1,
              "YourDOST Counselling",
              0,
              'assets/ydd.png',
            )),
          ],
        ),
      ],
    );
  }

  Widget slotCard(
      BuildContext context,
      double heightFactor,
      double textScaleFactor,
      double width,
      String onTapText,
      int cardType,
      String onTapImage) {
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
              {
                launchURL("https://www.yourdost.in/");
              }
              if (cardType == 1) //Remedial
              {
                launchURL("https://forms.gle/e8K6ZVvoNZ683ZRp6");
              }
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
                    gradient: Gradients.appointmentCardGradient,
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
                                            'STUDENT COUNSELLING',
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
                                            'Feeling low? Do not worry. We got your back!',
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
                                  height: heightFactor * 0.32,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          child: Image.asset(
                                            onTapImage,
                                            width: heightFactor * 0.15,
                                            height: heightFactor * 0.15,
                                            fit: BoxFit.fill,
                                            alignment: Alignment.topCenter,
                                            colorBlendMode: BlendMode.color,
                                          ),
                                        ),
                                        Text(
                                          onTapText,
                                          style: TextStyle(
                                              fontFamily: 'PfDin',
                                              fontSize: heightFactor * 0.06,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
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
                top: MediaQuery.of(context).size.width * 0.075,
                left: MediaQuery.of(context).size.width * 0.55,
                child: AnimatedOpacity(
                  opacity: isTapped ? 0 : 1,
                  duration: Duration(milliseconds: 100),
                  child: Image.asset(
                    'assets/scp_app.png',
                    width: heightFactor * 0.4,
                    height: heightFactor * 0.4,
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
