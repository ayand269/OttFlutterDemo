import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ott_demo/src/Redux/Store/index.dart';
import 'package:ott_demo/src/components/Card/ChatListCard.dart';
import 'package:ott_demo/src/components/Header/ChatHeader.dart';
import 'package:simple_moment/simple_moment.dart';

class ChatListModel {
  final String name;
  final String image;
  final String roomId;
  final String remoteUserId;
  String lastMsg = '';
  String lastMsgTime = '';
  bool unseen = false;
  int unseenMsgCount = 0;

  ChatListModel(
      {required this.name,
      required this.image,
      required this.roomId,
      required this.remoteUserId,
      this.lastMsg = '',
      this.lastMsgTime = '',
      this.unseen = false,
      this.unseenMsgCount = 0});

  ChatListModel.fromSnapshot({required Map<dynamic, dynamic> value})
      : this.name = value['name'],
        this.image = value['image'],
        this.roomId = value['roomId'],
        this.remoteUserId = value['username'],
        this.lastMsg = value['lastMsg'] ?? '',
        this.lastMsgTime = value['lastMsgTime'] ?? '',
        this.unseen = value['unseen'] ?? false,
        this.unseenMsgCount = value['unseenMsgCount'] ?? 0;
}

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  FirebaseDatabase db = FirebaseDatabase.instance;
  List<ChatListModel> _allChatList = [];
  var chatListChildChangedListener;

  @override
  void initState() {
    super.initState();

    initChatList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    chatListChildChangedListener?.cancel();
  }

  void initChatList() async {
    Map<String, dynamic> userData =
        StoreProvider.of<AppState>(context, listen: false)
            .state
            .userState
            .userData;
    final fbEvent = await db.ref("/ChatList/${userData['username']}").once();

    if (fbEvent.snapshot.exists) {
      Map<dynamic, dynamic> value =
          Map<dynamic, dynamic>.from(fbEvent.snapshot.value as Map);

      value.forEach((key, value) {
        _allChatList.add(ChatListModel.fromSnapshot(value: value));
        setState(() {});
      });
      receiveChat(userData['username']);
    } else {}
  }

  void receiveChat(String myUserId) {
    chatListChildChangedListener =
        db.ref("/ChatList/$myUserId").onChildChanged.listen((event) {
      Map<dynamic, dynamic> value =
          Map<dynamic, dynamic>.from(event.snapshot.value as Map);

      final index = _allChatList
          .indexWhere((element) => element.remoteUserId == value['username']);

      if (index >= 0) {
        _allChatList[index].lastMsg = value['lastMsg'] ?? '';
        _allChatList[index].lastMsgTime = value['lastMsgTime'] ?? '';
        _allChatList[index].unseen = value['unseen'] ?? false;
        _allChatList[index].unseenMsgCount = value['unseenMsgCount'] ?? 0;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          color: Colors.white,
          child: SafeArea(
            bottom: false,
            child: Column(
              children: <Widget>[
                ChatHeader(title: "Chats"),
                Expanded(
                    flex: 1,
                    child: Container(
                      color: Color(0xFFf9fdfe),
                      child: ListView(
                        children: _allChatList
                            .map((item) => ChatListCard(
                                  unseen: item.unseen,
                                  unseenMsgCount:
                                      item.unseenMsgCount.toString(),
                                  name: item.name,
                                  description: item.lastMsg,
                                  imageUrl: item.image,
                                  time: item.lastMsgTime != ''
                                      ? Moment.parse(
                                              DateTime.parse(item.lastMsgTime)
                                                  .toLocal()
                                                  .toString())
                                          .format("hh:mm a")
                                      : '',
                                  remoteUserId: item.remoteUserId,
                                  roomId: item.roomId,
                                ))
                            .toList(),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
