import 'package:flutter/material.dart';

class Level {
  final String name;
  final String description;
  IconData? icon;

  Level({
    required this.name,
    required this.description,
    this.icon = Icons.logo_dev_outlined,
  });

  factory Level.fromMap(Map<String, dynamic> map) {
    return Level(
      name: map["name"],
      description: map["description"]
    );
  }

  Map<String, dynamic> toMap() {
    return {"name": name, "description": description};
  }

  @override
  String toString(){
    return "$name: $description";
  }
}
