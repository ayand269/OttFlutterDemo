import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:ott_demo/src/Router/route.dart';
import 'package:ott_demo/src/screens/Home/index.dart';
import 'package:ott_demo/src/screens/Movies/SingleMovies.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => Home(),
        MyRoutes.home: (context) => Home(),
        MyRoutes.singleMovies: (context) => SingleMovies()
      },
      // themeMode: ThemeMode.dark,
      // darkTheme: ThemeData(brightness: Brightness.dark),
    );
  }
}
