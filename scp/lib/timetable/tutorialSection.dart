import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scp/time_tableTutotial.dart';

const List<String> sectionArray = ["Bridge", "Tutorial"];
const FULL_SCALE = 1.0;
const SCALE_FRACTION = 0.7;
const VIEWPORT_FRACTION = 0.4;
double page = 0.0;
int currentPage = 0;
PageController pageController;
double pagerHeight = 140.0;

class TutorialSection extends StatefulWidget {
  @override
  _TutorialSectionState createState() => _TutorialSectionState();
}

class _TutorialSectionState extends State<TutorialSection> {
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
                      "Step 1",
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
                        "Select your section",
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
                  Navigator.of(context).pop(),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TutorialTimeTable()))
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
                  child: Text(
                      "The timetable is subject to change. Stay in touch with the tutor")),
            )
          ],
        )),
      ),
    );
  }
}

Widget _buildCarousel(_TutorialSectionState timetableState,
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
            return false;
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
            fontSize: 20.0 * sizeScale,
            fontWeight: FontWeight.w500,
            fontFamily: 'PfDin',
            color: Color.fromRGBO(25, 39, 45, colorScale),
            letterSpacing: 2),
      ),
    ),
  );
}
