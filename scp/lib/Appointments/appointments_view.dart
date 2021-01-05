import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:scp/ui/cards.dart';
import 'package:scp/utils/routes.dart';
import 'package:stacked/stacked.dart';
import 'appointments_viewmodel.dart';
import 'package:scp/firebase/firebaseDBHandler.dart';


class AppointmentView extends StatelessWidget {
  double queryWidth;
  double textScaleFactor;

  @override
  Widget build(BuildContext context) {

    queryWidth = MediaQuery.of(context).size.width;
    textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return ViewModelBuilder<AppointmentViewModel>.reactive(
      viewModelBuilder: () => AppointmentViewModel(),
      onModelReady: (model) => model.initState(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            60.0,
          ),
          child: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
              ),
              child: Text(
                'Book your appointment',
                style: TextStyle(
                    fontSize: queryWidth * 0.065,
                    fontFamily: 'PfDin',
                    fontWeight: FontWeight.w500),
              ),
            ),
            backgroundColor: Color.fromRGBO(
              54,
              66,
              87,
              1.0,
            ),
            leading: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context);
                  Navigator.pushNamed(context, Routes.rHomepage);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            ),
            elevation: 0.0,
          ),
        ),
        body: FutureBuilder(
          future: model.setupRemoteConfig(),
          builder: (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot) {
            return Center(
              child: snapshot.hasData
                  ? appointmentScreen(context, snapshot.data,model)
                  : Center(
                    child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
      );
  }
}


Widget appointmentScreen(BuildContext context, RemoteConfig remoteConfig,AppointmentViewModel model) {


  return ListView(
      physics: AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 30.0),
      children: <Widget>[
        //anonymousButton(),
        SizedBox(
          height: 20.0,
        ),
        slotCard(context, model.counselorName, 'counsel', 'Counsellor',
            ScpDatabase.counselCount, 0.85),
        SizedBox(
          height: 40.0,
        ),
        slotCard(context, model.psychName, 'psych', 'Psychiatrist',
            ScpDatabase.psychCount, 1.1),
      ],
    );
  }


