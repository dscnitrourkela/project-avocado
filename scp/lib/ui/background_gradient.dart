import 'package:flutter/material.dart';

class BackgroundGrad extends StatelessWidget {
 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      height: double.infinity,
      width:double.infinity,
      // Add box decoration
      decoration: BoxDecoration(
        // Box decoration takes a gradient
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.3,0.8],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            /*Color(0xffd9a7c7),
            Color(0xfffffcdc),*/
            Colors.white,
            Color.fromRGBO(74, 232, 190, 1),
          ],
        ),
      ),
    ),
  );
}
}