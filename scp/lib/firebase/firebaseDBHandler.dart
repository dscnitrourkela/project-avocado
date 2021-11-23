import 'package:firebase_database/firebase_database.dart';
import 'package:scp/utils/models.dart';
import 'package:flutter/foundation.dart';

class ScpDatabase {
  static FirebaseDatabase database;
  static int counselCount, psychCount;
  static DatabaseReference counselRef =
      database.reference().child("slots").child('week1').child('counselor');
  static DatabaseReference psychRef =
      database.reference().child("slots").child('week1').child('psych');
  List<Slot> counselSlotsList = [];
  List<Slot> psychSlotsList = [];

  Future<void> init() async {
    database = new FirebaseDatabase();
    counselCount = (await counselRef.child('count').once()).value;
    psychCount = (await psychRef.child('count').once()).value;
  }

  void readWeekSlots() {
    debugPrint(counselSlotsList[0].phoneNo);
    debugPrint(counselSlotsList[5].status);
    debugPrint(counselSlotsList[2].rollNo);
  }
}
