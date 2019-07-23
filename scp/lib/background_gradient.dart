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
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
Color(0xffe0c3fc),
Color(0xffc2e9fb)
          ],
        ),
      ),
    ),
  );
}
}