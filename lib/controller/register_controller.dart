import 'package:get/get.dart';
import 'package:msbrapp/api/data.dart';
import 'package:msbrapp/models/company.dart';

class RegisterController extends GetxController {
  Rx<Company> company = Company(name: "anonimo", level: null).obs;
  Future<bool> register(String companyName) async {
    Company newCompany = Company(name: companyName, level: null);
    bool isRegister = await setCompany(newCompany);
    company.value = newCompany;
    return isRegister;
  }

  Future<Company?> search(String companyName) async {
    List<Company> companies = await getAllCompanies();
    for (Company item in companies) {
      if (item.name == companyName) {
        company.value = item;
        return item;
      }
    }
    return null;
  }
}
