import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:memo_app/home/home_controller.dart';
import 'package:memo_app/widgets/my_card.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MEMO PROJECTS'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Obx(
        () => controller.categoryList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : (kIsWeb || MediaQuery.of(context).size.width > 600)
            ? GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.5,
                ),
                itemBuilder: (context, index) => MyCard(
                  title: controller.categoryList[index].catName ?? "Unknown",
                  imageUrl: controller.categoryList[index].catImage ?? "",
                  parentId: controller.categoryList[index].id ?? "",
                ),
                itemCount: controller.categoryList.length,
              )
            : ListView.builder(
                itemBuilder: (context, index) => MyCard(
                  title: controller.categoryList[index].catName ?? "Unknown",
                  imageUrl: controller.categoryList[index].catImage ?? "",
                  parentId: controller.categoryList[index].id ?? "",
                ),
                itemCount: controller.categoryList.length,
              ),
      ),
    );
  }
}
