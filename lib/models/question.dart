import 'package:flutter/material.dart';

class Question {
  final String id;
  final String question;
  final List<String> options;
  final int answer;
  int choice = -1;
  Color color = Colors.white;


  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.answer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options']),
      answer: json['answer'],
    );
  }
}
