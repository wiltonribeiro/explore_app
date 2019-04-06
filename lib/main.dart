import 'package:flutter/material.dart';
import 'package:explore_flutter/views/Home.dart';
import 'package:explore_flutter/views/Favorites.dart';
import 'components/CustomBottomNavBar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  _MyApp createState() => new _MyApp();
}

class _MyApp extends State<MyApp> {

  int _currentIndex = 0;
  List<Widget> _views = [
    new Home(),
    new Favorites(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explorer',
      theme: ThemeData(
        fontFamily: 'VarelaRound',
        primaryColor: Colors.black,
      ),
      home: new Scaffold(
          body: _views[_currentIndex],
          bottomNavigationBar: new CustomBottomNavBar(onTap: (i){_updateIndex(i);}, items: [
            new CustomItemBottomNavBar(icon: Icons.explore, label: "Explore"),
            new CustomItemBottomNavBar(icon: Icons.favorite, label: "Favorites")
          ]),
      ),
    );
  }


  void _updateIndex(int index){
    setState(() {
      _currentIndex = index;
    });
  }
}

