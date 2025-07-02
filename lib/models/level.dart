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

  Map<String, dynamic> toJson() {
    return {"name": name, "description": description, "icon": icon};
  }
}
