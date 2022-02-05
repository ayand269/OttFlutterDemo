import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  String imagePath = "";
  String title = "";
  CategoryCard({required String imagePath, required String title}) {
    this.imagePath = imagePath;
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: ClipRRect(
        // borderRadius: BorderRadius.all(Radius.circular(8)),
        child: Container(
          // color: Color(Colors.red.value),
          height: 90,
          width: 160,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 70,
                decoration: BoxDecoration(
                    color: Color(Colors.white.value),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x88DE1029),
                          offset: Offset(0, 10),
                          blurRadius: 8)
                    ]),
              ),
              Container(
                height: 70,
                width: 160,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: Stack(
                    children: [
                      Image(
                        image: AssetImage("assets/$imagePath"),
                        height: 70,
                        width: 170,
                        fit: BoxFit.fill,
                      ),
                      Container(
                        color: Color(0xAADE1029),
                        height: 70,
                        width: 160,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          title.toUpperCase(),
                          style: TextStyle(
                              color: Color(Colors.white.value),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.3),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
