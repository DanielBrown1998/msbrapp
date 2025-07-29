import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:msbrapp/controller/register_controller.dart';
import 'package:msbrapp/models/company.dart';
import 'package:msbrapp/screens/home.dart';

// ignore: must_be_immutable
class Registerscreen extends StatelessWidget {
  Registerscreen({super.key});

  TextEditingController searchCompanyController = TextEditingController();
  // TextEditingController registerCompanyController = TextEditingController(); // Unused

  RegisterController registerController = Get.put(RegisterController());
  RxBool visible = false.obs;
  RxString companyName = "".obs;
  String keyStorage = "company";
  late GetStorage storage;

  Future<void> _authenticate() async {
    var companyController = Get.find<RegisterController>();
    if (!visible.value) {
      Company? findCompany = await companyController.search(
        searchCompanyController.text,
      );
      if (findCompany == null) {
        visible.value = true;
      } else {
        Get.to(
          Home(),
          duration: Duration(seconds: 1),
          transition: Transition.leftToRight,
          curve: Curves.easeInOut,
        );
      }
    } else {
      companyController.register(searchCompanyController.text);
      Get.to(
        Home(),
        duration: Duration(seconds: 1),
        transition: Transition.leftToRight,
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> loadStorage() async {
    storage = GetStorage();
    await storage.initStorage;
    companyName.value = storage.read(keyStorage) ?? "";
  }

  @override
  Widget build(BuildContext context) {
    loadStorage();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 20,
        titleTextStyle: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          fontFamily: "DancingScript",
          color: Colors.black54,
        ),
        title: Text("MPSBr"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          bottom: 0,
          right: 16,
          left: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Logo
            SizedBox(
              height: 250,
              width: 250,
              child: Lottie.asset("assets/lotties/lottie-msbrapp.json"),
            ),
            //search company if not company, so regsiter
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Obx(
                () => Visibility(
                  visible: !visible.value,
                  child:
                      (companyName.value.isNotEmpty)
                          ? TextFormField(
                            key: ValueKey(companyName.value),
                            initialValue: companyName.value,
                            controller: null,
                            maxLines: 1,
                            maxLength: 50,
                            decoration: InputDecoration(
                              label: Text("buscar empresa"),
                            ),
                          )
                          : TextFormField(
                            controller: searchCompanyController,
                            maxLines: 1,
                            maxLength: 50,
                            decoration: InputDecoration(
                              label: Text("buscar empresa"),
                            ),
                          ),
                ),
              ),
            ),

            //register company
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Visibility(
                  visible: visible.value,
                  child: TextFormField(
                    initialValue: searchCompanyController.text,
                    maxLines: 1,
                    maxLength: 50,
                    readOnly: true,
                    decoration: InputDecoration(
                      label: Text("registrar empresa"),
                      helperText: "deseja cadastrar essa Compania?",
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => Row(
                mainAxisAlignment:
                    (visible.value)
                        ? MainAxisAlignment.spaceEvenly
                        : MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: visible.value,
                    child: ElevatedButton(
                      onPressed: () {
                        visible.value = false;
                      },
                      child: Text("esquecer"),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      storage.write(keyStorage, searchCompanyController.text);
                      await _authenticate();
                    },
                    child: Text(
                      (!visible.value) ? "buscar" : "cadastrar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: (visible.value) ? Colors.green : Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
