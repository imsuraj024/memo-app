import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(this.action,{
    super.key,required this.name,required this.icons,
  });

  final String name;
  final IconData icons;
  final void Function() action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Column(
        children: [
          Icon(icons, size: 60,),
          Text(name, style: TextStyle(fontSize: 20),),
        ],
      ),
    );
  }
}