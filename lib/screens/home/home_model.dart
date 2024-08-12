import 'package:get/get.dart';
import 'package:weathertest/model/city_wather_model.dart';
import 'package:weathertest/model/ip_geo_model.dart';
import 'package:weathertest/model/ip_model.dart';


class HomeModel{
  var isReady = false.obs;
  var ipInfoModelr = IpInfoModel().obs;
  var ipIGeoLocModel = IpIGeoLocModel().obs;
  var cityWeatherModel = CityWeatherModel().obs;

}