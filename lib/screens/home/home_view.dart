import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathertest/routes/app_routes.dart';
import 'package:weathertest/screens/home/home_controller.dart';
import 'package:weathertest/screens/search/search_view.dart';
import 'package:weathertest/theme/colors.dart';
import 'package:weathertest/utils/date_formatter.dart';


class HomeView extends StatelessWidget {
  final String cityName;
  late String city = '';

  HomeView({super.key, required this.cityName});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: AppColors.blue,
      appBar: AppBar(
        backgroundColor: AppColors.bluetransparent,
        leading: const Icon(
          Icons.pin_drop,
          size: 30,
          color: Colors.white,
        ),
        title: InkWell(
          child: Row(
            children: [
              Obx(() {
                // print("obx :${controller.model.cityWeatherModel.value.location?.name}");
                city = controller.model.cityWeatherModel.value.location?.name
                        ?.toString() ??
                    'mumbai';
                return Text(
                  controller.model.cityWeatherModel.value.location?.name
                          ?.toString() ??
                      'mumbai',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                );
              }),
              const SizedBox(width: 10),
              const Icon(
                Icons.arrow_drop_down_sharp,
                size: 40,
                color: Colors.white,
              )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CitysearchView()),
              );
            },
            child: const Icon(
              Icons.search,
              size: 35,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Obx(() {
        return controller.model.isReady.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, AppColors.bluetransparent],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [0.4, 0.7],
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: ListView(
                  children: [
                    const SizedBox(height: 50),
                    if (controller.model.cityWeatherModel.value.current
                            ?.condition?.icon !=
                        null)
                      Image.network(
                        "https:${controller.model.cityWeatherModel.value.current!.condition!.icon.toString()}",
                        width: 400,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Opacity(
                        opacity: 0.3,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.5),
                                  spreadRadius: 4,
                                  blurRadius: 5,
                                  offset: const Offset(0, 5),
                                ),
                              ]),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              if (controller.model.cityWeatherModel.value
                                      .location?.localtime !=
                                  null)
                                Text(
                                  "Today ${DateFormater().DateFormaterfunction(controller.model.cityWeatherModel.value.location!.localtime.toString())}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              const SizedBox(height: 5),
                              if (controller.model.cityWeatherModel.value
                                      .current?.tempC !=
                                  null)
                                Text(
                                  "${controller.model.cityWeatherModel.value.current!.tempC!.toInt().toString()}\u00B0",
                                  style: const TextStyle(
                                      fontSize: 80, color: Colors.black),
                                ),
                              if (controller.model.cityWeatherModel.value
                                      .current?.condition?.text !=
                                  null)
                                Text(
                                  controller.model.cityWeatherModel.value
                                      .current!.condition!.text
                                      .toString(),
                                  style: const TextStyle(fontSize: 22),
                                ),
                              const SizedBox(height: 30),
                              if (controller.model.cityWeatherModel.value
                                      .current?.windKph !=
                                  null)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.wind_power),
                                    const SizedBox(width: 20),
                                    const Text("Wind     |  ",
                                        style: TextStyle(fontSize: 18)),
                                    Text(
                                      "${controller.model.cityWeatherModel.value.current?.windKph.toString()} Km/h",
                                      style: const TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                              const SizedBox(height: 20),
                              if (controller.model.cityWeatherModel.value
                                      .current?.humidity !=
                                  null)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.water_drop),
                                    const SizedBox(width: 2),
                                    const Text("Hum        |          ",
                                        style: TextStyle(fontSize: 18)),
                                    Text(
                                      "${controller.model.cityWeatherModel.value.current?.humidity.toString()} %",
                                      style: const TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                              const SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          print("City name:${cityName}");
                          if (controller.model.cityWeatherModel.value.location
                                  ?.name !=
                              null) {
                            Get.toNamed(Routes.forecast,
                                parameters: {'cityName': city});
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            side: const BorderSide(
                              color: Colors.white60,
                              width: 2,
                            ),
                            fixedSize: const Size(190, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                        child: const Row(
                          children: [
                            Text("Forecast Report   ",
                                style: TextStyle(color: Colors.white)),
                            Icon(Icons.arrow_drop_up, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
