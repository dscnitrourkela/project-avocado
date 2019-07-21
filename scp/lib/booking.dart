import 'package:flutter/material.dart';

class Booking extends StatefulWidget {
  final String keyCode;

  Booking({@required this.keyCode});

  @override
  _BookingState createState() => _BookingState(keyCode: keyCode);
}

class _BookingState extends State<Booking> {
  final String keyCode;
  double queryWidth;
  _BookingState({@required this.keyCode});

  @override
  Widget build(BuildContext context) {

    queryWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          60.0,
        ),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
            ),
            child: Text(
              'Confirmation',
              style: TextStyle(
                  fontSize: queryWidth * 0.065,
                  fontFamily: 'PfDin',
                  fontWeight: FontWeight.w500),
            ),
          ),
          backgroundColor: Color.fromRGBO(
            54,
            66,
            87,
            1.0,
          ),
          leading: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Icon(
              Icons.arrow_back_ios,
            ),
          ),
          elevation: 0.0,
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Your Appointment with',style: TextStyle(
                color: Colors.cyan,
                fontFamily: 'PfDin',
                fontSize: queryWidth * 0.060,
              ),),
              SizedBox(height: 20.0,),
              Text('Dr. John Doe',style: TextStyle(
                color: Colors.black,
                fontSize: queryWidth * 0.12,
                fontWeight: FontWeight.bold,
                fontFamily: 'PfDin',
              ),),
              SizedBox(height: 20.0,),
              Text('has been booked on',style: TextStyle(
                color: Colors.cyan,
                fontFamily: 'PfDin',
                fontSize: queryWidth * 0.050,
              ),),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
