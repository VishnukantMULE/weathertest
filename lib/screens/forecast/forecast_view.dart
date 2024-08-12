import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathertest/screens/forecast/forecast_controller.dart';
import 'package:weathertest/screens/home/home_view.dart';
import 'package:weathertest/theme/colors.dart';
import 'package:weathertest/utils/date_formatter.dart';

class ForecastView extends StatelessWidget {

  const ForecastView({super.key});
  @override
  Widget build(BuildContext context) {
    // final String cityName=Get.parameters['cityName']??'mumbai';

    // final ForecastController controller = Get.put(ForecastController(cityName));
    final controller=Get.find<ForecastController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bluetransparent,
        title: Text(
          " ${controller.cityname}",
          style: const TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 180,
                child: GetBuilder<ForecastController>(
                  builder: (controller) {
                    if (controller.model.forecastData == null) {
                      return const Center(
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.model.hourlyData.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white70,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "${controller.model.hourlyData[index]["temp_c"].toString()} \u2103",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white38,
                                          border: Border.all(
                                            color: Colors.white30,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Image.network(
                                        "https:${controller.model.hourlyData[index]["condition"]["icon"]}",
                                      ),
                                    ),
                                    Text(
                                      DateFormater().getTimeAMPM(controller
                                          .model.hourlyData[index]["time"]),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Next and Current ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white38),
                    borderRadius: BorderRadius.circular(10)),
                height: 400,
                width: MediaQuery.of(context).size.width,
                child: Scrollbar(
                  thickness: 5,
                  radius: const Radius.circular(20),
                  child: GetBuilder<ForecastController>(
                    builder: (controller) {
                      if (controller.model.forecastData == null) {
                        return const Center(
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: controller.model.completeData.length,
                          itemBuilder: (context, index) {
                            return TextButton(
                              onPressed: () {
                                controller.updateindex(index);
                              },
                              child: Container(
                                decoration: index == controller.model.hrindex
                                    ? BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white38,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      )
                                    : const BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      DateFormater().DateFormateforforecast(
                                          controller.model.completeData[index]
                                              ["date"]),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white30,
                                            border: Border.all(
                                              color: Colors.white30,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Image.network(
                                          "https:${controller.model.completeData[index]["day"]["condition"]["icon"]}",
                                        ),
                                      ),
                                    ),
                                    Text(
                                      " ${controller.model.completeData[index]["day"]["avgtemp_c"].toString()} \u00B0",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
