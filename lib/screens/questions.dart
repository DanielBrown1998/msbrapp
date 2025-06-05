import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msbrapp/api/data.dart' as api;
import 'package:msbrapp/controller/controller.dart';
import 'package:msbrapp/models/question.dart';
import 'package:msbrapp/screens/levels.dart';

class QuestionsScreen extends StatefulWidget {
  final String level;

  const QuestionsScreen({super.key, required this.level});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    final ControllerLevel controllerLevel = Get.find<ControllerLevel>(
      tag: widget.level,
    );
    final ControllerLevels controllerLevels = Get.find<ControllerLevels>();

    int index = controllerLevels.allLevels.indexWhere(
      (element) => element.name == widget.level,
    );

    if (index > 0 &&
        !controllerLevels.levels.contains(
          controllerLevels.allLevels[index - 1].name,
        )) {
      return Scaffold(
        backgroundColor: Colors.red.shade200,
        body: Center(
          child: SizedBox(
            width: double.maxFinite,
            height: Get.size.height / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.block, size: 60, color: Colors.red.shade700),
                Text(
                  "Nivel ' ${widget.level} ' bloqueado!",
                  style: TextStyle(fontSize: 40, fontFamily: "DancingScript"),
                ),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back),
                  iconSize: 40,
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "nivel de maturidade: ${widget.level}",
          style: TextStyle(fontFamily: "Edu", fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: api.searchQuestions(level: widget.level),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              controllerLevel.questions.value = snapshot.data!;
              controllerLevel.choices.value = List.generate(
                snapshot.data!.length,
                (index) => 0,
              );

              for (int i = 0; i < snapshot.data!.length; i++) {
                // print(snapshot.data![i]["id"]);
                Question question = Question.fromJson(snapshot.data![i]);
                final ControllerQuestion controllerQuestion = Get.put(
                  ControllerQuestion(),
                  tag: snapshot.data![i]['id'],
                );
                controllerQuestion.setQuestion(question);
                int len = snapshot.data![i]['options'].length;
                controllerLevel.answers.value = List.generate(
                  len,
                  (index) => -1,
                );
                controllerQuestion.colors.value = List.generate(
                  len,
                  (index) => Colors.white,
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        ControllerQuestion controllerQuestion =
                            Get.find<ControllerQuestion>(
                              tag: snapshot.data![index]['id'],
                            );

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              "Question ${index + 1}:",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Metropolis-Bold",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "-> ${controllerQuestion.question}",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Metropolis",
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              height:
                                  150 *
                                      controllerQuestion.options.length
                                          .toDouble() +
                                  20,
                              width: double.maxFinite,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controllerQuestion.options.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Obx(
                                      () => ElevatedButton(
                                        onPressed: () {
                                          Color color = Colors.grey.shade600;
                                          // setando a escolha
                                          controllerQuestion.choice.value = i;
                                          //add a escolha ao level associado
                                          controllerLevel.choices[index] =
                                              (i + 1) *
                                              (1 /
                                                  controllerQuestion
                                                      .options
                                                      .length);
                                          for (
                                            int j = 0;
                                            j <
                                                controllerQuestion
                                                    .colors
                                                    .length;
                                            j++
                                          ) {
                                            if (controllerQuestion.colors[j] ==
                                                    color &&
                                                i != j) {
                                              controllerQuestion.colors[j] =
                                                  Colors.white;
                                            }
                                          }
                                          controllerQuestion.colors[i] = color;
                                          //variavel de controller para responder

                                          controllerLevel.answers[index] =
                                              i;
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              controllerQuestion.colors[i] ??
                                              Colors.white,
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.elliptical(2, 1),
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${controllerQuestion.options[i]} \n",
                                            style: TextStyle(
                                              overflow: TextOverflow.visible,
                                              fontSize: 18,
                                              color:
                                                  controllerQuestion
                                                              .colors[i] ==
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
                      },
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 100, maxWidth: 250),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // soma todas as escolhas
                          double sum = controllerLevel.choices.reduce(
                            (a, b) => a + b,
                          );
                          // calcula o percentual
                          double percent =
                              (sum / controllerLevel.choices.length) * 100;
                          if (controllerLevel.answers.length !=
                              controllerLevel.questions.length) {
                            Get.snackbar(
                              "Erro",
                              'Responda todas as perguntas',
                              duration: Duration(seconds: 3),
                              backgroundColor: Colors.yellow,
                              colorText: Colors.white,
                            );
                          } else {
                            if (percent >= 75) {
                              //variavel de controle para checar se foi aprovado
                              controllerLevel.aproved.value = true;
                              //add no controle de niveis para validar a aprovacao no levels
                              controllerLevels.levels.add(widget.level);
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
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.error, size: 40, color: Colors.red),
                    Text(
                      "Erro de conexão",
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: "DancingScript",
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
