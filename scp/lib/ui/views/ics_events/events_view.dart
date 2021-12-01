import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scp/ui/dsc_social.dart';

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
          child: FutureBuilder(
            future: events.orderBy('dateTime').get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List data = snapshot.data.docs as List;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final String title = data[index]['name'];
                    final DateTime date = data[index]['dateTime'].toDate();
                    final String venue = data[index]['venue'];
                    String link = '#';
                    link ?? data[index]['link'];
                    return GestureDetector(
                      onTap: () => launchURL(link),
                      child: Container(
                        child: Card(
                          elevation: 7,
                          shadowColor: Colors.blue,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.calendar,
                                  size: 50,
                                ),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: TextStyle(
                                        fontFamily: 'PfDin',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Date',
                                              style: TextStyle(
                                                fontFamily: 'PfDin',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}',
                                              style: TextStyle(
                                                fontFamily: 'PfDin',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 40),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Time',
                                              style: TextStyle(
                                                fontFamily: 'PfDin',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}',
                                              style: TextStyle(
                                                fontFamily: 'PfDin',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 40),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Venue',
                                              style: TextStyle(
                                                fontFamily: 'PfDin',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              venue,
                                              style: TextStyle(
                                                fontFamily: 'PfDin',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }

              if (!snapshot.hasData) {
                return Center(
                  child: Text('No upcoming Events'),
                );
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
