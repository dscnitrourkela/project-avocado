import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:scp/FAQ/models/faq_model.dart';

// import 'package:scp/utils/models.dart';
//
// class ScpDatabase {
//   static FirebaseDatabase database;
//   static int counselCount, psychCount;
//   static DatabaseReference counselRef =
//       database.reference().child("slots").child('week1').child('counselor');
//   static DatabaseReference psychRef =
//       database.reference().child("slots").child('week1').child('psych');
//   List<Slot> counselSlotsList = [];
//   List<Slot> psychSlotsList = [];
//
//   Future<void> init() async {
//     database = new FirebaseDatabase();
//     counselCount = (await counselRef.child('count').once()).value;
//     psychCount = (await psychRef.child('count').once()).value;
//   }
//
//   void readWeekSlots() {
//     debugPrint(counselSlotsList[0].phoneNo.toString());
//     debugPrint(counselSlotsList[5].status.toString());
//     debugPrint(counselSlotsList[2].rollNo.toString());
//   }
// }

class FAQDatabase {
  final CollectionReference faqCollection =
      FirebaseFirestore.instance.collection('faq');

  List<faqModels> brewlistfromasnapshots(QuerySnapshot Snapshot) {
    return Snapshot.docs.map(
      (e) {
        return faqModels(
          id: e['A'] ?? '0',
          catagory: e['C'] ?? 'Unknown Category',
          question: e['B'] ?? 'Unknown Question',
          answer: e['D'] ?? 'No answer available.',
        );
      },
    ).toList();
  }

  Stream<List<faqModels>> get faqfun {
    return faqCollection.snapshots().map(brewlistfromasnapshots);
  }

  Future<void> uploadData() async {
    String jsonString = await rootBundle.loadString('assets/data/faqData.json');
    List<dynamic> jsonList = json.decode(jsonString);

    jsonList.forEach((data) {
      faqCollection.add(data);
    });
  }
}
