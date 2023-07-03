import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationsViewModel extends BaseViewModel {
  final databaseReference = FirebaseFirestore.instance;
  List<DocumentSnapshot>? notificationList;

  void init() async {
    setBusy(true);
    notificationList = (await getData()).docs;
    setBusy(false);
  }

  Future<QuerySnapshot> getData() async {
    return await databaseReference.collection("nots").get();
  }

  launchURL(String url) async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
