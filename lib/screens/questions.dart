import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msbrapp/api/data.dart' as api;
import 'package:msbrapp/controller/controller.dart';
import 'package:msbrapp/models/question.dart';

class QuestionsScreen extends StatefulWidget {
  final String level;

  const QuestionsScreen({super.key, required this.level});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    final ControllerLevel controllerLevel = Get.put(
      ControllerLevel(),
      tag: widget.level,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "nivel de maturidade: ${widget.level}",
          style: TextStyle(fontFamily: "DancingScript", fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: api.searchQuestions(level: widget.level),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              controllerLevel.questions.value = snapshot.data!;
              controllerLevel.answers.value = List.generate(
                snapshot.data!.length,
                (index) => snapshot.data![index]['answer'],
              );
              controllerLevel.choices.value = List.generate(
                snapshot.data!.length,
                (index) => -1,
              );
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Question question = Question.fromJson(
                          snapshot.data![index],
                        );

                        String quest = question.question;

                        List<String> options = question.options;

                        ControllerQuestion controllerQuestion = Get.put(
                          ControllerQuestion(),
                          tag: question.id,
                        );

                        controllerQuestion.setQuestion(question);

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              "Question ${index + 1}:",
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: "Metropolis-Bold",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "-> $quest",
                              style: TextStyle(
                                fontSize: 30,
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
                              height: 500,
                              width: double.maxFinite,
                              child: ListView.builder(
                                itemCount: options.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        controllerQuestion.choice.value = i;
                                        if (controllerQuestion.choice.value ==
                                            controllerQuestion.answer.value) {
                                          controllerLevel.choices[index] = i;
                                        } else {}
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: question.color,
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
                                          "${options[index]} \n",
                                          style: TextStyle(
                                            overflow: TextOverflow.visible,
                                            fontSize: 20,
                                            fontFamily: "Metropolis-Light",
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
                          print(controllerLevel.choices);
                          print(controllerLevel.answers);
                          if (controllerLevel.choices.value ==
                              controllerLevel.answers.value) {
                            //TODO: ir para uma pagina de parabens
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
                                  fontFamily: "Metropolis-Bold",
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
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 40, color: Colors.red),
                  Text(
                    snapshot.error.toString(),
                    style: TextStyle(fontSize: 40, fontFamily: "DancingScript"),
                  ),
                ],
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
