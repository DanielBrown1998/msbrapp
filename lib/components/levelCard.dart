import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msbrapp/controller/controller.dart';
import 'package:msbrapp/models/level.dart';
import 'package:msbrapp/screens/questions.dart';

class LevelCard extends StatelessWidget {
  final Level level;

  const LevelCard({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    final ControllerLevel controllerLevel = Get.put(
      ControllerLevel(),
      tag: level.name,
    );
    controllerLevel.level.value = level.name;
    return Obx(
      () => Card(
        color:
            controllerLevel.aproved.value
                ? Colors.green
                : const Color.fromARGB(235, 235, 235, 235),
        child: ListTile(
          onTap: () {
            Get.to(QuestionsScreen(level: level.name));
          },
          leading: Icon(level.icon, size: 80),
          title: Text(
            level.name,
            style: TextStyle(fontSize: 40, fontFamily: "DancingScript"),
          ),
          subtitle: Text(
            level.description,
            style: TextStyle(fontSize: 20, fontFamily: "Edu"),
          ),
          enabled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(2, 1)),
          ),
        ),
      ),
    );
  }
}
