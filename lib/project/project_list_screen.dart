import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:memo_app/config/api_client.dart';
import 'package:memo_app/config/api_response.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.id,
  });

  final String name;
  final String imageUrl;
  final String id;

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  final ApiClient apiClient = ApiClient();

  Future<List<ProjectItem>> getChildData(String catId) async {
    final response = await apiClient.get(
      'v3/memo_projects/memo_projects_post_list',
      {'category_id': catId},
    );

    final List list = jsonDecode(response.data);

    if (list.first is String && list.first == "No data Found") {
      return [];
    }

    List<ProjectItem> projectItems = list
        .map((e) => ProjectItem.fromJson(e))
        .toList();

    return projectItems;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name.toUpperCase()), centerTitle: true),
      body: Column(
        children: [
          Image.network(
            widget.imageUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) =>
                FlutterLogo(size: 200),
          ),
          Expanded(
            child: FutureBuilder(
              future: getChildData(widget.id),
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
                      itemCount: asyncSnapshot.data!.length,
                      itemBuilder: (context, index) => ListTile(
                        leading: SizedBox(
                          height: 80,
                          width: 80,
                          child: Image.network(
                            fit: BoxFit.cover,
                            asyncSnapshot.data![index].images ?? "",
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(child: CircularProgressIndicator());
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                Center(child: FlutterLogo(size: 80)),
                          ),
                        ),
                        title: Text(
                          asyncSnapshot.data![index].title ?? "Unknown",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // subtitle: Html(
                        //   data:
                        //       asyncSnapshot.data![index].description ??
                        //       "No description",
                        // ),
                      ),
                    );
                  }
                }

                return Container(height: 100, color: Colors.amber);
              },
            ),
          ),
        ],
      ),
    );
  }
}
