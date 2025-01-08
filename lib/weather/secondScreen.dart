import 'package:final_task/weather/viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class secondScreen extends StatefulWidget {
  @override
  State<secondScreen> createState() => _secondScreenState();
}

class _secondScreenState extends State<secondScreen> {
  WeatherViewModel model = Get.put(WeatherViewModel());

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    try {
      model.fetchWeatherData();
    } catch (e) {
      print("Error during initState: $e");
    }
  }

  Future<void> _refresh() async {
    return await model.fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<darkmodepreferences>(context);
    Map<String, String> cityImages = {
      "Quetta": "assets/quetta.jpeg",
      "Lahore": "assets/lahore.jpeg",
      "Multan": "assets/multan.jpeg",
      "Karachi": "assets/karachi.jpeg",
      "Mingora": "assets/mingora.jpeg", // Using "Mingora" for Peshawar here
    };

    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              themeNotifier.toggleTheme();
            },
            child: Icon(
              Icons.brightness_4_outlined,
              color: Colors.purple,
            ),
            //style: ButtonStyle(iconSize: ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.purple,
        automaticallyImplyLeading: false, // Removes the back arrow
        title: const Text(
          "Weather Live",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
      // body start here
      body: ListView.builder(
        itemCount: model.weatherList.length,
        itemBuilder: (context, index) {
          final weather = model.weatherList[index];
          var cityname = weather.cityName;
          var temp = weather.currentTemperature;
          var desc = weather.weatherDescription;
          final imagePath = cityImages[cityname];
          return Padding(
            padding: const EdgeInsets.all(26.0),
            child: Card(
              child: Container(
                height: 400,
                width: 300,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "City Name : $cityname",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imagePath.toString()),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      "current temprature : $temp",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "weather status : $desc",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),

      //body ends here
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
