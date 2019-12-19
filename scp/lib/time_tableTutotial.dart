import 'package:flutter/material.dart';
import 'package:scp/utils/sizeConfig.dart';
import 'time_table_resourcesTutorial.dart';
import 'package:url_launcher/url_launcher.dart';

class TutorialTimeTable extends StatefulWidget {
  TutorialTimeTable();

  @override
  TutorialTimeTableState createState() => new TutorialTimeTableState();
}

class TutorialTimeTableState extends State<TutorialTimeTable> {
  String theorySection = 'Tut1';
  String sectionSequence = 'tp';

  final Color primaryColor = Color.fromARGB(255, 49, 68, 76);
  final Color secondaryColor = Color.fromARGB(255, 158, 218, 224);
  final Color lunchColor = Color.fromARGB(255, 238, 71, 89);
  final double unitHeight = 80.0;
  double screenWidth, screenHeight;


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    screenWidth = SizeConfig.screenWidth;
    screenHeight = SizeConfig.screenHeight;
    return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Your Timetable',
            ),
            backgroundColor: primaryColor,
          ),
          body: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(80.0),
                child: AppBar(
                  brightness: Brightness.light,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  toolbarOpacity: 0.0,
                  flexibleSpace: TabBar(
                    indicatorPadding: EdgeInsets.zero,
                    labelStyle: TextStyle(
                      color: primaryColor,
                      fontSize: 30,
                    ),
                    unselectedLabelStyle: TextStyle(
                        color: primaryColor.withAlpha(100), fontSize: 20),
                    labelPadding:
                    EdgeInsets.symmetric(vertical: 16.0, horizontal: 48.0),
                    indicatorColor: Colors.transparent,
                    tabs: TimeTableResources.sequence[sectionSequence].keys
                        .map(
                          (day) => Tab(
                        child: Text(
                          day,
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    )
                        .toList(),
                    isScrollable: true,
                  ),
                ),
              ),
              body: TabBarView(
                  children: TimeTableResources.sequence[sectionSequence].entries
                      .map((entry) => Container(
                      child: buildList(context, entry.key, entry.value)))
                      .toList()),
            ),
          ),
        );
  }

  Widget buildMarker(double length, Color stripColor) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 8.0,
        height: length,
        decoration: BoxDecoration(
          color: stripColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
    );
  }

  void launchMap(String url) async {
    if (await canLaunch(url)) {
      print("Can launch");
      await launch(url);
    } else {
      print("Could not launch $url");
      throw 'Could not launch Maps';
    }
  }

  Widget buildTheoryCard(PeriodDetails periodDetail) {
    Color stripColor = primaryColor;

    return Container(
      margin: EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          buildMarker(unitHeight * periodDetail.slotLength, stripColor),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: screenWidth - 32.0,
              height: unitHeight * periodDetail.slotLength,
              child: Card(
                color: stripColor,
                margin: EdgeInsets.zero,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Stack(children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: periodDetail.name + '\n',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700),
                              ),
                              TextSpan(
                                text: periodDetail.slotTime + '\n',
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          launchMap(periodDetail.location);
                        },
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                color: Colors.white.withAlpha(200),
                                size: 24.0,
                              ),
                              Text(
                                periodDetail.locationName,
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 24.0,
                                ),
                              )
                            ]),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  ListView buildList(BuildContext context, String day, List<String> codes) {
    List<PeriodDetails> dayList = new List<PeriodDetails>();
    dayList = getDayList(day, codes);

    print("Length ${dayList.length}");

    return ListView.builder(
        itemCount: dayList.length,
        itemBuilder: (BuildContext context, int index) {

            return buildTheoryCard(dayList[index]);
          }
        );
  }

  List<PeriodDetails> getDayList(String day, List<String> codes) {
    List<bool> slotFilled = [
      false,
      false,
      false,
      false,
      false,

    ];
    List<PeriodDetails> dayList = new List<PeriodDetails>(9);

    int j;
    for (int i = 0; i < codes.length; i++) {
      j = i % 9;
      if (slotFilled[j] == true) {
        continue;
      } else if (TimeTableResources.theory[theorySection]
          .containsKey(codes[i])) {
        dayList[j] = PeriodDetails(
          name: TimeTableResources.theory[theorySection][codes[i]],
          slotTime: getSlotTime(j, j),
          slotLength: 1,
          type: 'theory',
          location:
          'https://www.google.com/maps/search/?api=1&query=22.2513332,84.9048918',
          locationName: 'LA1',
        );
        slotFilled[j] = true;
      }
    }

    List<PeriodDetails> dayList2 = new List<PeriodDetails>();
    dayList2.addAll(dayList);
    for (int i = 0; i < dayList2.length; i++) {
      if (dayList2[i] == null) {
        dayList2.removeAt(i);
        i--;
      }
    }

    return dayList2;
  }

  String getSlotTime(int startSlotIndex, int endSlotIndex) {
    return TimeTableResources.slotTime[startSlotIndex]['start'] +
        '-' +
        TimeTableResources.slotTime[endSlotIndex]['end'];
  }
}
