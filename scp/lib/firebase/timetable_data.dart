import 'package:cloud_firestore/cloud_firestore.dart';

class TimeTableData {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _timetable =
      _firestore.collection('timetable');
  final String section;
  final String day;

  TimeTableData(this.section, this.day);

  Stream<List<dynamic>> getStream() {
    return _timetable
        .doc(section)
        .collection(day)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<dynamic> retVal = [];
      querySnapshot.docs.forEach((doc) {
        retVal = (doc.data() as Map<String, dynamic>)['routine'];
      });
      retVal.sort((a, b) => a['index'].compareTo(b['index']));
      return retVal;
    });
  }
}
