import 'package:flutter/material.dart';

class CardListWithTitle extends StatelessWidget {
  String listTitle = "";
  List<Map<String, dynamic>> listData = [{}];
  double listHeight = 0;
  double listWidth = 0;
  bool netImage = false;
  final void Function(Map<String, dynamic>)? onPress;

  CardListWithTitle(
      {required String title,
      required List<Map<String, dynamic>> listData,
      double height = 200,
      double width = 150,
      bool netImage = false,
      required this.onPress}) {
    this.listTitle = title;
    this.listData = listData;
    this.listHeight = height;
    this.listWidth = width;
    this.netImage = netImage;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                listTitle,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(Colors.black87.value)),
              ),
              IconButton(
                  onPressed: null,
                  icon: Icon(Icons.arrow_forward_rounded,
                      color: Color(Colors.black87.value)))
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            height: listHeight + 20,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.all(Radius.circular(10)),
            // ),
            // clipBehavior: Clip.antiAliasWithSaveLayer,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 5, right: 10),
              shrinkWrap: true,
              children: listData
                  .map((item) => GestureDetector(
                      onTap: () {
                        if (onPress != null) {
                          onPress!(item);
                        }
                      },
                      child: Container(
                          width: listWidth,
                          margin: EdgeInsets.only(left: 20),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                // color: Color(Colors.black87.value),
                                height: listHeight,
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      color: Color(0x4D000000),
                                      offset: Offset(0, 10),
                                      blurRadius: 10)
                                ], color: Color(Colors.black87.value)),
                              ),
                              Container(
                                height: listHeight,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: netImage
                                    ? Image.network(
                                        item['image'],
                                        height: listHeight,
                                        width: listWidth,
                                        fit: BoxFit.cover,
                                      )
                                    : Image(
                                        image: AssetImage(
                                            "assets/" + item['image']),
                                        height: listHeight,
                                        width: listWidth,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ],
                          ))))
                  .toList(),
            ))
      ],
    );
  }
}
