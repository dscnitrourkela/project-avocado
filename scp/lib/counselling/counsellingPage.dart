// ignore_for_file: unused_field

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
  List<Map<String, String>> _CounsellingData = [
    {
      'title': 'Your Dost:',
      'description':
          'In collaboration with Your Dost, online counselling services were started in November 2021. Your Dost is a  platform for emotional support and counselling that promotes mental wellness . All the students of our institute can access this service by logging in using their Zimbra email address in the link provided below.'
    },
    {
      'title': 'Offline Counselling:',
      'description':
          'Institute recognizes the importance of one\'s mental health and has appointed a counsellor and a psychiatrist. Dr PK Nanda, is the psychiatrist and Dr Ekta Sanghi, the Counsellor under the Institute Counselling Services. While a Counselor helps people address the cause of their problems, a Psychia-trist prescribes and monitors medications to control symp-toms. Appointments can be made through the ICS app.'
    },
    {
      'title': 'tele MANAS:',
      'description':
          ' A toll free mental health helpline to provide support and assistance to people struggling with mental health issues-ref. from Ministry of Health & Family Welfare-reg.'
    }
  ];
  List<Map<String, String>> _CounsellingBanner = [
    {
      'title': 'Your Dost Counselling',
      'link': 'https://www.yourdost.com/',
      'image': 'assets/ydd.png'
    },
    {
      'title': 'tele MANAS',
      'link': 'https://telemanas.mohfw.gov.in/#/home',
      'image': 'assets/tele_manas.png',
    }
  ];

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _CounsellingData.length,
                itemBuilder: (context, index) {
                  return studentcoun_container(
                    width,
                    _CounsellingData[index]['title'].toString(),
                    _CounsellingData[index]['description'].toString(),
                  );
                }),
            SizedBox(
              height: 50,
            ),
            GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                ),
                itemCount: _CounsellingBanner.length,
                itemBuilder: (context, index) {
                  if (index + 1 == 3) {
                    return Container(
                      child: gesture_container(
                        context,
                        _CounsellingBanner[index]['link'].toString(),
                        _CounsellingBanner[index]['title'].toString(),
                        _CounsellingBanner[index]['image'].toString(),
                      ),
                    );
                  } else {
                    return Container(
                      padding: EdgeInsets.all(5),
                      child: gesture_container(
                        context,
                        _CounsellingBanner[index]['link'].toString(),
                        _CounsellingBanner[index]['title'].toString(),
                        _CounsellingBanner[index]['image'].toString(),
                      ),
                    );
                  }
                }),
            SizedBox(height: 3),
            gesture_container(
              context,
              'https://forms.gle/e8K6ZVvoNZ683ZRp6',
              'Offline Coundelling',
              'assets/icon-white.png',
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector gesture_container(
      BuildContext context, String url, String title, String image) {
    return GestureDetector(
      onTap: () {
        launchURL(url);
      },
      child: counsellingCard(title, image, MediaQuery.of(context).size.width),
    );
  }

  Column studentcoun_container(double width, String title, String description) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: width * 0.05,
            right: width * 0.05,
            left: width * 0.05,
          ),
          child: Text(
            title,
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
            description,
            style: TextStyle(
              fontSize: 16.4,
              fontWeight: FontWeight.w500,
              fontFamily: 'PfDin',
              color: Color.fromRGBO(25, 39, 45, 1),
            ),
          ),
        ),
      ],
    );
  }
}

Widget counsellingCard(
  String onTapText,
  String onTapImage,
  double width,
) {
  return Container(
    padding: EdgeInsets.all(3),
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
