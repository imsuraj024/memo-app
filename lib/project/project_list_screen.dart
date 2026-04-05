import 'package:flutter/material.dart';

class ProjectListScreen extends StatelessWidget {
  const ProjectListScreen({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name.toUpperCase()), centerTitle: true),
    );
  }
}
