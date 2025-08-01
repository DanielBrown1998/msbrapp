import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:msbrapp/screens/register.dart';

void main() async {
  GetStorage.init();
  runApp(const MpsBrApp());
}

class MpsBrApp extends StatelessWidget {
  const MpsBrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 218, 9),
        ),
      ),
      home: Registerscreen(),
      // home: const Home(title: 'MpsBr App'),
    );
  }
}
