import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scp/time_table.dart';
import 'package:shared_preferences/shared_preferences.dart';

const List<String> sectionArray = [
  "P1",
  "P2",
  "P3",
  "P4",
  "P5",
  "P6",
  "P7",
  "P8",
  "P9",
  "P10"
];
const FULL_SCALE = 1.0;
const SCALE_FRACTION = 0.7;
const VIEWPORT_FRACTION = 0.4;
double page = 0.0;
int currentPage = 0;
PageController pageController;
double pagerHeight = 140.0;
String theorySection;

class PracticalSection extends StatefulWidget {
  PracticalSection(String section) {
    theorySection = section;
  }

  @override
  _PracticalSectionState createState() => _PracticalSectionState();
}

class _PracticalSectionState extends State<PracticalSection> {
  @override
  void initState() {
    pageController = PageController(
        initialPage: currentPage, viewportFraction: VIEWPORT_FRACTION);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 39, 45, 1),
        title: Text(
          "Timetable Selector",
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
                  Center(
                    child: Text(
                      "Step 2",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'PfDin',
                        color: Color.fromRGBO(74, 232, 190, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Select your practical section",
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
                onPressed: () {
                storeSectionData(context);
                },
                child: Icon(Icons.arrow_forward),
                backgroundColor: Color.fromRGBO(74, 232, 190, 1),
              ),
            ),
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
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
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Align(
    alignment: Alignment.bottomCenter,
    child: Text("The timetable is subject to change")),
    )
          ],
        )),
      ),
    );
  }
}

storeSectionData(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('theory_section', theorySection);
  await prefs.setString('prac_section', sectionArray[
  (pageController.page.round().toInt())]);
  await prefs.setBool('show_timetable', true);
  Navigator.of(context).pop();
  Navigator.push(
  context,
  MaterialPageRoute(
  builder: (context) => TimeTable()),
  );
}

Widget _buildCarousel(_PracticalSectionState timetableState,
    BuildContext context, int carouselIndex) {
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
    child: Text(
      sectionArray[itemIndex],
      style: TextStyle(
          fontSize: 50.0 * sizeScale,
          fontWeight: FontWeight.w500,
          fontFamily: 'PfDin',
          color: Color.fromRGBO(25, 39, 45, colorScale),
          letterSpacing: 2),
    ),
  );
}
