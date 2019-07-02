import 'package:flutter/material.dart';
import 'time_table_resources.dart';

class TimeTable extends StatefulWidget {
  @override
  TimeTableState createState() => new TimeTableState();
}

class TimeTableState extends State<TimeTable> {
  String theorySection = 'A';
  String practicalSection = 'P1';
  bool showTimeTable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              DropdownButton<String>(
                value: theorySection,
                onChanged: (String newValue) {
                  setState(() {
                    theorySection = newValue;
                    print(theorySection);
                  });
                },
                hint: Text('Theory Section'),
                items: <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                    child: Text('A'),
                    value: 'A',
                  ),
                  DropdownMenuItem(
                    child: Text('B'),
                    value: 'B',
                  ),
                  DropdownMenuItem(
                    child: Text('C'),
                    value: 'C',
                  ),
                  DropdownMenuItem(
                    child: Text('D'),
                    value: 'D',
                  ),
                ],
              ),
              DropdownButton<String>(
                value: practicalSection,
                onChanged: (String newValue) {
                  setState(() {
                    practicalSection = newValue;
                    print(practicalSection);
                  });
                },
                hint: Text('Pratical Section'),
                items: <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                    child: Text('P1'),
                    value: 'P1',
                  ),
                  DropdownMenuItem(
                    child: Text('P2'),
                    value: 'P2',
                  ),
                  DropdownMenuItem(
                    child: Text('P3'),
                    value: 'P3',
                  ),
                  DropdownMenuItem(
                    child: Text('P4'),
                    value: 'P4',
                  ),
                  DropdownMenuItem(
                    child: Text('P5'),
                    value: 'P5',
                  ),
                ],
              ),
              RaisedButton(
                color: Colors.green,
                child: Text(
                  'Build',
                ),
                onPressed: () {
                  print(
                      "TheorySection: $theorySection, PraticalSection: $practicalSection");
                  setState(() {
                    showTimeTable = true;
                  });
                },
              ),
            ],
          ),
          buildTimeTable(context),
        ],
      ),
    );
  }

  TableRow buildTableRow(String day, List<String> codes, double width) {
    List<Widget> slots = new List<Widget>();

    for (int i = 0; i < 9; i++) {
      if (TimeTableResources.theory[theorySection].containsKey(codes[i])) {
        slots.add(new Container(
          width: width/9,
          child: Text(TimeTableResources.theory[theorySection][codes[i]]),
          decoration: BoxDecoration(
            color: Colors.lightBlue[100],
            border: Border.all(color: Colors.black),
          ),
        ));
      } else if (TimeTableResources.practical[practicalSection]
          .containsKey(codes[i])) {
        slots.add(new Container(
          width: (width/9)*3,
          child: Text(TimeTableResources.practical[practicalSection][codes[i]]),
          decoration: BoxDecoration(
            color: Colors.yellow[100],
            border: Border.all(color: Colors.black),
          ),
        ));
        slots.add(new Container(
          width: 0.0,
        ));
        slots.add(new Container(
          width: 0.0,
        ));
        i += 2;
      } else {
        slots.add(new Container(
          width: width/9,
        ));
      }
    }

    return TableRow(
      children: slots,
    );
  }

  Widget buildTimeTable(BuildContext context) {
    if (showTimeTable == false) {
      return Text('First build time table');
    } else {
      List<TableRow> dayRows = [];

      TimeTableResources.tpSequence.forEach((key, value) {
        dayRows
            .add(buildTableRow(key, value, MediaQuery.of(context).size.width));
      });

      return Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: dayRows,
      );
    }
  }
}
