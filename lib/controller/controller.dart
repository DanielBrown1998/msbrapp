import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msbrapp/api/data.dart';
import 'package:msbrapp/models/company.dart';
import 'package:msbrapp/models/level.dart';
import 'package:msbrapp/models/question.dart';

class ControllerLevels extends GetxController {
  RxList<Level> allLevels =
      [
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
      ].obs;
  RxList levels = [].obs;
}

class ControllerLevel extends GetxController {
  RxString level = "".obs;
  RxList questions = [].obs;
  RxList choices = [].obs;
  RxList answers = [].obs;
  RxBool aproved = false.obs;
  final MpsbrApi api = Get.put(MpsbrApi());

  Future<List<Question>> searchQuestion() async {
    List<Question> list = await api.searchQuestions(level: level.value);
    questions.value = list;
    return list;
  }
}

class ControllerCompanies extends GetxController {
  RxInt indexCompany = 0.obs;
  RxList companies = [].obs;

  addCompany(Company company) {
    companies.add(company);
  }
}

class ControllerQuestion extends GetxController {
  RxInt choice = (-1).obs;
  RxInt answer = 0.obs;
  RxString question = "".obs;
  RxList options = [].obs;
  RxList colors = [].obs;
  RxString id = "".obs;
  RxList answers = [].obs;

  setQuestion(Question quest) {
    answer.value = quest.answer;
    question.value = quest.question;
    options.value = quest.options;
    id.value = quest.id;
  }
}
