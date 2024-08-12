import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathertest/routes/app_pages.dart';
import 'package:weathertest/routes/app_routes.dart';
import 'package:weathertest/screens/splash/splash_view.dart';

void main() {
  runApp(const WeatherApp());
}
 


class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      home: SplashView()
    );
  }
}
