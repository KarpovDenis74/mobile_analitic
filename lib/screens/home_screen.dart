import 'package:flutter/material.dart';


class HomeScreenRSS extends StatefulWidget{
  const HomeScreenRSS({super.key});
  @override
  HomeScreenRSSState createState() => HomeScreenRSSState();
}

class HomeScreenRSSState extends State {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Поиск товаров по маркетплейсам'),
        )
      )
    );
  }
}