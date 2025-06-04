import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msbrapp/controller/controller.dart';
import 'package:msbrapp/screens/levels.dart';

class Home extends StatefulWidget {
  const Home({super.key, this.title = 'MPS Br.'});

  final String title;
  static const String description =
      """O MPS.BR (Melhoria de Processo do Software Brasileiro) é
um programa que visa melhorar a qualidade e a produtividade das empresas desenvolvedoras
de software no Brasil. Ele foi criado por iniciativa da Softex 
(Sociedade Brasileira para a Promoção da Excelência do Software)
e é baseado em normas internacionais de qualidade, adaptadas à realidade brasileira.
""";
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String get description => Home.description;

  @override
  void initState() {
    final controller = Get.put(ControllerLevels());
    for (int i = 0; i < controller.allLevels.length; i++) {
      Get.put(ControllerLevel(), tag: controller.allLevels[i].name);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 30,
            children: <Widget>[
              const Text(
                'MPS Br.',
                style: TextStyle(fontFamily: "Edu", fontSize: 40),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 20, fontFamily: "Metropolis"),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 100, maxWidth: 250),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 12,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.off(
                        () => LevelsScreen(),
                        duration: Duration(seconds: 1),
                        transition: Transition.downToUp,
                        curve: Curves.easeInOutCubic,
                      );
                    },
                    child: Row(
                      spacing: 5,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.start, size: 25),
                        Text(
                          "iniciar",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Edu",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
