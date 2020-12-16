import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scp/drawer_screens/notifications/notifications_viewmodel.dart';
import 'package:scp/utils/sizeConfig.dart';

class InfoCard extends StatelessWidget {
  DocumentSnapshot f;
  NotificationsViewModel model;
  InfoCard(this.f, this.model);
  var textScaleFactor = SizeConfig.drawerItemTextSize * 0.05;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    f.data['title'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: textScaleFactor * 20,
                        fontFamily: 'PfDin',
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Center(
                    child: Text(
                  f.data['description'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: textScaleFactor * 15,
                      fontFamily: 'PfDin',
                      fontWeight: FontWeight.w500),
                )),
                Center(
                  child: InkWell(
                      onTap: () {
                        if (f.data['link'] != null)
                          model.launchURL((f.data['link']));
                      },
                      child: Text(
                        f.data['link'] == null ? "" : f.data['link'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: textScaleFactor * 15,
                          fontFamily: 'PfDin',
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
