import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathertest/screens/search/search_model.dart';
import 'package:weathertest/service/api_services.dart';
import 'package:weathertest/service/db_service.dart';


class CitysearchController extends GetxController {
  var model = CitysearchModel().obs;
  var searchController = TextEditingController();
  var isReady = false.obs;
  var isRecentReady = false.obs;
  var recentSearch = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRecentSearch();
  }

  void fetchRecentSearch() async {
    recentSearch.value = await DbService().fetchDatafromDB();
    isRecentReady.value = false;
    print("I am in controller");
  }

  void getSearchResult(String searchQuery) {
    ApiServices().searchCity(searchQuery).then((searchVal) {
      model.update((val) {
        val?.resultList.assignAll(searchVal??[]);
        // val?.resultList = searchVal;
        isReady.value = false;
      });
    });
  }
}
