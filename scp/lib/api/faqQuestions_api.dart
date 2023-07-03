import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scp/datamodels/faqQuestion.dart';

class FaqQuestionApi {
  static Future<List<FaqQuestion>> getFaqQuestionLocally(
      BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/data/faqData.json');
    final body = json.decode(data);

    return body.map<FaqQuestion>(FaqQuestion.fromJson).toList();
  }
}
