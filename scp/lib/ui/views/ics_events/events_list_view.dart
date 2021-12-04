import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scp/utils/urlLauncher.dart';

class EventsListView extends StatelessWidget {
  const EventsListView({
    Key key,
    @required this.data,
  }) : super(key: key);

  final List data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final String title = data[index]['name'];
        final DateTime date = data[index]['dateTime'].toDate();
        final String venue = data[index]['venue'];
        final String link = data[index]['link'];
        return GestureDetector(
          onTap: () => launchURL(link),
          child: Container(
            child: Card(
              elevation: 7,
              shadowColor: Colors.blue,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                            SizedBox(width: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Venue',
                                  style: TextStyle(
                                    fontFamily: 'PfDin',
                                    fontWeight: FontWeight.w200,
                                    fontSize: 15,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    venue,
                                    style: TextStyle(
                                      fontFamily: 'PfDin',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
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
}
