import 'package:final_task/weather/secondScreen.dart';
import 'package:final_task/weather/viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

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
    final themeNotifier = Provider.of<darkmodepreferences>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: const Text(
          "Weather Live",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              themeNotifier.toggleTheme();
            },
            child: const Icon(
              Icons.brightness_4_outlined,
              color: Colors.purple,
            ),
            //style: ButtonStyle(iconSize: ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                child: Text(
                  "Our Motto : ",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8),
              child: Text(
                "Our app will help you to check the weather accross the major cities of pakistan . you can also see their some insight pictures  ",
                style: TextStyle(fontSize: 23, color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8),
              child: Text("beautiful pictures of pakistan",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/pak1.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/pak2.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
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
                  duration: const Duration(
                      milliseconds: 100), // Fade animation duration
                  opacity: opacity,
                  child: Transform.scale(
                    scale: scale, // Scaling effect
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Want to check weather?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
