import 'dart:convert';



import 'package:http/http.dart' as http;
import 'package:weathertest/model/city_wather_model.dart';
import 'package:weathertest/model/ip_geo_model.dart';
import 'package:weathertest/model/ip_model.dart';
import 'package:weathertest/model/search_model.dart';

final String APIKEY="25d7c4acbf4a4216b5465923241607";

class ApiServices {
  Future<IpInfoModel?> getIpInfo() async {
    try {
      var res = await http.get(Uri.parse('https://api.ipify.org/?format=json'));
      if (res.statusCode == 200) {
        IpInfoModel ipInfoModel = IpInfoModel.fromJson(json.decode(res.body));
        return ipInfoModel;
      }
    } catch (e) {
      print(e.toString());
    }

    return null;
  }




  // IpInfoModel ipinfomodel=IpInfoModel();
  Future<IpIGeoLocModel?> getIPGeoLocation( String ipaddress)
  async{
    try{
      var res=await http.get(Uri.parse("https://api.ipgeolocation.io/ipgeo?apiKey=2f058980b09849ac9e9b15b9b744575e&ip=${ipaddress}"));
      if(res.statusCode==200)
      {
        IpIGeoLocModel ipGeoLocModel=IpIGeoLocModel.fromJson(json.decode(res.body));
        return ipGeoLocModel;
      }
    }
    catch(e)
    {
      print(e.toString());
    }
    return null;
  }

  Future<CityWeatherModel?> getCityWeather(String cityname) async{
    try{
      var res=await http.get(Uri.parse("http://api.weatherapi.com/v1/current.json?key=$APIKEY&q=${cityname}"));
      if(res.statusCode==200){
        CityWeatherModel cityWeatherModel=CityWeatherModel.fromJson(json.decode(res.body));
        return cityWeatherModel;
      }
    }
    catch(e)
    {
      print(e.toString());
    }
    return null;
  }

  Future<List<SearchCityModel>?> searchCity(String query) async
  {

    try{
      var res=await http.get(Uri.parse("http://api.weatherapi.com/v1/search.json?key=$APIKEY&q=${query}"));
      if(res.statusCode==200)
      {
        List<SearchCityModel> searchmodel=List<SearchCityModel>.from(json.decode(res.body).map((x)=>SearchCityModel.fromJson(x)));
        return searchmodel;
      }
    }
    catch(e)
    {
      print(e.toString());
    }
    return null;
  }


  Future<Map<String, dynamic>?> getForecastData(String cityname) async {
    try {
      var res = await http.get(Uri.parse(
          "http://api.weatherapi.com/v1/forecast.json?key=$APIKEY&q=${cityname}&days=7"));
      if (res.statusCode == 200) {

        return json.decode(res.body);
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<Map<String,dynamic>?> getHistoricData(String cityname,String fromDate,String toDate) async
  {
    try{
      print("Trying to get Historical :    http://api.weatherapi.com/v1/history.json?key=d771530ea2c04342a4a114808240807&days=7&q=$cityname&dt=$fromDate&end_dt=$toDate");

      var res=await http.get(Uri.parse("http://api.weatherapi.com/v1/history.json?key=$APIKEY&days=7&q=$cityname&dt=$fromDate&end_dt=$toDate"));
      if( res.statusCode==200)
      {
        return json.decode(res.body);
      }

    }
    catch(e)
    {
      print(e.toString());
    }

    return null;
  }



}