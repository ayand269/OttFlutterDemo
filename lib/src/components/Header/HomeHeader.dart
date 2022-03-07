import 'package:flutter/material.dart';
import 'package:ott_demo/src/Router/route.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: statusBarHeight + 15),
      height: 55 + statusBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(
                Icons.menu,
                color: Color(Colors.black87.value),
              )),
          Image(
            image: AssetImage("assets/logo.png"),
            height: 25,
          ),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.search);
              },
              icon: Icon(
                Icons.search,
                color: Color(Colors.black87.value),
              ))
        ],
      ),
    );
  }
}
