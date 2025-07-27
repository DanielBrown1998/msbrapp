import "dart:convert";

import "package:get/get_connect/connect.dart";
import "package:msbrapp/api/token.dart";
import "package:msbrapp/models/company.dart";

class MpsbrApi extends GetConnect {
  late String urlCompanies;
  late String urlQuestions;
  @override
  void onInit() {
    urlCompanies =
        "https://api.github.com/gists/9f112759ffde2be9e00219228eea0c0b";
    urlQuestions =
        "https://api.github.com/gists/62f886088ec73a1ca3e7e179e4075a61";
    super.onInit();
  }

  @override
  bool get initialized {
    return super.initialized &&
        urlCompanies.isNotEmpty &&
        urlQuestions.isNotEmpty;
  }

  Future<List<dynamic>> searchQuestions({required String level}) async {
    if (!initialized) {
      urlQuestions =
          "https://api.github.com/gists/62f886088ec73a1ca3e7e179e4075a61";
    }

    Response response = await get(
      urlQuestions,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data =
          json.decode(
            response.body["files"]["mpsbr.json"]["content"],
          )["questions"];
      for (dynamic item in data) {
        if (item["level"] == level.toUpperCase()) {
          print("${item['level']} \n");
          print("${item['name']} \n");
          print("${item['characteristics']} \n");

          return item['characteristics'];
        }
      }
      return [];
    } else {
      return [];
    }
  }

  Future<bool> setCompany(Company company) async {
    if (!initialized) {
      urlCompanies =
          "https://api.github.com/gists/9f112759ffde2be9e00219228eea0c0b";
    }
    Response response = await post(
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

  Future<List<Company>> getAllCompanies() async {
    if (!initialized) {
      urlCompanies =
          "https://api.github.com/gists/9f112759ffde2be9e00219228eea0c0b";
    }
    Response response = await get(
      urlCompanies,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );
    var map = json.decode(response.body["files"]["companies.json"]["content"]);
    List<Company> result = [];
    for (var item in map) {
      result.add(Company.fromMap(item));
    }
    return result;
  }
}
