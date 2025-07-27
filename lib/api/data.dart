import 'package:msbrapp/helpers/urls.dart';
import "package:get/get_connect/connect.dart" as connect;
import "package:msbrapp/api/token.dart";
import "package:msbrapp/models/company.dart";
import "package:msbrapp/models/question.dart";

class MpsbrApi extends connect.GetConnect {
  late String urlCompanies;
  late String urlQuestions;
  @override
  void onInit() {
    urlCompanies = Urls.urlCompanies;
    urlQuestions = Urls.urlQuestions;
    super.onInit();
  }

  @override
  bool get initialized {
    return super.initialized &&
        urlCompanies.isNotEmpty &&
        urlQuestions.isNotEmpty;
  }

  Future<List<Question>> searchQuestions({required String level}) async {
    if (!initialized) urlQuestions = Urls.urlQuestions;
    connect.Response response = await get(
      urlQuestions,
      decoder: (data) {
        return Question.listFromJson(data["files"]["mpsbr.json"]["content"]);
      },
      query: {"level": level.toUpperCase()},
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );
    if (response.status.hasError) return [];
    return response.body;
  }

  Future<bool> setCompany(Company company) async {
    if (!initialized) {
      urlCompanies = Urls.urlCompanies;
    }
    connect.Response response = await post(
      urlCompanies,
      company.toJson(),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode.toString().startsWith("2")) return true;
    return false;
  }

  Future<List<Company>> getAllCompanies({required String nameCompany}) async {
    if (!initialized) {
      urlCompanies = Urls.urlCompanies;
    }
    connect.Response response = await get(
      urlCompanies,
      decoder: (data) {
        return Company.listFromJson(data["files"]["companies.json"]["content"]);
      },
      query: {"name": nameCompany},
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );
    if (response.status.hasError) return [];
    return response.body;
  }
}
