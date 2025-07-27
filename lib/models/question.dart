import 'dart:convert';

class Question {
  final String id;
  final String question;
  final List<String> options;
  final int answer;
  int choice = -1;
  List<dynamic> colors = [];

  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.answer,
  });

  static List<Question> listFromJson(String map) {
    List<dynamic> list = json.decode(map)["questions"];
    list = list.first["characteristics"];
    return list.map<Question>((value) => Question.fromJson(value)).toList();
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options']),
      answer: json['answer'],
    );
  }
}
