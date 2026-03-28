
import 'package:flutter/material.dart';
import 'package:memo_app/widgets/my_button.dart';

class MyCard extends StatefulWidget {
  const MyCard({
    super.key,
  });

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: Card(
            color: Colors.lightBlue,
            child: Row(
              children: [
                Expanded(child: Container(color: Colors.yellow,)),
                Expanded(
                  child: Column(
                    mainAxisAlignment: .spaceEvenly,
                    children: [
                      Text('Software Projects', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: OutlinedButton.icon(onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        }, label: Text(isExpanded ? 'Show Less' : 'Show More', style: TextStyle(color: Colors.white),),icon: Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down, 
                        size: 20, color: Colors.white,),
                        style: ButtonStyle(side: WidgetStateProperty.all(BorderSide(color: Colors.white),),),
                      )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        isExpanded ? SizedBox(
          height: 400,
          child: Column(
            children: [
              MyButton(name: 'Android',icons: Icons.lock_clock ,() => print('Android Button Tapped'),),
              MyButton(name: 'iOS',icons: Icons.alarm ,() => print('iOS Button Tapped')),
              MyButton(name: 'Python',icons: Icons.watch_rounded ,() => print('Python Button Tapped')),
              MyButton(name: 'Flutter',icons: Icons.abc ,() => print('Flutter Button Tapped')),
            
            ],
          ),
        ) : SizedBox.shrink()
      ],
    );
  }
}