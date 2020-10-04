import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:scp/time_table_resources.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class AttendanceTracker extends StatefulWidget {
  @override
  _AttendanceTrackerState createState() => _AttendanceTrackerState();
}

class _AttendanceTrackerState extends State<AttendanceTracker> {
  final Color primaryColor = Color.fromARGB(255, 49, 68, 76);
  final Color secondaryColor = Color.fromARGB(255, 158, 218, 224);
  final Color lunchColor = Color.fromARGB(255, 238, 71, 89);

  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events;
  Map<String, int> _absents;
  List<dynamic> _selectedEvents;
  String markedValue;
  List<String> subjects;
  SharedPreferences pref;

  DateTime currentDay;
  var theorySection;
  var practicalSection;
  static var sectionSequence;

  Future fetchSectionData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    theorySection = prefs.getString('theory_section');
    practicalSection = prefs.getString('prac_section');
    if ((theorySection.compareTo('Ar.') == 0) ||
        (theorySection.compareTo('A') == 0) ||
        (theorySection.compareTo('D') == 0) ||
        (theorySection.compareTo('C') == 0) ||
        (theorySection.compareTo('B') == 0)) {
      sectionSequence = 'tp';
    }
  }

  @override
  void initState() {
    currentDay = DateTime.now();
    _calendarController = CalendarController();
    _events = {};
    _absents = {};
    _selectedEvents = [];

    initPrefs();
    super.initState();
  }

  initPrefs() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(pref.getString('events') ?? "{}")));
      _absents = Map<String, int>.from(
          decodeAbs(json.decode(pref.getString('absents') ?? "{}")));
    });
  }

  Map<String, dynamic> encodeAbs(Map<String, int> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<String, int> decodeAbs(Map<String, dynamic> map) {
    Map<String, int> newMap = {};
    map.forEach((key, value) {
      newMap[key] = map[key.toString()];
    });
    return newMap;
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    fetchSectionData();
    Map<dynamic, dynamic> codes = TimeTableResources.sequence[sectionSequence];
    List<String> items(DateTime day) {
      List<String> subList = new List<String>();
      List<String> dayList = new List<String>();
      String weekday = DateFormat('EEEE').format(day);

      dayList = codes[weekday];

      for (var ele in dayList) {
        if (day.weekday <= 5) {
          if (TimeTableResources.theory[theorySection].containsKey(ele)) {
            subList
                .add(TimeTableResources.theory[theorySection][ele].toString());
          } else if (TimeTableResources.practical[practicalSection]
                  .containsKey(ele) &&
              !subList.contains(TimeTableResources.practical[practicalSection]
                      [ele]
                  .toString())) {
            subList.add(
                TimeTableResources.practical[practicalSection][ele].toString());
          }
        }
      }
      print(subList);
      return subList;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(25, 39, 45, 1),
          title: Text(
            "Attendance Tracker",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              fontFamily: 'PfDin',
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TableCalendar(
                events: _events,
                initialSelectedDay: DateTime.now(),
                calendarController: _calendarController,
                initialCalendarFormat: CalendarFormat.month,
                onDaySelected: (day, events) {
                  setState(() {
                    markedValue = items(day)[0];
                    currentDay = day;
                    _selectedEvents = events;
                  });
                },
                builders: CalendarBuilders(
                    selectedDayBuilder: (context, date, events) {
                  return RaisedButton(
                      elevation: 4.0,
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      color: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      onPressed: () {});
                }),
                calendarStyle: CalendarStyle(
                    canEventMarkersOverflow: true,
                    todayColor: primaryColor,
                    selectedColor: secondaryColor,
                    markersColor: primaryColor,
                    markersMaxAmount: 4,
                    todayStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: 'PfDin',
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                headerStyle: HeaderStyle(
                  titleTextStyle:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  centerHeaderTitle: true,
                  formatButtonVisible: false,
                  headerMargin: EdgeInsets.all(8.0),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              (currentDay.weekday <= 5)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        DropdownButton<String>(
                            icon: Icon(Icons.keyboard_arrow_down),
                            iconSize: 16,
                            elevation: 10,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            onChanged: (value) {
                              setState(() {
                                markedValue = value;
                              });
                            },
                            value: markedValue,
                            items: items(currentDay).map((entry) {
                              return DropdownMenuItem(
                                  value: entry,
                                  child: Text(
                                    entry,
                                    style: TextStyle(color: primaryColor),
                                  ));
                            }).toList()),
                        RaisedButton(
                            elevation: 10,
                            color: primaryColor,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            child: Text("Enter"),
                            onPressed: () {
                              setState(() {
                                if (_absents.containsKey(markedValue)) {
                                  _absents[markedValue.toString()]++;
                                } else {
                                  _absents[markedValue.toString()] = 1;
                                }
                                if (_selectedEvents.contains(markedValue)) {
                                  return;
                                } else {
                                  if (_events[
                                          _calendarController.selectedDay] !=
                                      null) {
                                    _selectedEvents.add(markedValue);
                                    _events[_calendarController.selectedDay]
                                        .add(markedValue);
                                  } else {
                                    _selectedEvents.add(markedValue);
                                    _events[_calendarController.selectedDay] = [
                                      markedValue
                                    ];
                                  }
                                }
                                pref.setString('absents',
                                    json.encode(encodeAbs(_absents)));
                                pref.setString(
                                    'events', json.encode(encodeMap(_events)));
                              });
                            })
                      ],
                    )
                  : Container(),
              (currentDay.weekday <= 5)
                  ? Container(
                      padding: EdgeInsets.only(top: 24.0, bottom: 16.0),
                      child: Text(
                        "Here are the classes you missed ",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 24,
                            color: primaryColor),
                      ),
                    )
                  : Container(),
              (_selectedEvents.length != null && currentDay.weekday <= 5)
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: _selectedEvents.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 8.0),
                          child: SizedBox(
                            height: 12,
                            child: Text(
                              _selectedEvents[index] +
                                  " - " +
                                  _absents[_selectedEvents[index]].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                          ),
                        );
                      },
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
