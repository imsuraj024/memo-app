
import 'package:flutter/material.dart';
import 'package:memo_app/widgets/my_button.dart';

class MyCard extends StatefulWidget {
  const MyCard({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  final String title;
  final String imageUrl;

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
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.white,
            child: Row(
              spacing: 10,
              children: [
                Expanded(child: Image.network(widget.imageUrl, 
                loadingBuilder: (context, child, loadingProgress){
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator(),);
                },errorBuilder: (context, error, stackTrace) => Center(child: FlutterLogo(size: 80,),),),
              ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: .spaceEvenly,
                    children: [
                      Text(widget.title, style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: OutlinedButton.icon(onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        }, label: Text(isExpanded ? 'Show Less' : 'Show More', style: TextStyle(color: Colors.black),),icon: Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down, 
                        size: 20, color: Colors.black,),
                        style: ButtonStyle(side: WidgetStateProperty.all(BorderSide(color: Colors.black),),),
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