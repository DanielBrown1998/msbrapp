import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  TextEditingController searchCompanyController = TextEditingController();
  TextEditingController registerCompanyController = TextEditingController();
  bool visible = false;
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
                  // initialValue: searchCompanyController.text,
                  controller: registerCompanyController,
                  maxLines: 1,
                  maxLength: 50,
                  decoration: InputDecoration(
                    label: Text("registrar empresa"),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                (!visible) ? "buscar" : "cadastrar",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
