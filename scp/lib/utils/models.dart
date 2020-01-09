import 'package:firebase_database/firebase_database.dart';

class Slot {
  String key;
  String phoneNo;
  String rollNo;
  String status;
  String time;
  String day;
  String date;

  Slot({
    this.key,
    this.phoneNo,
    this.rollNo,
    this.status,
    this.time,
    this.date,
    this.day,
  });

  Slot.map(dynamic obj){
    this.key = obj['key'];
    this.phoneNo = obj['phoneNo'];
    this.rollNo = obj['rollNo'];
    this.status = obj['status'];
    this.time = obj['time'];
    this.date = obj['date'];
    this.day = obj['day'];
  }

  Slot.fromSnapshot(DataSnapshot snapshot){
    key = snapshot.value['key'];
    phoneNo = snapshot.value['phoneNo'];
    rollNo = snapshot.value['rollNo'];
    status = snapshot.value['status'];
    time = snapshot.value['time'];
    date = snapshot.value['date'];
    day = snapshot.value['day'];
  }
}