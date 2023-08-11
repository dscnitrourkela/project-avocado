import 'package:cloud_firestore/cloud_firestore.dart';

class PeriodDetails {
  String? name;
  String? slotTime;
  GeoPoint? location;
  int? slotLength;
  String? type;
  String? locationName;

  PeriodDetails(
      {this.name,
      this.slotTime,
      this.location,
      this.locationName,
      this.slotLength,
      this.type});
}
