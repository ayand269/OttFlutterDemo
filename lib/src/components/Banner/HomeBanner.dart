import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeBanner extends StatelessWidget {
  List bannerData = [];
  HomeBanner({required List bannerData}) {
    this.bannerData = bannerData;
  }
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      child: CarouselSlider(
          items: bannerData
              .map((item) => Container(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 0),
                      child: ClipRRect(
                          // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          child: Stack(
                        alignment: Alignment.centerLeft,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            height: 180,
                            decoration: BoxDecoration(
                                color: Color(Colors.black.value),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.3),
                                      offset: Offset(0, 10),
                                      blurRadius: 8),
                                ]),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image(
                              image: AssetImage("assets/banner1.jpg"),
                              fit: BoxFit.cover,
                              width: 1000,
                              height: 180,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, bottom: 25),
                            width: (width * 50) / 100,
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "The Nutcracker And The Four Realms"
                                  .toUpperCase(),
                              style: TextStyle(
                                color: Color(Colors.white.value),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      )),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
              enlargeCenterPage: true,
              initialPage: 1,
              height: 220,
              viewportFraction: 0.8)),
    );
  }
}
