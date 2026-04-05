import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:memo_app/config/api_client.dart';
import 'package:memo_app/config/api_response.dart';
import 'package:memo_app/config/arguments.dart';
import 'package:memo_app/project/project_list_screen.dart';

class SubcategoryListScreen extends StatelessWidget {
  SubcategoryListScreen({super.key, required this.args});

  final SubCategoryArguments args;

  final ApiClient apiClient = ApiClient();

  Future<List<SubCategory>> getChildData(String parentId) async {
    final response = await apiClient.get(
      'v3/memo_projects/memo_projects_child_category_list',
      {'parent_id': parentId},
    );
    final List list = jsonDecode(response.data);
    List<SubCategory> subCategoryList = [];
    list.forEach((element) {
      subCategoryList.add(SubCategory.fromJson(element));
    });
    return subCategoryList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PROJECTS'), centerTitle: true),
      body: Column(
        spacing: 16,
        children: [
          Image.network(
            args.parentImage,
            width: double.infinity,
            height: 200,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) =>
                FlutterLogo(size: 200),
          ),
          Expanded(
            child: FutureBuilder(
              future: getChildData(args.parentId),
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
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.white,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProjectListScreen(
                                  name:
                                      asyncSnapshot.data![index].catName ??
                                      "Unknown",
                                ),
                              ),
                            );
                          },
                          leading: Image.network(
                            asyncSnapshot.data![index].catImg ?? "",
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                FlutterLogo(size: 100),
                          ),
                          title: Text(
                            asyncSnapshot.data![index].catName ?? "Unknown",
                          ),
                        ),
                      ),
                      itemCount: asyncSnapshot.data!.length,
                    );
                  }
                }
                return Container(color: Colors.amber);
              },
            ),
          ),
        ],
      ),
    );
  }
}
