class FaqQuestion {
  final String question;
  final String answer;

  FaqQuestion({
    required this.question,
    required this.answer,
  });

  static FaqQuestion fromJson(json) => FaqQuestion(
        question: json['B'],
        answer: json['D'],
      );
}
