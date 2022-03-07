import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ott_demo/src/components/Header/SearchHeader.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Container(
            color: Colors.white,
            height: height,
            width: width,
            child: SafeArea(
                child: Column(
              children: <Widget>[
                SearchHeader(
                  onChangeText: (value) {
                    print(value);
                  },
                ),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                offset: Offset(0, 5),
                                blurRadius: 10)
                          ]),
                      child: Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image(
                              image: AssetImage("assets/cat1.jpg"),
                              height: 100,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                "Shefali Das",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                offset: Offset(0, 5),
                                blurRadius: 10)
                          ]),
                      child: Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image(
                              image: AssetImage("assets/cat1.jpg"),
                              height: 100,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                "Shefali Das",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                offset: Offset(0, 5),
                                blurRadius: 10)
                          ]),
                      child: Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image(
                              image: AssetImage("assets/cat1.jpg"),
                              height: 100,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                "Shefali Das",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                offset: Offset(0, 5),
                                blurRadius: 10)
                          ]),
                      child: Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image(
                              image: AssetImage("assets/cat1.jpg"),
                              height: 100,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                "Shefali Das",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                offset: Offset(0, 5),
                                blurRadius: 10)
                          ]),
                      child: Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image(
                              image: AssetImage("assets/cat1.jpg"),
                              height: 100,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                "Shefali Das",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
              ],
            )),
          )),
    );
  }
}
