import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:msbrapp/controller/register_controller.dart';
import 'package:msbrapp/models/company.dart';
import 'package:msbrapp/screens/home.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  TextEditingController searchCompanyController = TextEditingController();
  TextEditingController registerCompanyController = TextEditingController();

  RegisterController registerController = Get.put(RegisterController());

  bool visible = false;

  Future<void> _authenticate() async {
    var companyController = Get.find<RegisterController>();
    if (!visible) {
      Company? findCompany = await companyController.search(
        searchCompanyController.text,
      );
      if (findCompany == null) {
        setState(() {
          visible = true;
        });
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

  @override
  Widget build(BuildContext context) {
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
              child: Visibility(
                visible: !visible,
                child: TextFormField(
                  controller: searchCompanyController,
                  maxLines: 1,
                  maxLength: 50,
                  decoration: InputDecoration(label: Text("buscar empresa")),
                ),
              ),
            ),
            //register company
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Visibility(
                visible: visible,
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
            Row(
              mainAxisAlignment:
                  (visible)
                      ? MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: visible,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        visible = false;
                      });
                    },
                    child: Text("esquecer"),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _authenticate();
                  },
                  child: Text(
                    (!visible) ? "buscar" : "cadastrar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: (visible) ? Colors.green : Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
