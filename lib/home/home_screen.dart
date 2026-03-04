import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: Card(
        color: Colors.lightBlue,
        child: Row(
          children: [
            Container(height: 200, width: 250,color: Colors.yellow,),
            SizedBox(height: 200,width: 150, child: Column(
              mainAxisAlignment: .spaceEvenly,
              children: [
                Text('Software Projects', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: OutlinedButton.icon(onPressed: () {
                  }, label: Text('Show more', style: TextStyle(color: Colors.white),),icon: Icon(Icons.arrow_drop_down, 
                  size: 20, color: Colors.white,),
                  style: ButtonStyle(side: WidgetStateProperty.all(BorderSide(color: Colors.white),),),
                )
                ),
              ],
            ),),
          ],
        ),
      ),
    );
  }
}