import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ott_demo/src/Redux/Store/index.dart';
import 'package:ott_demo/src/Utils/Arguments.dart';
import 'package:uuid/uuid.dart';

class MessageModel {
  final String messageId;
  final String message;
  final String sender;
  final String sendTime;

  MessageModel(
      {required this.message,
      required this.sender,
      required this.sendTime,
      required this.messageId});

  MessageModel.fromSnapshot({required Map<dynamic, dynamic> value})
      : message = value['message'],
        sender = value['sender'],
        sendTime = value['sendTime'],
        messageId = value['msgId'];
}

class SingleChat extends StatefulWidget {
  const SingleChat({Key? key}) : super(key: key);

  @override
  _SingleChatState createState() => _SingleChatState();
}

class _SingleChatState extends State<SingleChat> {
  var fbMessageListener;
  TextEditingController _messageController = TextEditingController(text: '');
  String _message = '';
  FirebaseDatabase db = FirebaseDatabase.instance;
  late SingleChatArguments remoteUserdetails;
  Map<String, dynamic> _userData = {};

  List<MessageModel> _allMessage = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fbMessageListener?.cancel();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("bal");
    _userData = StoreProvider.of<AppState>(context).state.userState.userData;
    remoteUserdetails =
        ModalRoute.of(context)!.settings.arguments as SingleChatArguments;

    _seenAllMsg();
    initChat();
  }

  void _seenAllMsg() {
    Map<String, dynamic> _data = {"unseen": false, "unseenMsgCount": 0};
    db
        .ref(
            '/ChatList/${_userData["username"]}/${remoteUserdetails.remoteUserId}')
        .update(_data);
  }

  void initChat() async {
    final fbEvent =
        await db.ref("/Chat/${remoteUserdetails.roomId}/messages").once();
    if (fbEvent.snapshot.exists) {
      Map<dynamic, dynamic> value =
          Map<dynamic, dynamic>.from(fbEvent.snapshot.value as Map);

      value.forEach((key, value) {
        _allMessage.add(MessageModel.fromSnapshot(value: value));
        setState(() {});
      });

      _receiveChat();
    }
  }

  void _receiveChat() {
    fbMessageListener = db
        .ref('/Chat/${remoteUserdetails.roomId}/messages')
        .limitToLast(1)
        .onChildAdded
        .listen((event) {
      Map<dynamic, dynamic> value =
          Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      // print(_allMessage.length);
      final index = _allMessage
          .indexWhere((element) => element.messageId == value['msgId']);

      if (index == -1) {
        _seenAllMsg();
        _allMessage.add(MessageModel.fromSnapshot(value: value));
        setState(() {});
      }
    });
  }

  int _msgValid(String txt) {
    return txt.replaceAll(RegExp(r"\s+"), '').length;
  }

  void sendTextMsg() {
    if (_message != '' && _msgValid(_message) != 0) {
      Map<String, dynamic> smsdata = {
        "roomId": remoteUserdetails.roomId,
        "msgId": Uuid().v4(),
        "sender": _userData['username'],
        "message": _message,
        "sendTime": DateTime.now().toUtc().toString(),
      };

      final newReference =
          db.ref('/Chat/${remoteUserdetails.roomId}/messages').push().key;

      db
          .ref('/Chat/${remoteUserdetails.roomId}/messages/$newReference')
          .set(smsdata);

      Map<String, dynamic> chatListData = {
        "lastMsg": _message,
        "lastMsgTime": smsdata['sendTime'],
        "unseen": true,
        "unseenMsgCount": ServerValue.increment(1)
      };

      db
          .ref(
              '/ChatList/${remoteUserdetails.remoteUserId}/${_userData["username"]}')
          .update(chatListData);

      Map<String, dynamic> myChatListData = <String, dynamic>{};

      myChatListData['lastMsg'] = _message;
      myChatListData['lastMsgTime'] = smsdata['sendTime'];

      db
          .ref(
              '/ChatList/${_userData["username"]}/${remoteUserdetails.remoteUserId}')
          .update(myChatListData);

      _messageController.clear();
      setState(() {
        _message = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<MessageModel> sorted() {
      _allMessage.sort((a, b) =>
          DateTime.parse(a.sendTime).compareTo(DateTime.parse(b.sendTime)));
      return _allMessage;
    }

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          color: Colors.white,
          child: SafeArea(
            bottom: false,
            child: Column(
              children: <Widget>[
                Container(
                  height: 60,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          iconSize: 40,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.chevron_left_rounded,
                            size: 40,
                          )),
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 40,
                            width: 40,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Image.network(remoteUserdetails.imageUrl),
                          ),
                          Positioned(
                              bottom: 1,
                              right: 1,
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7.5)),
                                    color: Colors.green,
                                    border: Border.all(
                                        width: 2, color: Colors.white)),
                              ))
                        ],
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            padding:
                                EdgeInsets.only(top: 3, bottom: 3, left: 10),
                            height: 40,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  remoteUserdetails.name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Online",
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 12),
                                )
                              ],
                            ),
                          )),
                      IconButton(
                          onPressed: null,
                          iconSize: 25,
                          icon: Icon(
                            Icons.call,
                            size: 25,
                            color: Color(0xFF42b0f8),
                          )),
                      IconButton(
                          onPressed: null,
                          iconSize: 25,
                          icon: Icon(
                            Icons.videocam_rounded,
                            size: 25,
                            color: Color(0xFF42b0f8),
                          )),
                      PopupMenuButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.more_vert_sharp,
                            color: Colors.black38,
                          ),
                          iconSize: 25,
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                    child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      IconButton(
                                          onPressed: null,
                                          icon: Icon(Icons.settings)),
                                      Text("Settings")
                                    ],
                                  ),
                                ))
                              ])
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      color: Color(0xFFf9fdfe),
                      child: ListView(
                        reverse: true,
                        children: sorted()
                            .reversed
                            .map((item) => Padding(
                                  padding: item.sender == _userData['username']
                                      ? EdgeInsets.fromLTRB(64, 4, 16, 4)
                                      : EdgeInsets.fromLTRB(16, 4, 64, 4),
                                  child: Align(
                                    alignment:
                                        item.sender == _userData['username']
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: item.sender ==
                                                      _userData['username']
                                                  ? Radius.zero
                                                  : Radius.circular(20),
                                              topLeft: item.sender ==
                                                      _userData['username']
                                                  ? Radius.circular(20)
                                                  : Radius.zero),
                                          color: item.sender ==
                                                  _userData['username']
                                              ? Colors.blue
                                              : Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0x33000000),
                                                offset: Offset(0, 3),
                                                blurRadius: 3)
                                          ]),
                                      padding: EdgeInsets.all(12),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 2.5),
                                      child: Text(item.message),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    )),
                Container(
                  height: 80,
                  color: Color(0xFFf9fdfe),
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 60.0,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.only(left: 5, right: 10),
                    decoration: BoxDecoration(
                        color: Color(0xFFf1f5f8),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Write something",
                                hintStyle: TextStyle(color: Colors.black45),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFf1f5f8), width: 0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0, color: Color(0xFFf1f5f8)))),
                            onChanged: (value) {
                              setState(() {
                                _message = value;
                              });
                            },
                            controller: _messageController,
                          ),
                        ),
                        IconButton(
                            onPressed: null,
                            icon: Icon(Icons.attachment_outlined)),
                        InkWell(
                          onTap: () {
                            sendTextMsg();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            padding: EdgeInsets.only(left: 4),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                color: Colors.white),
                            child: Icon(
                              Icons.send,
                              color: Color(0xFF48bbf8),
                            ),
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
      ),
    );
  }
}
