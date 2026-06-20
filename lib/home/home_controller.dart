import 'dart:convert';

import 'package:get/get.dart';
import 'package:memo_app/config/api_client.dart';
import 'package:memo_app/config/api_response.dart';
import 'package:memo_app/config/shared_pref.dart';

class HomeController extends GetxController {
  ApiClient apiClient = ApiClient();
  SharedPref sharedPref = SharedPref.instance;
  RxList<CategoryList> categoryList = <CategoryList>[].obs;

  @override
  onInit() {
    super.onInit();
    sharedPref.setKeyValue('screen', 'Home');
  }

  Future<void> getData() async {
    await Future.delayed(Duration(seconds: 2));
    final response = await apiClient.get(
      'v3/memo_projects/memo_projects_parent_category_list',
      null,
    );
    final List list = jsonDecode(response.data);

    for (var element in list) {
      categoryList.add(CategoryList.fromJson(element));
    }
  }
}
