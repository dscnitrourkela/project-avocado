import 'dart:math';
import 'package:flutter/material.dart';
import 'package:scp/attendance/attendance_tracker.dart';

import 'package:shared_preferences/shared_preferences.dart';

const List<String> sectionArray = [
  "Ar.",
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H"
];
const FULL_SCALE = 1.0;
const SCALE_FRACTION = 1.7;
const VIEWPORT_FRACTION = 0.4;
double page = 0.0;
int currentPage = 0;
PageController pageController;
double pagerHeight = 140.0;

class Theory extends StatefulWidget {
  @override
  _TheoryState createState() => _TheoryState();
}

class _TheoryState extends State<Theory> {
  @override
  void initState() {
    pageController = PageController(
        initialPage: currentPage, viewportFraction: VIEWPORT_FRACTION);
    super.initState();
  }

  Future fetchSection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showTracker = prefs.getBool('show_tracker');
    if (showTracker) {
      Navigator.of(context).pop();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AttendanceTracker(prefs.getString('theory_section')),
          ));
    }
  }

  storeSectionData(BuildContext context, String theory) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theory_section', theory);

    await prefs.setBool('show_tracker', true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchSection(),
        builder: (context, snap) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(25, 39, 45, 1),
              title: Text(
                "Section Selector",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'PfDin',
                  color: Colors.white,
                ),
              ),
            ),
            body: Container(
              alignment: Alignment.center,
              child: Center(
                  child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment(0, -0.6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "Select your theory section",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'PfDin',
                                color: Color.fromRGBO(25, 39, 45, 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, 0.6),
                    child: FloatingActionButton(
                      onPressed: () => {
                        storeSectionData(context,
                            sectionArray[pageController.page.round().toInt()]),
                        Navigator.of(context).pop(),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AttendanceTracker(
                                    sectionArray[(pageController.page
                                        .round()
                                        .toInt())]))),
                      },
                      child: Icon(Icons.arrow_forward),
                      backgroundColor: Color.fromRGBO(74, 232, 190, 1),
                    ),
                  ),
                  Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                      child: Container(
                        height: pagerHeight,
                        width: pagerHeight,
                      ),
                      elevation: 20,
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: _buildCarousel(this, context, 8)),
                ],
              )),
            ),
          );
        });
  }
}

Widget _buildCarousel(
    _TheoryState timetableState, BuildContext context, int carouselIndex) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      SizedBox(
        // you may want to use an aspect ratio here for tablet support
        height: 200.0,
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollUpdateNotification) {
              timetableState.setState(() {
                page = pageController.page;
              });
            }
          },
          child: PageView.builder(
            // store this controller in a State to save the carousel scroll position
            controller: pageController,
            itemCount: sectionArray.length,
            itemBuilder: (BuildContext context, int itemIndex) {
              final sizeScale = max(SCALE_FRACTION,
                  (FULL_SCALE - (itemIndex - page).abs()) + VIEWPORT_FRACTION);
              final colorScale = min(SCALE_FRACTION,
                  (FULL_SCALE - (itemIndex - page).abs()) + VIEWPORT_FRACTION);
              return _buildCarouselItem(
                  context, carouselIndex, itemIndex, sizeScale, colorScale);
            },
          ),
        ),
      )
    ],
  );
}

Widget _buildCarouselItem(BuildContext context, int carouselIndex,
    int itemIndex, double sizeScale, double colorScale) {
  return Container(
    alignment: Alignment.center,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        sectionArray[itemIndex],
        style: TextStyle(
            fontSize: 50.0 * sizeScale,
            fontWeight: FontWeight.w500,
            fontFamily: 'PfDin',
            color: Color.fromRGBO(25, 39, 45, colorScale),
            letterSpacing: 2),
      ),
    ),
  );
}
