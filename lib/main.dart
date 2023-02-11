import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'app_screens/home.dart';
import 'app_screens/favourites.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
  
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  Widget bodyFunction(){
    switch (_currentIndex){
      case 0: return Home();break;
      case 1: return Favourites();break;
    }
    return Container(color: Colors.white,);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme : ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Jobs & Interviews"),
          
        ),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState((){
            _currentIndex = i;
          }),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home_outlined,size: 30.0,), 
              title: const Text("Home"),
              activeIcon: const Icon(Icons.home,size: 30.0,),
              selectedColor: Colors.lightBlue
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.star_border,size: 30.0,),
              title: const Text("Favourites"),
              activeIcon: const Icon(Icons.star,size: 30.0,),
              selectedColor: Colors.lightGreen,
            ),
          ]
        ),
        body: bodyFunction(),
      ),
    );
  }

}