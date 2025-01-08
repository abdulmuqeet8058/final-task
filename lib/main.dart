import 'package:final_task/weather/firstScreen.dart';
import 'package:final_task/weather/viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeNotifier = darkmodepreferences();
  await themeNotifier.loadThemePreference();

  runApp(
    ChangeNotifierProvider(
      create: (_) => themeNotifier,
      child: MyApp(),
    ),
  );
}

/* It may show an exception while running the app 
   because geolocater is initialized in viewmodel class
   but still if exception came use F5 to continue
   it will run .

*/
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<darkmodepreferences>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Live',
      theme: themeNotifier.currentTheme,
      home: Firstscreen(),
    );
  }
}
