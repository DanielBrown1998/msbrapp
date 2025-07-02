import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msbrapp/controller/controller.dart';

class Questioncard extends StatelessWidget {
  final int indexQuestion;
  final ControllerQuestion controllerQuestion;
  final ControllerLevel controllerLevel;
  const Questioncard({
    super.key,
    required this.controllerLevel,
    required this.indexQuestion,
    required this.controllerQuestion,
  });

  void updateQuestion(
    ControllerLevel controllerLevel,
    ControllerQuestion controllerQuestion, {
    required int indexQuestion,
    required int indexOption,
  }) {
    Color color = Colors.grey.shade600;
    // setando a escolha
    controllerQuestion.choice.value = indexOption;
    //add a escolha ao level associado
    controllerLevel.choices[indexQuestion] =
        (indexOption + 1) * (1 / controllerQuestion.options.length);

    //setando a cor na resposta
    for (int j = 0; j < controllerQuestion.colors.length; j++) {
      if (controllerQuestion.colors[j] == color && indexOption != j) {
        controllerQuestion.colors[j] = Colors.white;
      }
    }
    controllerQuestion.colors[indexOption] = color;
    //variavel de controller para responder

    controllerLevel.answers[indexQuestion] = indexOption;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          "Question ${indexQuestion + 1}:",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Metropolis-Bold",
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "-> ${controllerQuestion.question}",
          style: TextStyle(fontSize: 20, fontFamily: "Metropolis"),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.black, width: 2),
          ),
          height: 150 * controllerQuestion.options.length.toDouble() + 20,
          width: double.maxFinite,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: controllerQuestion.options.length,
            itemBuilder: (context, indexOption) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => ElevatedButton(
                    onPressed: () {
                      updateQuestion(
                        controllerLevel,
                        controllerQuestion,
                        indexOption: indexOption,
                        indexQuestion: indexQuestion,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          controllerQuestion.colors[indexOption] ??
                          Colors.white,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.elliptical(2, 1)),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${controllerQuestion.options[indexOption]} \n",
                        style: TextStyle(
                          overflow: TextOverflow.visible,
                          fontSize: 18,
                          color:
                              controllerQuestion.colors[indexOption] ==
                                      Colors.grey.shade600
                                  ? Colors.white
                                  : Colors.black87,
                          fontFamily: "Metropolis-Light",
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
