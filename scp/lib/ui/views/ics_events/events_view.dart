import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scp/ui/views/ics_events/events_list_view.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference events =
        FirebaseFirestore.instance.collection('events');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(25, 39, 45, 1),
          title: Text(
            'ICS Events',
            style: TextStyle(fontFamily: 'PfDin'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  'Upcoming Events',
                  style: TextStyle(
                    fontFamily: 'PfDin',
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 10),
                FutureBuilder(
                  future: events
                      .orderBy('dateTime', descending: true)
                      .where('dateTime',
                          isGreaterThanOrEqualTo: new DateTime.now())
                      .get(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text('No Upcoming Events'),
                      );
                    }

                    if (snapshot.hasData) {
                      List data = snapshot.data.docs as List;
                      if (data.length == 0) {
                        return Center(
                          child: Text('No Upcoming Events'),
                        );
                      }
                      return EventsListView(data: data);
                    }

                    return CircularProgressIndicator();
                  },
                ),
                SizedBox(height: 10),
                Text(
                  'Past Events',
                  style: TextStyle(
                    fontFamily: 'PfDin',
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 10),
                FutureBuilder(
                  future: events
                      .orderBy('dateTime', descending: true)
                      .where('dateTime', isLessThan: new DateTime.now())
                      .get(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List data = snapshot.data.docs as List;
                      if (data.length == 0) {
                        return Center(
                          child: Text('No Upcoming Events'),
                        );
                      }
                      return EventsListView(data: data);
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    return Center(
                      child: Text('No Past Events'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
