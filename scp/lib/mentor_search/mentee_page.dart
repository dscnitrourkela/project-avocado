import 'package:flutter/material.dart';

final Color primaryColor = Color.fromARGB(255, 49, 68, 76);
final Color secondaryColor = Color.fromARGB(255, 158, 218, 224);
final Color lunchColor = Color.fromARGB(255, 238, 71, 89);

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
