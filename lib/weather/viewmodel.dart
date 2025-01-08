import 'dart:convert';
import 'package:final_task/weather/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WeatherViewModel extends GetxController {
  RxList<WeatherModel> weatherList = <WeatherModel>[].obs;

  Future<void> fetchWeatherData() async {
    const String apiKey = "3c95824344f7d401a18ab7dcbd03918e";
    const String url =
        "https://api.openweathermap.org/data/2.5/group?id=1167528,1172451,1169825,1174872,1170395&appid=$apiKey&units=metric";

    try {
      // API Request
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Parse the list of cities from the "list" key
        List<dynamic> cities = data['list'];
        weatherList.value =
            cities.map((cityData) => WeatherModel.fromJson(cityData)).toList();

        Get.snackbar("Success", "Weather data fetched successfully!");
      } else if (response.statusCode == 401) {
        Get.snackbar("Unauthorized", "Invalid API key.");
      } else {
        Get.snackbar("Error", "Failed to fetch weather data.");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }
}

class darkmodepreferences extends ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  ThemeData get currentTheme =>
      _isDarkTheme ? ThemeData.dark() : ThemeData.light();

  // Load theme preference from SharedPreferences
  Future<void> loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    notifyListeners();
  }

  // Toggle theme and save preference
  Future<void> toggleTheme() async {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', _isDarkTheme);
  }

  // Set theme explicitly (used for dropdown selection)
  Future<void> setTheme(bool isDark) async {
    _isDarkTheme = isDark;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', _isDarkTheme);
  }
}
