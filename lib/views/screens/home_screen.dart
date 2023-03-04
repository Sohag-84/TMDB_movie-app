// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../pages/movie/movie_home.dart';
import '../pages/tv_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  Widget getView() {
    if (currentIndex == 0) {
      return MovieHome();
    } else {
      return TvHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 94, 91, 91),
      appBar: AppBar(
        title: Text("Movie App"),
        centerTitle: true,
      ),
      body: getView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          currentIndex = value;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movie"),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: "TV"),
        ],
      ),
    );
  }
}
