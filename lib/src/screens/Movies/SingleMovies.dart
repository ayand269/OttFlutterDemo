import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ott_demo/src/Utils/Arguments.dart';
import 'package:ott_demo/src/components/Lists/CardListWithTitle.dart';
import 'package:ott_demo/src/components/ShadowClipPath.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SingleMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final movieDetails =
        ModalRoute.of(context)!.settings.arguments as SingleMovieArguments;
    // print("movieDetails" + movieDetails.toString());
    return Scaffold(
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: movieDetails.statusBar == 'light'
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(overflow: Overflow.visible, children: <Widget>[
                  ClipShadowPath(
                    shadow: Shadow(
                        color: Color.fromRGBO(0, 0, 0, 0.4),
                        offset: Offset(0, 10),
                        blurRadius: 15),
                    clipper: ClippingClass(),
                    child: Image(
                      height: 400,
                      width: width,
                      image: AssetImage("assets/" + movieDetails.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: statusBarHeight,
                    child: Container(
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: movieDetails.statusBar == 'light'
                                      ? Colors.white
                                      : Colors.black,
                                )),
                            Image(
                              image: AssetImage("assets/logo.png"),
                              height: 25,
                            ),
                            IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: movieDetails.statusBar == 'light'
                                      ? Colors.white
                                      : Colors.black,
                                )),
                          ],
                        )),
                  ),
                  Positioned(
                    bottom: -16,
                    left: (width / 2) - 35,
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          color: Colors.white,
                          shadows: [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.4),
                                offset: Offset(0, 5),
                                blurRadius: 20)
                          ]),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        size: 50,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: -20,
                      left: 15,
                      child: IconButton(
                          iconSize: 30,
                          onPressed: null,
                          icon: Icon(
                            Icons.add,
                            color: Colors.black87,
                          ))),
                  Positioned(
                      bottom: -20,
                      right: 15,
                      child: IconButton(
                          iconSize: 25,
                          onPressed: null,
                          icon: Icon(
                            Icons.share,
                            color: Colors.black87,
                          )))
                ]),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Text(
                    movieDetails.name.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 13),
                  child: Text(
                    movieDetails.type,
                    style: TextStyle(color: Colors.black45),
                  ),
                ),
                RatingBarIndicator(
                    rating: movieDetails.rating,
                    unratedColor: Colors.black87,
                    itemSize: 30,
                    itemBuilder: (context, index) => Icon(
                          Icons.star_rate_rounded,
                          color: Colors.red,
                        )),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "Year",
                            style: TextStyle(color: Colors.black54),
                          ),
                          Text(
                            "2018",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 45),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Country",
                              style: TextStyle(color: Colors.black54),
                            ),
                            Text(
                              "USA",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "Length",
                            style: TextStyle(color: Colors.black54),
                          ),
                          Text(
                            "112 min",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      movieDetails.description,
                      textAlign: TextAlign.justify,
                    )),
                CardListWithTitle(
                  title: "Screenshots",
                  listData: movieDetails.screenshoots,
                  onPress: null,
                  height: 130,
                  width: 210,
                  netImage: true,
                )
              ],
            ),
          ),
        ));
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, 330);
    path.cubicTo((size.width / 3) * 2, 400, size.width / 3, 400, 0, 330);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
