import 'package:flutter/material.dart';
import 'package:link_text/link_text.dart';
import 'package:scp/datamodels/faqQuestion.dart';
import 'package:scp/utils/urlLauncher.dart';

import 'api/faqQuestions_api.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({key}) : super(key: key);

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 49, 68, 76),
        title: Text(
          "FAQ",
          style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontFamily: 'PfDin',
              fontWeight: FontWeight.w600),
        ),
      ),
      body: FutureBuilder<List<FaqQuestion>>(
          future: FaqQuestionApi.getFaqQuestionLocally(context),
          builder: (context, snapshot) {
            final faqQuestion = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Oops! Something Went Wrong",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'PfDin',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  return buildFaqQuestion(faqQuestion!);
                }
            }
          }),
    );
  }

  Widget buildFaqQuestion(List<FaqQuestion> faqQuestion) => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: faqQuestion.length,
        itemBuilder: (context, index) {
          final singlefaqquestion = faqQuestion[index];
          return Padding(
            padding: EdgeInsets.only(left: 16, top: 15.5, right: 16),
            child: Material(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 5,
              borderRadius: BorderRadius.circular(11),
              child: Theme(
                data: ThemeData(
                  primarySwatch: Colors.blueGrey,
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  title: Padding(
                    padding: EdgeInsets.symmetric(vertical: 7),
                    child: Text(
                      singlefaqquestion.question,
                      style: TextStyle(
                          fontSize: 18.5,
                          fontFamily: 'PfDin',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          top: 4.0,
                        ),
                        child: LinkText(singlefaqquestion.answer,
                            textStyle: TextStyle(
                                fontSize: 16.6,
                                fontFamily: 'PfDin',
                                color: Colors.black38),
                            linkStyle: TextStyle(
                                color: Colors.blueAccent,
                                decoration: TextDecoration.underline,
                                fontSize: 15.3), onLinkTap: ((url) {
                          launchURL(url);
                        })),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        },
      );
}
