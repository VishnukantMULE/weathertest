import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathertest/routes/app_routes.dart';
import 'package:weathertest/screens/home/home_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3),(){
      {
        Get.offNamed(Routes.home);
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeView()));
      }
    });
    return Scaffold(
      body: Center(
        child:Text("Weather App",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
