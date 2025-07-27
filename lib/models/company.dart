import 'package:msbrapp/models/level.dart';
import 'dart:convert';

class Company {
  final String name;
  Level? level;

  Company({required this.name, this.level});

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      name: map["name"],
      level: map["levels"] != null ? Level.fromMap(map["levels"]) : null,
    );
  }
  static List<Company> listFromJson(String map) {
    return json
        .decode(map)
        .map<Company>((value) => Company.fromMap(value))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "levels": level};
  }
}
