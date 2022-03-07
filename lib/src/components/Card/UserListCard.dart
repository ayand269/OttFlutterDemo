import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ott_demo/src/Redux/Store/index.dart';
import 'package:uuid/uuid.dart';

class UserListCard extends StatefulWidget {
  final String name;
  final String description;
  final String imageUrl;
  final String remoteUserid;
  final bool requested;
  final bool requestCard;
  final void Function(String)? acceptRequest;
  const UserListCard(
      {Key? key,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.remoteUserid,
      required this.requested,
      required this.requestCard,
      this.acceptRequest})
      : super(key: key);

  @override
  State<UserListCard> createState() => _UserListCardState();
}

class _UserListCardState extends State<UserListCard> {
  FirebaseDatabase db = FirebaseDatabase.instance;

  String _name = '';
  String _description = '';
  String _imageUrl = '';
  String _remoteUserId = '';
  bool _requestSend = false;
  bool _requestCard = false;
  void Function(String)? _acceptRequestFun = null;

  @override
  void initState() {
    super.initState();

    _name = widget.name;
    _description = widget.description;
    _imageUrl = widget.imageUrl;
    _remoteUserId = widget.remoteUserid;
    _requestSend = widget.requested;
    _requestCard = widget.requestCard;
    _acceptRequestFun = widget.acceptRequest;
  }

  void _sendRequest() async {
    Map<String, dynamic> userData =
        StoreProvider.of<AppState>(context, listen: false)
            .state
            .userState
            .userData;
    await db.ref("/Requests/$_remoteUserId/${userData['username']}").set({
      "name": userData['name'],
      "username": userData['username'],
      "description": "This is my description",
      "image":
          "https://media1.popsugar-assets.com/files/thumbor/GGZaFGuz984xPxsLWYciThC031k/401x0:2401x2000/fit-in/2048xorig/filters:format_auto-!!-:strip_icc-!!-/2020/03/12/147/n/45101125/e797e3475e6af0ab153e86.45110527_/i/tom-holland-best-black--white-pictures.jpg"
    });

    setState(() {
      _requestSend = true;
    });
  }

  void _acceptRequest() async {
    Map<String, dynamic> userData =
        StoreProvider.of<AppState>(context, listen: false)
            .state
            .userState
            .userData;

    String _roomId = const Uuid().v4();

    await db.ref("/ChatList/$_remoteUserId/${userData['username']}").set({
      "roomId": _roomId,
      "name": userData['name'],
      "username": userData['username'],
      "image":
          "https://media1.popsugar-assets.com/files/thumbor/GGZaFGuz984xPxsLWYciThC031k/401x0:2401x2000/fit-in/2048xorig/filters:format_auto-!!-:strip_icc-!!-/2020/03/12/147/n/45101125/e797e3475e6af0ab153e86.45110527_/i/tom-holland-best-black--white-pictures.jpg"
    });

    await db.ref("/ChatList/${userData['username']}/$_remoteUserId").set({
      "roomId": _roomId,
      "name": _name,
      "username": _remoteUserId,
      "image":
          "https://media1.popsugar-assets.com/files/thumbor/GGZaFGuz984xPxsLWYciThC031k/401x0:2401x2000/fit-in/2048xorig/filters:format_auto-!!-:strip_icc-!!-/2020/03/12/147/n/45101125/e797e3475e6af0ab153e86.45110527_/i/tom-holland-best-black--white-pictures.jpg"
    });

    await db.ref("/Chat/$_roomId").set({"roomId": _roomId});

    db.ref("/Requests/${userData['username']}/$_remoteUserId").set(null);
    _acceptRequestFun!(_remoteUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.network(_imageUrl),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 60,
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _name,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    _description,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
          _requestCard
              ? InkWell(
                  onTap: () => _acceptRequest(),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.green[400]),
                    child: Text(
                      "Accept",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                )
              : InkWell(
                  onTap: () => _sendRequest(),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: !_requestSend
                            ? Colors.blue[300]
                            : Colors.orange[300]),
                    child: Text(
                      !_requestSend ? "Send Request" : "Requested",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
