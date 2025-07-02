import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msbrapp/controller/controller.dart';
import 'package:msbrapp/screens/levels.dart';

class AnswerQuestionButton extends StatelessWidget {
  final ControllerLevel controllerLevel;
  final ControllerLevels controllerLevels;
  final String level;
  const AnswerQuestionButton({
    super.key,
    required this.level,
    required this.controllerLevel,
    required this.controllerLevels,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (controllerLevel.answers.contains(-1)) {
          Get.snackbar(
            "Erro",
            'Responda todas as perguntas',
            duration: Duration(seconds: 3),
            backgroundColor: Colors.yellow,
            colorText: Colors.white,
          );
        } else {
          // soma todas as escolhas
          double sum = controllerLevel.choices.reduce((a, b) => a + b);
          // calcula o percentual
          double percent = (sum / controllerLevel.choices.length) * 100;
          if (percent >= 75) {
            //variavel de controle para checar se foi aprovado
            controllerLevel.aproved.value = true;
            //add no controle de niveis para validar a aprovacao no levels
            controllerLevels.levels.add(level);
            Get.snackbar(
              "Possivelmente sera Aprovado",
              "${percent.toStringAsFixed(2)}% de aproveitamento}",
              duration: Duration(seconds: 5),
              backgroundColor: Colors.green,
              colorText: Colors.white,
              icon: Icon(Icons.check, color: Colors.white),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            Get.snackbar(
              "Possivelmente sera Reprovado",
              "${percent.toStringAsFixed(2)}% de aproveitamento}",
              duration: Duration(seconds: 5),
              backgroundColor: Colors.red,
              colorText: Colors.white,
              icon: Icon(Icons.check, color: Colors.white),
              snackPosition: SnackPosition.BOTTOM,
            );
          }
          Get.offAll(
            () => LevelsScreen(),
            duration: Duration(seconds: 1),
            transition: Transition.leftToRight,
            curve: Curves.easeInOutCubic,
          );
        }
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.check),
            Text(
              "Responder",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Edu",
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
