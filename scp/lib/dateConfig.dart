//import 'package:intl/intl.dart';

class DateConfig{

  static DateTime bookedDate;
  static DateTime counselDate;
  static DateTime psychDate;

  void init(){

    DateTime now = DateTime.now();
    bookedDate = now;
    while(now.weekday != 3){
      now = now.add(Duration(days: 1));
    }
    counselDate = now.subtract(Duration(days: 1));
    psychDate = now;
  }

  static DateTime getBookedDate(){
      return bookedDate;
  }
}