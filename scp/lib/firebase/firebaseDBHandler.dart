import 'package:firebase_database/firebase_database.dart';
import 'package:scp/models.dart';
import 'package:scp/appointments.dart';

class ScpDatabase {
  static FirebaseDatabase database;
  static DatabaseReference slotsRef;
  List<Slot> slotsList = List();

  void init(){
    database = new FirebaseDatabase();
    slotsRef = database.reference().child("slots").child('week1').child('counselor');
    slotsList.clear();
    slotsRef.once().then((DataSnapshot snapshot){
      int i = 1;
      while(i <= 6){
        slotsRef.child('slot$i').once().then((DataSnapshot snapshot){
          slotsList.add(Slot.fromSnapshot(snapshot));
        });
        i+=1;
      }
    });
  }

  void readWeekSlots(){
    print(slotsList[0].phoneNo);
    print(slotsList[5].status);
    print(slotsList[2].rollNo);
  }
}
