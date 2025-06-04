import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msbrapp/components/levelCard.dart';
import 'package:msbrapp/controller/controller.dart';
import 'package:msbrapp/models/level.dart';

class LevelsScreen extends StatefulWidget {
  const LevelsScreen({super.key});

  @override
  State<LevelsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  List<Level> levels = [
    Level(
      name: "G",
      description: "Parcialmente Gerenciado",
      icon: Icons.analytics_outlined,
    ),
    Level(
      name: "F",
      description: "Gerenciado",
      icon: Icons.local_activity_outlined,
    ),
    Level(
      name: "E",
      description: "Definido",
      icon: Icons.bookmark_border_outlined,
    ),
    Level(
      name: "D",
      description: "Quantitativamente Gerenciado",
      icon: Icons.precision_manufacturing_outlined,
    ),
    Level(
      name: "C",
      description: "Em Otimização (Nível C)",
      icon: Icons.trending_up_outlined,
    ),
    Level(
      name: "B",
      description: "Em Otimização (Nível B)",
      icon: Icons.verified_outlined,
    ),
    Level(
      name: "A",
      description: "Em Avaliação",
      icon: Icons.assessment_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final ControllerLevels controller = Get.put(ControllerLevels());
    controller.levels.addAll(levels);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Niveis de Maturidade',
          style: TextStyle(fontFamily: "Metropolis-Bold", fontSize: 26),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return LevelCard(level: controller.levels[index]);
          },
          itemCount: levels.length,
        ),
      ),
    );
  }
}
