import 'package:flutter/material.dart';

class FaqQuestion {
  final String question;
  final String answer;

  FaqQuestion({
    @required this.question,
    @required this.answer,
  });

  static FaqQuestion fromJson(json) => FaqQuestion(
    question: json['question'],
    answer: json['answer'],
  );
}
