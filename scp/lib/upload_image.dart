import 'dart:io';
import 'package:flutter/material.dart';
import 'package:scp/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:scp/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scp/dateConfig.dart';
import 'package:scp/firebase/firebaseDBHandler.dart';
import 'package:scp/booking.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadImageScreen extends StatefulWidget {
  final String counselDay;
  final String date;
  final String type;
  final String time;
  final String bookingKey;
  final String index;

  UploadImageScreen(
      {this.bookingKey,
      this.time,
      this.type,
      this.date,
      this.counselDay,
      this.index});

  @override
  UploadImageState createState() => UploadImageState();
}

class UploadImageState extends State<UploadImageScreen> {
  GlobalKey<ScaffoldState> _scafoldKey = new GlobalKey();
  double queryWidth;
  String imagePath = "";
  bool validImage = false;
  bool uploading = false;

  void setValidImage() {
    setState(() {
      validImage = true;
    });
  }

  void bookAppointment(BuildContext context, String key) async {
    print(widget.counselDay);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var rollNo = prefs.getString('roll_no');
    var phoneNo = prefs.getString('phone_no');
    //prefs.setString('counselPsychDay', counselDay);
    prefs.setBool('hasBooked', true);
    prefs.setString('bookedDate', widget.date);
    prefs.setString('bookingType', widget.type);
    prefs.setString(
        'bookDate',
        ((widget.type == "psych")
            ? DateConfig.psychDate.toString()
            : DateConfig.counselDate.toString()));
    print(DateConfig.bookedDate.toString());
    prefs.setString('bookedTime', widget.time);
    prefs.setString('bookedSlot', "slot${widget.index}");

    var reference = (widget.type == "psych")
        ? ScpDatabase.psychRef
        : ScpDatabase.counselRef;

    setState(() {
      uploading = true;
    });

    Reference ref =
        FirebaseStorage.instance.ref().child(widget.type + "$key.jpg");
    UploadTask uploadTask = ref.putFile(File(imagePath));

    var futureUrl = uploadTask.snapshot.ref.getDownloadURL();

    String imageUrl;

    await futureUrl.then((url) {
      imageUrl = url;
    });

    await reference.child(key).update({
      "phoneNo": phoneNo,
      "rollNo": rollNo,
      "status": "1",
      "idImage": imageUrl,
    }).then((_) {
      print("Value updated");
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => Booking(
                  counselDay: widget.counselDay,
                  time: widget.time,
                )),
        /*ModalRoute.withName('/appointments')*/
      );
      //Navigator.push(context, MaterialPageRoute(
      //  builder: (BuildContext context) =>
      //    Booking(keyCode: key, counselDay: widget.counselDay, time: widget.time)));
    });

    setState(() {
      uploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    queryWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scafoldKey,
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
              'Book your appointment',
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
            child: IconButton(
              onPressed: () {
                Navigator.of(context);
                Navigator.pushNamed(context, Routes.rAppointments);
              },
              icon: Icon(
                Icons.arrow_back_ios,
              ),
            ),
          ),
          elevation: 0.0,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Booking',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'PfDin',
              fontSize: MediaQuery.of(context).size.width * 0.052,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${widget.counselDay} | ${widget.date} | ${widget.time}',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'PfDin',
                fontSize: MediaQuery.of(context).size.width * 0.038,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Wrap(
                children: <Widget>[
                  Text(
                    'Upload image of ID card',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'PfDin',
                        fontSize: MediaQuery.of(context).size.width * 0.052,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(0),
            ),
            onPressed: () async {
              if (validImage) {
                var file = File(imagePath);
                file.delete();

                setState(() {
                  validImage = false;
                });
              }

              // Construct the path where the image should be saved using the
              // pattern package.
              final path = join(
                // Store the picture in the temp directory.
                // Find the temp directory using the `path_provider` plugin.
                (await getTemporaryDirectory()).path,
                '${DateTime.now()}.png',
              );

              uploadImage(context, path, setValidImage);

              imagePath = path;
            },
            child: validImage
                ? Container(
                    height: 120,
                    width: 120,
                    child: Image.file(
                      File(imagePath),
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    height: 120,
                    width: 120,
                    child: Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.grey,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: !uploading
                    ? Color.fromRGBO(54, 66, 87, 1.0)
                    : Color.fromRGBO(164, 176, 197, 1.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                onPrimary: Colors.white,
              ),
              onPressed: () {
                if (!validImage) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('First upload an image')));
                } else if (!uploading) {
                  bookAppointment(context, widget.bookingKey);
                }
              },
              child: !uploading ? Text('Upload and Book') : Text('Uploading'),
            ),
          ),
        ],
      ),
    );
  }
}
