import 'package:flutter/material.dart';

class SearchHeader extends StatelessWidget {
  final void Function(String) onChangeText;
  SearchHeader({required this.onChangeText}) {}
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 55,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            padding: EdgeInsets.all(0),
          ),
          Container(
              // padding: EdgeInsets.only(left: 10),
              width: (width * 80) / 100,
              // height: 50,
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Search",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0)),
                    suffixIcon:
                        IconButton(onPressed: null, icon: Icon(Icons.search))),
                onChanged: (value) {
                  onChangeText(value);
                },
              ))
        ],
      ),
    );
  }
}
