import 'package:firebase_database/firebase_database.dart';
import 'package:scp/utils/models.dart';


class ScpDatabase {
  static FirebaseDatabase database;
  static DatabaseReference counselRef = database.reference().child("slots").child('week1').child('counselor');
  static DatabaseReference psychRef = database.reference().child("slots").child('week1').child('psych');
  List<Slot> counselSlotsList = List();
  List<Slot> psychSlotsList = List();

  void init(){
    database = new FirebaseDatabase();
    counselRef = database.reference().child("slots").child('week1').child('counselor');
    counselSlotsList.clear();
    counselRef.once().then((DataSnapshot snapshot){
      int i = 1;
      while(i <= 6){
        counselRef.child('slot$i').once().then((DataSnapshot snapshot){
          counselSlotsList.add(Slot.fromSnapshot(snapshot));
        });
        i+=1;
      }
    });

    psychRef.once().then((DataSnapshot snapshot){
      int i = 1;
      while(i <= 6){
        psychRef.child('slot$i').once().then((DataSnapshot snapshot){
          psychSlotsList.add(Slot.fromSnapshot(snapshot));
        });
        i+=1;
      }
    });
  }

  /*static pushNewWeek(DatabaseReference reference) async{


    for(int i=1; i<=6; ++i){
      await reference.child('slot$i').update({
      "phoneNo" : "",
      "rollNo" : "",
      "status" : "0",
    });
     }

    //return 0;
  }*/

  void readWeekSlots(){
    print(counselSlotsList[0].phoneNo);
    print(counselSlotsList[5].status);
    print(counselSlotsList[2].rollNo);
  }
}
