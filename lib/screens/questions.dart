import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msbrapp/components/answerQuestionsButton.dart';
import 'package:msbrapp/components/questionCard.dart';
import 'package:msbrapp/controller/controller.dart';
import 'package:msbrapp/models/question.dart';

class QuestionsScreen extends StatefulWidget {
  final String level;

  const QuestionsScreen({super.key, required this.level});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late ControllerLevels controllerLevels;
  @override
  void initState() {
    super.initState();
    controllerLevels = Get.find<ControllerLevels>();
  }

  bool checkIfLevelIsAvailable() {
    int index = controllerLevels.allLevels.indexWhere(
      (element) => element.name == widget.level,
    );
    return (index > 0 &&
        !controllerLevels.levels.contains(
          controllerLevels.allLevels[index - 1].name,
        ));
  }

  void setDataInQuestion(List<dynamic> data, ControllerLevel controllerLevel) {
    for (int indexQuestion = 0; indexQuestion < data.length; indexQuestion++) {
      Question question = Question.fromJson(data[indexQuestion]);
      final ControllerQuestion controllerQuestion = Get.put(
        ControllerQuestion(),
        tag: data[indexQuestion]['id'],
      );
      controllerQuestion.setQuestion(question);
      int len = data[indexQuestion]['options'].length;
      controllerLevel.answers.value = List.generate(len, (index) => -1);
      controllerQuestion.colors.value = List.generate(
        len,
        (index) => Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ControllerLevel controllerLevel = Get.find<ControllerLevel>(
      tag: widget.level,
    );

    if (checkIfLevelIsAvailable()) {
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
          future: controllerLevel.searchQuestion(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              controllerLevel.questions.value = snapshot.data!;
              controllerLevel.choices.value = List.generate(
                snapshot.data!.length,
                (index) => 0,
              );
              //set question
              setDataInQuestion(snapshot.data!, controllerLevel);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, indexQuestion) {
                        //get question
                        ControllerQuestion controllerQuestion =
                            Get.find<ControllerQuestion>(
                              tag: snapshot.data![indexQuestion]['id'],
                            );
                        return Questioncard(
                          controllerLevel: controllerLevel,
                          indexQuestion: indexQuestion,
                          controllerQuestion: controllerQuestion,
                        );
                      },
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 100, maxWidth: 250),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: AnswerQuestionButton(
                        controllerLevel: controllerLevel,
                        controllerLevels: controllerLevels,
                        level: widget.level,
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
