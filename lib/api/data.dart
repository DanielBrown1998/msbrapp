import "dart:convert";

import "package:http/http.dart";
import "package:msbrapp/api/token.dart";


String url = "https://api.github.com/gists/62f886088ec73a1ca3e7e179e4075a61";

Future<List<dynamic>> searchQuestions({required String level}) async {
  
  Response response = await get(
    Uri.parse(url),
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

void main() {
  searchQuestions(level: "B");
}
