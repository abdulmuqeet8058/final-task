import 'dart:convert';
import 'package:final_task/weather/model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WeatherViewModel extends GetxController {
  RxBool isDark = false.obs;
  RxList<WeatherModel> model = <WeatherModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    _loadTheme(); // Load theme preference at initialization
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    isDark.value =
        prefs.getBool("darkmode") ?? false; // Default to false (light mode)
    Get.changeTheme(isDark.value ? ThemeData.dark() : ThemeData.light());
  }

  void toggleDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("darkmode", value); // Save preference

    Get.changeTheme(isDark.value ? ThemeData.dark() : ThemeData.light());
  }

  Future<void> GetWeather() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      Get.snackbar("Permission Denied",
          "You denied access to the location please enable it");
      LocationPermission ask = await Geolocator.requestPermission();
      if (ask == LocationPermission.denied ||
          ask == LocationPermission.deniedForever) {
        return;
      }
    } else {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        double latitude = position.latitude;
        double longitude = position.longitude;
        const String apiKey = "3c95824344f7d401a18ab7dcbd03918e";
        final String url =
            "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric";
        Map<String, String> requestHeaders = {
          'Content-Type': 'application/json'
        };
        var response = await http.get(Uri.parse(url), headers: requestHeaders);
        final data = jsonDecode(response.body);
        // Extract data for WeatherModel
        final double currentTemperature =
            data['main']?['temp']?.toDouble() ?? 0.0;
        final String weatherDescription =
            data['weather']?[0]?['description']?.toString() ?? 'Unknown';
        final double humidityLevel =
            data['main']?['humidity']?.toDouble() ?? 0.0;

        if (data['weather'] == null || data['main'] == null) {
          Get.snackbar("Error", "Incomplete data received from API");
          return;
        }

        if (response.statusCode == 200) {
          // Create WeatherModel instance
          WeatherModel weather = WeatherModel(
            currentTemperature: currentTemperature,
            weatherDescription: weatherDescription,
            humidityLevel: humidityLevel,
          );

          // Add to RxList
          model.add(weather);
          Get.snackbar("Succesfull", "api connected succesfully");
          // List<dynamic> jsonData = jsonDecode(response.body);
          // model.value =
          //     jsonData.map((map) => WeatherModel.fromJson(map)).toList();
        } else if (response.statusCode == 401) {
          Get.snackbar("Unsuccesfull", "You are Unauthorized");
        }
      } catch (e) {
        Get.snackbar("Error", "An error occurred: $e");
      }
    }
  }
}
