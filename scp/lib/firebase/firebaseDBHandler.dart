import 'package:firebase_database/firebase_database.dart';
import 'package:scp/utils/models.dart';

class ScpDatabase {
  static FirebaseDatabase database;
  static int counselCount, psychCount;
  static DatabaseReference counselRef =
      database.reference().child("slots").child('week1').child('counselor');
  static DatabaseReference psychRef =
      database.reference().child("slots").child('week1').child('psych');
  List<Slot> counselSlotsList = List();
  List<Slot> psychSlotsList = List();

  void init() async {
    database = new FirebaseDatabase();
    counselCount = (await counselRef.child('count').once()).value;
    psychCount = (await psychRef.child('count').once()).value;
  }

  void readWeekSlots() {
    print(counselSlotsList[0].phoneNo);
    print(counselSlotsList[5].status);
    print(counselSlotsList[2].rollNo);
  }
}
