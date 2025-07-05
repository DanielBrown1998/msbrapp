import "dart:convert";

import "package:http/http.dart" as http;
import "package:msbrapp/api/token.dart";
import "package:msbrapp/models/company.dart";

String urlCompanies =
    "https://api.github.com/gists/9f112759ffde2be9e00219228eea0c0b";
String urlQuestions =
    "https://api.github.com/gists/62f886088ec73a1ca3e7e179e4075a61";

Future<List<dynamic>> searchQuestions({required String level}) async {
  http.Response response = await http.get(
    Uri.parse(urlQuestions),
    headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data =
        json.decode(
          json.decode(response.body)["files"]["mpsbr.json"]["content"],
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
  http.Response response = await http.post(
    Uri.parse(urlCompanies),
    headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    },
    body: json.encode({
      "files": {
        "companies.json": {"content": json.encode(company.toJson())},
      },
    }),
  );
  if (response.statusCode.toString().startsWith("2")) return true;
  return false;
}

Future<List<Company>> getAllCompanies() async {
  http.Response response = await http.get(
    Uri.parse(urlCompanies),
    headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    },
  );
  List<dynamic> map = json.decode(
    json.decode(response.body)["files"]["companies.json"]["content"],
  );
  List<Company> result = [];
  for (var item in map) {
    result.add(Company.fromMap(item));
  }
  return result;
}

void main() async {
  await getAllCompanies();
}
