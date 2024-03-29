import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scp/drawer_screens/notifications/notifications_viewmodel.dart';
import 'package:scp/widgets/info_card.dart';
import 'package:stacked/stacked.dart';

class Nots extends StatefulWidget {
  @override
  _Nots createState() => _Nots();
}

class _Nots extends State<Nots> {
  final databaseReference = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 39, 45, 1),
        title: Text(
          "Notifications",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'PfDin',
              fontWeight: FontWeight.w600),
        ),
      ),
      body: ViewModelBuilder.reactive(
        builder: (context, NotificationsViewModel? model, child) {
          if (model!.isBusy) {
            return Center(child: CircularProgressIndicator());
          } else
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: model.notificationList!.length,
              itemBuilder: (context, index) {
                return InfoCard(model.notificationList![index], model);
              },
            );
        },
        viewModelBuilder: () => NotificationsViewModel(),
        onViewModelReady: (NotificationsViewModel model) => model.init(),
      ),
    );
  }
}
