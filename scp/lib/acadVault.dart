import 'package:flutter/material.dart';
import 'package:scp/ui/gradients.dart';
import 'package:scp/utils/urlLauncher.dart';

class AcadVaultPage extends StatefulWidget {
  const AcadVaultPage({key}) : super(key: key);

  @override
  State<AcadVaultPage> createState() => _AcadVaultPageState();
}

class _AcadVaultPageState extends State<AcadVaultPage> {
  final Color primaryColor = Color.fromARGB(255, 49, 68, 76);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Acad Vault",
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
              "Acad Vault:",
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
              """Acad vault is a collection of study materials, books, and notes gathered from our institute's graduates and seniors. Students who are unable to access resources because of connectivity problems or other concerns would benefit from it. The information gathered covers the majority of branches and years, but it is no way exhaustive and still a work in progress.

Please complete this access request if you would like access to the content. Given email address must be of a Gmail account. There is a daily cap of 100 requests that can be processed, so please resubmit the request within 24 hours if the material is not added to your Google Drive within that time. Once processed, the file can be accessible under your Drive's Shared with Me section.

We thank the graduates and senior students for their efforts in making this initiative possible. Good Luck!""",
              style: TextStyle(
                fontSize: 16.4,
                fontWeight: FontWeight.w500,
                fontFamily: 'PfDin',
                color: Color.fromRGBO(25, 39, 45, 1),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              launchURL("https://forms.gle/cjtmYB3xWUEKyBK26");
            },
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: width * 0.15,
              margin: EdgeInsets.symmetric(horizontal: width*0.13, vertical: width*0.12),
              decoration: BoxDecoration(
                gradient: Gradients.appointmentCardGradient,
                borderRadius: BorderRadius.circular(width * 0.075),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38, //New
                      blurRadius: 20.0,
                      offset: Offset(0, 5))
                ],
              ),
              child: Center(
                child: Text(
                  "Request Access",
                  style: TextStyle(
                      fontFamily: 'PfDin',
                      fontSize: width * 0.058,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
