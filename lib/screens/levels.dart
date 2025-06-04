import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msbrapp/components/levelCard.dart';
import 'package:msbrapp/controller/controller.dart';

class LevelsScreen extends StatefulWidget {
  const LevelsScreen({super.key});

  @override
  State<LevelsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  late ControllerLevels controller;
  @override
  void initState() {
    controller = Get.find<ControllerLevels>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        leading: null,
        centerTitle: true,
        title: const Text(
          'Niveis de Maturidade',
          style: TextStyle(
            fontFamily: "Edu",
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: controller.allLevels.length,
          itemBuilder: (context, index) {
            return Obx(() => LevelCard(level: controller.allLevels[index]));
          },
        ),
      ),
    );
  }
}
