import 'package:msbrapp/models/level.dart';

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

  Map<String, dynamic> toJson() {
    return {"name": name, "levels": level};
  }
}
