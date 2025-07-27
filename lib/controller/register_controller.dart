import 'package:get/get.dart';
import 'package:msbrapp/api/data.dart';
import 'package:msbrapp/models/company.dart';

class RegisterController extends GetxController {
  MpsbrApi api = MpsbrApi();
  Rx<Company> company = Company(name: "anonimo", level: null).obs;
  Future<bool> register(String companyName) async {
    Company newCompany = Company(name: companyName, level: null);
    bool isRegister = await api.setCompany(newCompany);
    company.value = newCompany;
    return isRegister;
  }

  Future<Company?> search(String companyName) async {
    List<Company> companies = await api.getAllCompanies();
    print(companies);
    for (Company item in companies) {
      if (item.name == companyName) {
        print(item.name);
        company.value = item;
        return item;
      }
    }
    return null;
  }
}
