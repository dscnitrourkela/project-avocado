import 'package:flutter/material.dart';
import 'package:scp/ui/gradients.dart';
import 'package:scp/utils/urlLauncher.dart';

class CounsellingPage extends StatefulWidget {
  const CounsellingPage({key}) : super(key: key);

  @override
  State<CounsellingPage> createState() => _CounsellingPageState();
}

class _CounsellingPageState extends State<CounsellingPage> {
  final Color primaryColor = Color.fromARGB(255, 49, 68, 76);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Student Counselling",
          style: TextStyle(fontFamily: 'PfDin', fontSize: 22),
        ),
        backgroundColor: primaryColor,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: width * 0.05,
              right: width * 0.05,
              left: width * 0.05,
            ),
            child: Text(
              "Your Dost:",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                fontFamily: 'PfDin',
                color: Color.fromRGBO(74, 232, 190, 1),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: width * 0.024,
              right: width * 0.05,
              left: width * 0.05,
            ),
            child: Text(
              "In collaboration with Your Dost, online counselling services were started in November 2021. Your Dost is a  platform for emotional support and counselling that promotes mental wellness . All the students of our institute can access this service by logging in using their Zimbra email address in the link provided below.",
              style: TextStyle(
                fontSize: 16.4,
                fontWeight: FontWeight.w500,
                fontFamily: 'PfDin',
                color: Color.fromRGBO(25, 39, 45, 1),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: width * 0.05,
              right: width * 0.05,
              left: width * 0.05,
            ),
            child: Text(
              "Offline Counselling:",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                fontFamily: 'PfDin',
                color: Color.fromRGBO(74, 232, 190, 1),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: width * 0.024,
              right: width * 0.05,
              left: width * 0.05,
            ),
            child: Text(
              "Institute recognizes the importance of one's mental health and has appointed a counsellor and a psychiatrist. Dr PK Nanda, is the psychiatrist and Dr Ekta Sanghi, the Counsellor under the Institute Counselling Services. While a Counselor helps people address the cause of their problems, a Psychia-trist prescribes and monitors medications to control symp-toms. Appointments can be made through the ICS app.",
              style: TextStyle(
                fontSize: 16.4,
                fontWeight: FontWeight.w500,
                fontFamily: 'PfDin',
                color: Color.fromRGBO(25, 39, 45, 1),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  launchURL("https://www.yourdost.com/");
                },
                child: counsellingCard("YourDOST Counselling", 'assets/ydd.png',
                    MediaQuery.of(context).size.width),
              ),
              GestureDetector(
                onTap: () {
                  launchURL("https://forms.gle/e8K6ZVvoNZ683ZRp6");
                },
                child: counsellingCard("OFFLINE Counselling",
                    'assets/icon-white.png', MediaQuery.of(context).size.width),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

Widget counsellingCard(
  String onTapText,
  String onTapImage,
  double width,
) {
  return Container(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    height: width * 0.4,
    width: width * 0.4,
    decoration: BoxDecoration(
      gradient: Gradients.appointmentCardGradient,
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
            color: Colors.black38, //New
            blurRadius: 20.0,
            offset: Offset(0, 5))
      ],
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.037),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Image.asset(
              onTapImage,
              width: width * 0.138,
              height: width * 0.138,
              fit: BoxFit.fill,
              alignment: Alignment.topCenter,
              colorBlendMode: BlendMode.color,
            ),
          ),
          Text(
            onTapText,
            style: TextStyle(
                fontFamily: 'PfDin',
                fontSize: width * 0.058,
                color: Colors.white,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
