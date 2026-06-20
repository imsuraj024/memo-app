import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_app/config/arguments.dart';
import 'package:memo_app/config/shared_pref.dart';
import 'package:memo_app/firebase_options.dart';
import 'package:memo_app/home/home_controller.dart';
import 'package:memo_app/home/home_screen.dart';
import 'package:memo_app/login/login_binding.dart';
import 'package:memo_app/login/login_screen.dart';
import 'package:memo_app/project/project_list_screen.dart';
import 'package:memo_app/project/subcategory_list_screen.dart';

late FirebaseApp app;
late FirebaseAuth auth;
late FirebaseFirestore firestore;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPref sharedPref = SharedPref.instance;
  await sharedPref.init();
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  auth = FirebaseAuth.instanceFor(app: app);
  firestore = FirebaseFirestore.instanceFor(app: app);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginScreen(), binding: LoginBinding()),
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
          binding: BindingsBuilder(() {
            Get.put<HomeController>(HomeController());
          }),
        ),
        GetPage(
          name: '/project_list',
          page: () => ProjectListScreen(name: '', imageUrl: '', id: ''),
        ),
        GetPage(
          name: '/subcategory_list',
          page: () => SubcategoryListScreen(
            args: SubCategoryArguments(
              parentId: '',
              title: '',
              parentImage: '',
            ),
          ),
        ),
      ],
    );
  }
}
