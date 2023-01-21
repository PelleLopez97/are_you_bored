import 'dart:convert';
import 'dart:math';

import 'package:are_you_bored/activity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Color color1;
  late Color color2;
  late Color color3;
  late Color color4;
  late Color color5;
  double fontsize = 45;
  Cubic customCubic = const Cubic(0.55, 0.085, 0.68, 0.53);
  Activity? activity;

  @override
  void initState() {
    super.initState();

    ejecutarTodo();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            color1,
            color2,
            color3,
            color4,
            color5,
          ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                width: size.width,
                height: size.height * 0.3,
                child: const Center(
                  child: Text(
                    "Are you bored?",
                    style: TextStyle(
                        fontSize: 75,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Positioned(
                width: size.width,
                height: size.height * 0.6,
                top: size.height * 0.3,
                child: SingleChildScrollView(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 1000),
                    curve: customCubic,
                    child: Column(
                      children: [
                        Text(
                          activity?.activity ?? "no data",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontsize,
                              fontWeight: FontWeight.bold),
                        ),
                        const Divider(height: 30, thickness: 2),
                        Text(
                          'Participants: ${activity?.participants ?? "0"}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontsize,
                              fontWeight: FontWeight.bold),
                        ),
                        const Divider(height: 30, thickness: 2),
                        Text(
                          activity?.type ?? "no data",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontsize,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.replay_outlined),
          onPressed: () {
            ejecutarTodo();
          }),
    );
  }

  void buscarActividad() {
    http.get(Uri.parse("https://www.boredapi.com/api/activity")).then((value) {
      final data = json.decode(value.body);
      activity = Activity.fromMap(data);
    });
  }

  ejecutarTodo() {
    setState(() {
      buscarActividad();
      getRandomGradient();
      animateData();
      getRamdonCubic();
    });
  }

  animateData() {
    final random = Random();
    fontsize = random.nextInt(255).toDouble();
    fontsize = (fontsize < 35 || fontsize > 60) ? 45 : fontsize;
  }

  getRandomGradient() {
    Random random = Random();

    color1 = Color.fromRGBO(
        random.nextInt(255), random.nextInt(255), random.nextInt(255), 1);
    color2 = Color.fromRGBO(
        random.nextInt(255), random.nextInt(255), random.nextInt(255), 1);
    color3 = Color.fromRGBO(
        random.nextInt(255), random.nextInt(255), random.nextInt(255), 1);
    color4 = Color.fromRGBO(
        random.nextInt(255), random.nextInt(255), random.nextInt(255), 1);
    color5 = Color.fromRGBO(
        random.nextInt(255), random.nextInt(255), random.nextInt(255), 1);
  }

  getRamdonCubic() {
    customCubic = Cubic(
        Random().nextInt(255).toDouble(),
        Random().nextInt(255).toDouble(),
        Random().nextInt(255).toDouble(),
        Random().nextInt(255).toDouble());
  }
}
