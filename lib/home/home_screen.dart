import 'package:flutter/material.dart';
import 'package:memo_app/config/api_client.dart';
import 'package:memo_app/widgets/my_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ApiClient apiClient = ApiClient();

  @override
  void initState() {
    super.initState();
    apiClient.get('v3/memo_projects/memo_projects_parent_category_list', null);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MEMO PROJECTS'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyCard(),
            MyCard(),
          ],
        ),
      ),
    );
  }
}


