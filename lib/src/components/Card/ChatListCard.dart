import 'package:flutter/material.dart';
import 'package:ott_demo/src/Router/route.dart';
import 'package:ott_demo/src/Utils/Arguments.dart';

class ChatListCard extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;
  final String time;
  final String remoteUserId;
  final String roomId;
  final bool unseen;
  final String unseenMsgCount;

  ChatListCard(
      {required this.name,
      required this.description,
      required this.imageUrl,
      required this.time,
      required this.remoteUserId,
      required this.roomId,
      required this.unseen,
      required this.unseenMsgCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 85,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, MyRoutes.singleChat,
              arguments: SingleChatArguments(
                  name: name,
                  imageUrl: imageUrl,
                  roomId: roomId,
                  remoteUserId: remoteUserId));
        },
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    bottom: 1,
                    right: 1,
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(7.5)),
                          color: Colors.green,
                          border: Border.all(width: 3, color: Colors.white)),
                    ))
              ],
            ),
            Expanded(
                flex: 1,
                child: Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w400),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              time,
                              style: TextStyle(
                                  color: unseen ? Colors.blue : Colors.black26),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.only(right: 12),
                                child: Text(
                                  description,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              )),
                          Visibility(
                            visible: unseen,
                            child: Container(
                              alignment: Alignment.center,
                              height: 20,
                              width: 20,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Text(
                                unseenMsgCount,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
