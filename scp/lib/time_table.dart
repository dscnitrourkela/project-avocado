import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scp/firebase/timetable_data.dart';
import 'package:scp/utils/routes.dart';
import 'package:scp/utils/sizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'time_table_resources.dart';
import 'package:url_launcher/url_launcher.dart';

class TimeTable extends StatefulWidget {
  TimeTable();

  @override
  TimeTableState createState() => new TimeTableState();
}

class TimeTableState extends State<TimeTable> {
  String section = "";
  List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  bool allowedSection = true;

  bool showTimeTable = false;

  final Color primaryColor = Color.fromARGB(255, 49, 68, 76);
  final Color secondaryColor = Color.fromARGB(255, 158, 218, 224);
  final Color lunchColor = Color.fromARGB(255, 238, 71, 89);
  final double unitHeight = 80.0;
  double? screenWidth, screenHeight;

  Future _fetchSection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getKeys();
    if (prefs.getString('theory_section') != null &&
        prefs.getString('prac_section') != null) {
      section =
          prefs.getString('theory_section')! + prefs.getString('prac_section')!;
    }
  }

  int _getSlotLength(String startTime, String endTime) {
    List<String> startTimeList = startTime.split(':');
    List<String> endTimeList = endTime.split(':');
    double startTimeFloat =
        int.parse(startTimeList[0]) + int.parse(startTimeList[1]) / 60;
    double endTimeFloat =
        int.parse(endTimeList[0]) + int.parse(endTimeList[1]) / 60;
    return (endTimeFloat - startTimeFloat).round();
  }

  String _convertTo12(String time) {
    List<String> timeList = time.split(':');
    int hour = int.parse(timeList[0]);
    String ampm = 'AM';
    if (hour > 12) {
      hour -= 12;
      ampm = 'PM';
    }
    if (hour == 12) ampm = 'PM';
    return hour.toString() + ':' + timeList[1] + ampm;
  }

  List<PeriodDetails?> _generateList(List<dynamic> dataArray) {
    List<PeriodDetails?> dayList = [];
    String lastEndTime = '8:00';
    int i = 0;
    for (; i < dataArray.length; i++) {
      Map<String, dynamic> data = dataArray[i];
      if (_getSlotLength(data['startTime'], '12:00') < 1) {
        int slotLenght = _getSlotLength(lastEndTime, '12:00');
        if (slotLenght > 0) {
          dayList.add(
            PeriodDetails(
              name: 'Free',
              location: null,
              slotTime: _convertTo12(lastEndTime) + '-' + '12:00PM',
              slotLength: slotLenght,
              type: 'free',
            ),
          );
        }
        break;
      }
      int slotLenght = _getSlotLength(lastEndTime, data['startTime']);
      if (slotLenght > 0) {
        dayList.add(
          PeriodDetails(
            name: 'Free',
            location: null,
            slotTime: _convertTo12(lastEndTime) +
                '-' +
                _convertTo12(data['startTime']),
            slotLength: slotLenght,
            type: 'free',
          ),
        );
      }
      lastEndTime = data['endTime'];
      dayList.add(
        PeriodDetails(
          name: data['subject'],
          location: data['type'] == 'practical'
              ? data['location']['geopoint'] as GeoPoint
              : null,
          locationName: data['location']['title'],
          slotTime: _convertTo12(data['startTime']) +
              '-' +
              _convertTo12(data['endTime']),
          slotLength: _getSlotLength(data['startTime'], data['endTime']),
          type: data['type'],
        ),
      );
    }

    int slotLenght = _getSlotLength(lastEndTime, '12:00');
    if (slotLenght > 0 && i == dataArray.length) {
      dayList.add(
        PeriodDetails(
          name: 'Free',
          location: null,
          slotTime: _convertTo12(lastEndTime) + '-' + '12:00PM',
          slotLength: slotLenght,
          type: 'free',
        ),
      );
    }

    dayList.add(
      PeriodDetails(
        name: 'Lunch',
        location: null,
        slotLength: 1,
        slotTime: '12:00PM-1:15PM',
        type: 'lunch',
      ),
    );
    lastEndTime = '13:15';
    for (; i < dataArray.length; i++) {
      Map<String, dynamic> data = dataArray[i];
      int slotLenght = _getSlotLength(lastEndTime, data['startTime']);
      if (slotLenght > 0) {
        dayList.add(
          PeriodDetails(
            name: 'Free',
            location: null,
            slotTime: _convertTo12(lastEndTime) +
                '-' +
                _convertTo12(data['startTime']),
            slotLength: slotLenght,
            type: 'free',
          ),
        );
      }
      lastEndTime = data['endTime'];
      dayList.add(
        PeriodDetails(
          name: data['subject'],
          location:
              data['type'] == 'practical' ? data['location']['geopoint'] : null,
          locationName: data['location']['title'],
          slotTime: _convertTo12(data['startTime']) +
              '-' +
              _convertTo12(data['endTime']),
          slotLength: _getSlotLength(data['startTime'], data['endTime']),
          type: data['type'],
        ),
      );
    }

    slotLenght = _getSlotLength(lastEndTime, '18:15');
    if (slotLenght > 0) {
      dayList.add(
        PeriodDetails(
          name: 'Free',
          location: null,
          slotTime: _convertTo12(lastEndTime) + '-' + '6:15PM',
          slotLength: slotLenght,
          type: 'free',
        ),
      );
    }
    return dayList;
  }

  _resetSections(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.getKeys();
    sharedPreferences.remove('theory_section');
    sharedPreferences.remove('prac_section');
    sharedPreferences.setBool('show_timetable', false);
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.rHomepage, (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    int dayInd = DateTime.now().weekday - 1;
    screenWidth = SizeConfig.screenWidth;
    screenHeight = SizeConfig.screenHeight;
    if (allowedSection) {}
    return FutureBuilder(
      future: _fetchSection(),
      builder: (context, snap) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: (val) {
                  _resetSections(context);
                },
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: "Reset",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.sync_outlined,
                            color: Color(0xff313131),
                            size: 21,
                          ),
                          Text(
                            "Reset Section",
                            style: TextStyle(
                                color: Color(0xff313131),
                                fontSize: 16.5,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                  ];
                },
              )
            ],
            title: Text(
              'Your Timetable',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'PfDin',
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
            backgroundColor: primaryColor,
          ),
          body: DefaultTabController(
            length: 5,
            initialIndex: dayInd > 4 ? 0 : dayInd,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(80.0),
                child: AppBar(
                  // brightness: Brightness.light,
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
                    tabs: days
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
                  children: days
                      .map(
                        (day) => Container(
                          child: buildList(
                            context,
                            day,
                          ),
                        ),
                      )
                      .toList()),
            ),
          ),
        );
      },
    );
  }

  Widget buildMarker(double? length, Color stripColor) {
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

  void launchMap(GeoPoint geoPoint) async {
    Uri uri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${geoPoint.latitude},${geoPoint.longitude}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint("Could not launch $uri");
      throw 'Could not launch Maps';
    }
  }

  Widget buildClassCard(PeriodDetails periodDetail) {
    Color stripColor = primaryColor;

    return Container(
      margin: EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          buildMarker(unitHeight * periodDetail.slotLength!, stripColor),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: screenWidth! - 32.0,
              height: unitHeight * periodDetail.slotLength!,
              child: Card(
                color: stripColor,
                margin: EdgeInsets.zero,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Stack(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 23,
                            width: screenWidth! * 0.62,
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                periodDetail.name!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            height: 19.8,
                            width: screenWidth! * 0.65,
                            child: AutoSizeText(
                              periodDetail.slotTime!,
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          if (periodDetail.location != null) {
                            launchMap(periodDetail.location!);
                          }
                        },
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                color: Colors.white.withAlpha(200),
                                size: 20.0,
                              ),
                              Text(
                                periodDetail.locationName!,
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 20.0,
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

  Widget buildFreeCard(PeriodDetails periodDetail) {
    Color stripColor = secondaryColor;

    return Container(
      margin: EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          buildMarker(unitHeight * periodDetail.slotLength!, stripColor),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: screenWidth! - 32.0,
              height: unitHeight * periodDetail.slotLength!,
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
                            text: periodDetail.name! + '\n',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: periodDetail.slotTime,
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )),
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

  Widget buildLunchCard(PeriodDetails periodDetail) {
    Color stripColor = lunchColor;

    return Container(
      margin: EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          buildMarker(unitHeight * periodDetail.slotLength!, stripColor),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: screenWidth! - 32.0,
              height: unitHeight * periodDetail.slotLength!,
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
                            text: periodDetail.name! + '\n',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: periodDetail.slotTime,
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )),
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

  StreamBuilder buildList(BuildContext context, String day) {
    day = day.toLowerCase();
    return StreamBuilder(
      stream: TimeTableData(section, day).getStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error fetching data',
              style: TextStyle(
                color: Colors.red,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }
        List<PeriodDetails?> dayList = _generateList(snapshot.data);

        return ListView.builder(
            itemCount: dayList.length,
            itemBuilder: (BuildContext context, int index) {
              if (dayList[index]!.type == 'theory') {
                return buildClassCard(dayList[index]!);
              } else if (dayList[index]!.type == 'practical') {
                return buildClassCard(dayList[index]!);
              } else if (dayList[index]!.type == 'lunch') {
                return buildLunchCard(dayList[index]!);
              } else {
                return buildFreeCard(dayList[index]!);
              }
            });
      },
    );
  }
}
