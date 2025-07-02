import 'package:msbrapp/models/level.dart';

class Company {
  final String name;
  List<Level>? levels;

  Company({required this.name, required level});

  Map<String, dynamic> toJson() {
    return {"name": name, "levels": (levels != null) ? levels!.last.name : "G"};
  }
}
