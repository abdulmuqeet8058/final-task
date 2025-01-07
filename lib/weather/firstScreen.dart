import 'package:final_task/weather/secondScreen.dart';
import 'package:final_task/weather/viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Firstscreen extends StatefulWidget {
  const Firstscreen({super.key});

  @override
  State<Firstscreen> createState() => _FirstscreenState();
}

class _FirstscreenState extends State<Firstscreen> {
  double scale = 1.0;
  double opacity = 1.0;
  WeatherViewModel model = Get.put(WeatherViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: const Text(
          "Weather Live",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        actions: [
          Obx(
            () => Switch(
              value: model.isDark.value,
              onChanged: (value) {
                model.toggleDarkMode(value);
              },
              activeColor: Colors.green,
              inactiveThumbColor: Colors.black,
              inactiveTrackColor: Colors.red.withOpacity(0.5),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => secondScreen()));
            },
            onTapDown: (_) {
              setState(() {
                scale = 0.9; // Shrink button
                opacity = 0.8; // Reduce opacity
              });
            },
            onTapUp: (_) {
              setState(() {
                scale = 1.0; // Restore button size
                opacity = 1.0; // Restore opacity
              });
            },
            onTapCancel: () {
              setState(() {
                scale = 1.0;
                opacity = 1.0;
              });
            },
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 100), // Fade animation duration
              opacity: opacity,
              child: Transform.scale(
                scale: scale, // Scaling effect
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Want to check weather?',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
