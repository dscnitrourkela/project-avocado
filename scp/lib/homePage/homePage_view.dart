import 'package:flutter/material.dart';
import 'package:scp/utils/chatArgs.dart';
import 'package:scp/utils/routes.dart';
import 'package:scp/utils/sizeConfig.dart';
import 'package:scp/timetablecardsplit.dart';
import 'package:scp/ui/cards.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stacked/stacked.dart';
import 'homePage_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(DateTime.now().weekday);
    print(DateTime.now().hour);
    SizeConfig().init(context);
    FirebaseDatabase.instance.setPersistenceEnabled(true);

    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.initState(context),
      builder: (context, model, child) => Scaffold(
        body: FutureBuilder(
          future: model.fetchUserData(context),
          builder: (context, snap) {
            model.checkUpdate(context);
            return Scaffold(
              key: model.scaffoldKey,
              drawer: Drawer(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  DrawerHeader(
                      child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        model.username,
                        style: TextStyle(
                            fontSize: SizeConfig.screenWidth * 0.058,
                            fontFamily: 'PfDin'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          model.phoneNo,
                          style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.035,
                              fontFamily: 'PfDin'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          model.rollNo,
                          style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.035,
                              fontFamily: 'PfDin'),
                        ),
                      )
                    ],
                  )),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(Routes.rImpDocs);
                          },
                          title: Text(
                            "Important Documents",
                            style: TextStyle(
                                fontSize: SizeConfig.drawerItemTextSize,
                                fontFamily: 'PfDin'),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.rNots);
                          },
                          title: Text(
                            "Notifications",
                            style: TextStyle(
                                fontSize: SizeConfig.drawerItemTextSize,
                                fontFamily: 'PfDin'),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(Routes.rSettings);
                          },
                          title: Text(
                            "Settings",
                            style: TextStyle(
                                fontSize: SizeConfig.drawerItemTextSize,
                                fontFamily: 'PfDin'),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.rAboutScp);
                          },
                          title: Text(
                            "About ICS",
                            style: TextStyle(
                                fontSize: SizeConfig.drawerItemTextSize,
                                fontFamily: 'PfDin'),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            model.launchURL();
                          },
                          title: Text(
                            "Privacy Policy",
                            style: TextStyle(
                                fontSize: SizeConfig.drawerItemTextSize,
                                fontFamily: 'PfDin'),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(Routes.rDevInfo);
                          },
                          title: Text(
                            "Developer Info",
                            style: TextStyle(
                                fontSize: SizeConfig.drawerItemTextSize,
                                fontFamily: 'PfDin'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.center,
                        child: ButtonTheme(
                          minWidth: SizeConfig.screenWidth * 0.463,
                          height: SizeConfig.screenWidth * 0.093,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            color: Color.fromRGBO(25, 39, 45, 1),
                            onPressed: () {
                              model.removeUserData(context);
                            },
                            child: Text(
                              "Log Out",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'PfDin',
                                  color: Colors.white,
                                  fontSize: SizeConfig.screenWidth * 0.046),
                            ),
                          ),
                        ),
                      ))
                ],
              )),
              appBar: AppBar(
                leading: Padding(
                  padding: EdgeInsets.only(top: SizeConfig.screenWidth * 0.037),
                  child: IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                        size: 35.0,
                      ),
                      onPressed: () =>
                          model.scaffoldKey.currentState.openDrawer()),
                ),
                actions: <Widget>[
                  (snap.connectionState != ConnectionState.waiting ||
                          snap.connectionState != ConnectionState.waiting)
                      ? (model.isChat
                          ? IconButton(
                              padding: EdgeInsets.only(
                                  top: SizeConfig.screenWidth * 0.048,
                                  right: SizeConfig.screenWidth * 0.06),
                              icon: Icon(
                                Icons.chat,
                                color: Colors.black,
                                size: 35.0,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.rChat,
                                    arguments: ChatArguments(model.chatUrl));
                              },
                            )
                          : Container())
                      : Container(),
                ],
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
                title: Padding(
                  padding: EdgeInsets.only(top: SizeConfig.screenWidth * 0.037),
                  child: Text(
                    'ICS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'PfDin',
                        letterSpacing: 2),
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: (snap.connectionState == ConnectionState.done)
                    ? ListView(
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          appointmentCard(context),
                          TimetableCardSplit(
                              context,
                              MediaQuery.of(context).size.width,
                              MediaQuery.of(context).textScaleFactor),
                          faqCard(context),
                          mentorsCard(context, model.rollNo)
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
