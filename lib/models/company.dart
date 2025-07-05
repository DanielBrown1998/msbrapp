import 'package:msbrapp/models/level.dart';

class Company {
  final String name;
  List<Level>? levels;

  Company({required this.name, required level});

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      name: map["name"],
      level: List.generate(map["levels"].length, (e) {
        return Level.fromMap(map["levels"][e]);
      }),
    );
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "levels": (levels != null) ? List.generate(levels!.length, (e) {
        return levels![e].toMap();
      }): [Level(name: "G", description: "parcialmente gerenciado")]};
  }
}
