import 'package:get/get.dart';
import 'package:weathertest/screens/forecast/forecast_controller.dart';

class ForecastBinding extends Bindings{
  @override
  void dependencies() {
    final String cityName=Get.parameters['cityName']??'mumbai';

    Get.lazyPut(()=>ForecastController(cityName));
    // TODO: implement dependencies
  }

}