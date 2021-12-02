import 'package:flutter/material.dart';

class Mentors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 39, 45, 1),
        title: Text(
          "Mentors",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'PfDin',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Text(
          "Coming Soon",
          style: TextStyle(fontFamily: 'PfDin', fontSize: 30),
        ),
      ),
    );
  }
}
