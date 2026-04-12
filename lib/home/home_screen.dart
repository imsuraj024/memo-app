import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:memo_app/config/api_client.dart';
import 'package:memo_app/config/api_response.dart';
import 'package:memo_app/config/shared_pref.dart';
import 'package:memo_app/widgets/my_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiClient apiClient = ApiClient();
  SharedPref sharedPref = SharedPref.instance;

  Future<List<CategoryList>?> getData() async {
    await Future.delayed(Duration(seconds: 2));
    final response = await apiClient.get(
      'v3/memo_projects/memo_projects_parent_category_list',
      null,
    );
    final List list = jsonDecode(response.data);

    List<CategoryList> categoryList = [];
    list.forEach((element) {
      categoryList.add(CategoryList.fromJson(element));
    });

    return categoryList;
  }

  @override
  void initState() {
    super.initState();
    sharedPref.setKeyValue('screen', 'Home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MEMO PROJECTS'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (asyncSnapshot.hasError) {
            return Center(child: Text(asyncSnapshot.error.toString()));
          }

          if (asyncSnapshot.data != null && asyncSnapshot.hasData) {
            if (asyncSnapshot.data!.isEmpty) {
              return Center(child: Text('Data empty'));
            } else {
              return ListView.builder(
                itemBuilder: (context, index) => MyCard(
                  title: asyncSnapshot.data![index].catName ?? "Unknown",
                  imageUrl: asyncSnapshot.data![index].catImage ?? "",
                  parentId: asyncSnapshot.data![index].id ?? "",
                ),
                itemCount: asyncSnapshot.data!.length,
              );
            }
          }
          return Container(color: Colors.amber);
        },
      ),
    );
  }
}
