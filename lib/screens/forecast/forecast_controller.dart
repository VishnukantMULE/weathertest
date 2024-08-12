import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:weathertest/screens/forecast/forecast_model.dart';
import 'package:weathertest/service/api_services.dart';
import 'package:weathertest/utils/date_formatter.dart';

class ForecastController extends GetxController {
  final ForecastModel model=ForecastModel();
  late String cityname;
  ForecastController(this.cityname);


  @override
  void onInit() {
    super.onInit();
    _getForecast();
  }

  Future<void> _getForecast() async {
    ApiServices forecastController = ApiServices();
    String currentDate = await DateFormater().CurrentDate();
    String lastweekdate = await DateFormater().lastWeekDate();

    var historydata =
    await forecastController.getHistoricData(cityname, lastweekdate, currentDate);
    var forecastdata = await forecastController.getForecastData(cityname);

    model.forecastData = forecastdata;
    model.historyData = historydata;
    combineData();
  }

  void combineData() {
    model.completeData.clear();

    if (model.historyData != null &&
        model.historyData!['forecast'] != null &&
        model.historyData!['forecast']['forecastday'] != null) {
      print("History Data Got");
      model.completeData.addAll(
          List<Map<String, dynamic>>.from(model.historyData!['forecast']['forecastday']));
    }
    if (model.forecastData != null &&
        model.forecastData!['forecast'] != null &&
        model.forecastData!['forecast']['forecastday'] != null) {
      print("Forecast Data Got");
      model.completeData.addAll(
          List<Map<String, dynamic>>.from(model.forecastData!['forecast']['forecastday']));
    }
    if (model.completeData.isNotEmpty) {
      model.hourlyData = model.completeData[model.hrindex]['hour'];
    }
    update();
  }

  void updateindex(int newindex) {
    model.hrindex = newindex;
    if (model.completeData.isNotEmpty) {
      model.hourlyData = model.completeData[model.hrindex]['hour'];
    }
    update();
  }
}