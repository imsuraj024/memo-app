import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:memo_app/config/api_client.dart';
import 'package:memo_app/config/api_response.dart';
import 'package:memo_app/config/arguments.dart';
import 'package:memo_app/project/project_list_screen.dart';
import 'package:memo_app/project/subcategory_list_screen.dart';
import 'package:memo_app/widgets/my_button.dart';

class MyCard extends StatefulWidget {
  const MyCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.parentId,
  });

  final String title;
  final String imageUrl;
  final String parentId;

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  bool isExpanded = false;
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
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SubcategoryListScreen(
                  args: SubCategoryArguments(
                    parentId: widget.parentId,
                    title: widget.title,
                    parentImage: widget.imageUrl,
                  ),
                ),
              ),
            );
          },
          child: SizedBox(
            height: 200,
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.white,
              child: Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: Image.network(
                      widget.imageUrl,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          Center(child: FlutterLogo(size: 80)),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: .spaceEvenly,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            label: Text(
                              isExpanded ? 'Show Less' : 'Show More',
                              style: TextStyle(color: Colors.black),
                            ),
                            icon: Icon(
                              isExpanded
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              size: 20,
                              color: Colors.black,
                            ),
                            style: ButtonStyle(
                              side: WidgetStateProperty.all(
                                BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        isExpanded
            ? FutureBuilder(
                future: getChildData(widget.parentId),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState ==
                      ConnectionState.waiting) {
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
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ListTile(
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
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                FlutterLogo(size: 50),
                          ),
                          title: Text(
                            asyncSnapshot.data![index].catName ?? "Unknown",
                          ),
                        ),
                        itemCount: asyncSnapshot.data!.length,
                      );
                    }
                  }
                  return Container(color: Colors.amber);
                },
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
