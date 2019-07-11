import 'package:firebase_database/firebase_database.dart';

class ScpDatabase {
  static FirebaseDatabase database;
  static DatabaseReference _userRef;

  void init() {
    database = new FirebaseDatabase();
    _userRef = database.reference().child('users');
  }

  static void createRecord() {
    _userRef.child("1").set({
      'title': 'Mastering EJB',
      'description': 'Programming Guide for J2EE'
    });
    _userRef.child("2").set({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });
  }

  static void updateData() {
    _userRef.child('1').update({'description': 'J2EE complete Reference'});
  }

  static void deleteData() {
    _userRef.child('1').remove();
  }
}
