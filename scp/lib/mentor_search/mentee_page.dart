import 'package:flutter/material.dart';

class ListDetails extends StatefulWidget {
  final String text;

  ListDetails(this.text);

  @override
  _ListDetailsState createState() => _ListDetailsState();
}

class _ListDetailsState extends State<ListDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Mentee Page"),
      ),
    );
  }
}
