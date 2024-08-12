import 'package:get/get.dart';
import 'package:weathertest/routes/app_routes.dart';
import 'package:weathertest/screens/forecast/forecast_binding.dart';
import 'package:weathertest/screens/forecast/forecast_view.dart';
import 'package:weathertest/screens/home/home_binding.dart';
import 'package:weathertest/screens/home/home_view.dart';
import 'package:weathertest/screens/splash/splash_view.dart';

class AppPages{
  static const initial=Routes.home;
  static final routes=[
    GetPage(name: Routes.splashView, page: ()=>const SplashView()),
    GetPage(name: Routes.home, page: ()=> HomeView(cityName: "",),binding: HomeBinding()),
    GetPage(name: Routes.forecast, page: ()=>const ForecastView(),parameters: {'cityName':''},binding: ForecastBinding())

  ];
}