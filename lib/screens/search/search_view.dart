import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathertest/screens/home/home_view.dart';
import 'package:weathertest/screens/search/search_controller.dart';
import 'package:weathertest/service/db_service.dart';
import 'package:weathertest/utils/date_formatter.dart';
import 'package:weathertest/utils/time_formatter.dart';

class CitysearchView extends StatelessWidget {
  const CitysearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final CitysearchController controller = Get.put(CitysearchController());

    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          child: const Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.blue,
        title:TextField(
          controller: controller.searchController,
          onChanged: controller.getSearchResult,
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              controller
                  .getSearchResult(controller.searchController.text);
            },
            child: const Icon(
              Icons.search,
              size: 35,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(children: <Widget>[
        Obx(() => controller.isReady.value
            ? Container(child: CircularProgressIndicator())
            : Expanded(
                child: ListView.builder(
                    itemCount: controller.recentSearch.length,
                    itemBuilder: (context, index) {
                      return TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeView(
                                      cityName: controller.recentSearch[index]
                                          ["cityname"])));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.black),
                                      text: controller.recentSearch[index]
                                          ["cityname"],
                                    )),
                              ),
                              Text(
                                TimeUtils()
                                    .TimeDifference(controller
                                        .recentSearch[index]["datetime"])
                                    .toString(),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              )),
        Obx(() => controller.isRecentReady.value
            ? Container(child: const CircularProgressIndicator())
            : Expanded(
                child: ListView.builder(
                  itemCount: controller.model.value.resultList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: TextButton(
                          onPressed: () {
                            controller.model.update((val) {
                              val?.searchCity = controller
                                  .model.value.resultList[index].name
                                  .toString();
                            });
                            DbService().insertDataInDB(
                                controller.model.value.searchCity,
                                DateFormater().DateTimeNow());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeView(
                                        cityName: controller
                                            .model.value.searchCity)));
                          },
                          child: Text(controller
                              .model.value.resultList[index].name
                              .toString())),
                    );
                  },
                ),
              ))
      ]),
    );
  }
}
