class faqModels {
  faqModels({
    required this.id,
    required this.catagory,
    required this.question,
    required this.answer,
  });
  final String id;
  final String catagory;
  final String question;
  final String answer;

  // factory faqModels.fromJson(Map<String, dynamic> json) => faqModels(
  //       id: json['id'],
  //       catagory: json['catagory'],
  //       question: json['question'],
  //       answer: json['answer'],
  //     );
}
