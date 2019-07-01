import 'package:flutter/material.dart';

class Gradients {
  static LinearGradient appointmentCardGradient;

  static LinearGradient appointmentCardGradient2;
  static LinearGradient faqCardGradient;
  static LinearGradient mentorsCardGradient;

  void init(BuildContext context) {
    appointmentCardGradient = LinearGradient(colors: [
      Color.fromRGBO(107, 195, 145, 1.0),
      Color.fromRGBO(8, 121, 191, 1.0),
    ], begin: Alignment.topRight, end: Alignment.bottomLeft);

    faqCardGradient = LinearGradient(colors: [
      Color.fromRGBO(48, 72, 142, 1.0),
      Color.fromRGBO(0, 173, 239, 1.0),
    ], begin: Alignment.centerLeft, end: Alignment.centerRight);

    mentorsCardGradient = LinearGradient(colors: [
      Color.fromRGBO(142, 40, 142, 1.0),
      Color.fromRGBO(36, 34, 97, 1.0),
    ], begin: Alignment.bottomLeft, end: Alignment.topRight,);
  }
}
