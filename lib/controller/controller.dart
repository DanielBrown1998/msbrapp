import 'package:get/get.dart';
import 'package:msbrapp/models/company.dart';
import 'package:msbrapp/models/question.dart';

class ControllerLevels extends GetxController {
  RxList levels = [].obs;

  addLevel(String level) {
    levels.add(level);
    update();
  }
}

class ControllerLevel extends GetxController {
  RxString level = "".obs;
  RxList questions = [].obs;
  RxList choices = [].obs;
  RxList answers = [].obs;
  RxBool aproved = false.obs;
}

class ControllerCompanies extends GetxController {
  RxInt indexCompany = 0.obs;
  RxList companies = [].obs;

  addCompany(Company company) {
    companies.add(company);
    update();
  }
}

class ControllerQuestion extends GetxController {
  RxInt choice = (-1).obs;
  RxInt answer = 0.obs;
  RxString question = "".obs;
  RxList options = [].obs;
  RxList colors = [].obs;
  RxString id = "".obs;

  setQuestion(Question quest) {
    answer.value = quest.answer;
    question.value = quest.question;
    options.value = quest.options;
    id.value = quest.id;
  }
}
