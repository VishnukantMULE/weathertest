import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathertest/screens/home/home_model.dart';

import 'package:weathertest/service/api_services.dart';


class HomeController extends GetxController {


  HomeController(String cityName) {
    _weatherCrone(cityName);
  }
  final HomeModel model=HomeModel();

  int count=1;
   Future<void> _weatherCrone(String cityName) async {
     getCurrentLocationWeather(cityName);
    final cron=Cron();
    try{
      cron.schedule(Schedule.parse("* * * * *"), ()async{
        print("Count :$count");
        getCurrentLocationWeather(cityName);
        count++;
      });
    }
    catch(e)
     {
       print("error");
     }
  }
  void getCurrentLocationWeather(String cityName) async{
    model.isReady.value = true;

    var ipInfo = await ApiServices().getIpInfo();
    if (ipInfo != null) {
      model.ipInfoModelr.value.ip = ipInfo.ip ?? 'Unknown Ip';

      var geoData = await ApiServices().getIPGeoLocation(model.ipInfoModelr.value.ip.toString());
      if (geoData != null) {
        model.ipIGeoLocModel.value = geoData;
        String city = cityName.isEmpty ? model.ipIGeoLocModel.value.city.toString() : cityName;
        cityName=city;
        var cityWeather = await ApiServices().getCityWeather(city);
        if (cityWeather != null) {
          model.cityWeatherModel.value = cityWeather;
        }
      }
    }
    model.isReady.value = false;
  }

}