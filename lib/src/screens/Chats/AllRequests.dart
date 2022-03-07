import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ott_demo/src/Redux/Store/index.dart';
import 'package:ott_demo/src/components/Card/UserListCard.dart';
import 'package:ott_demo/src/components/Header/ChatHeader.dart';

class UserModel {
  final String name;
  final String userId;
  final bool requested;
  final String description;
  final String image;

  UserModel(
      {required this.name,
      required this.userId,
      required this.requested,
      required this.description,
      required this.image});

  UserModel.fromSnapshot({required Map<dynamic, dynamic> value})
      : this.name = value['name'],
        this.userId = value['username'],
        this.requested = value['requsted'] ?? false,
        this.description = value['description'],
        this.image = value['image'];
}

class AllRequests extends StatefulWidget {
  const AllRequests({Key? key}) : super(key: key);

  @override
  _AllRequestsState createState() => _AllRequestsState();
}

class _AllRequestsState extends State<AllRequests> {
  FirebaseDatabase db = FirebaseDatabase.instance;
  List<UserModel> _requestList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAllRequestList();
  }

  void getAllRequestList() async {
    Map<String, dynamic> _userData =
        StoreProvider.of<AppState>(context, listen: false)
            .state
            .userState
            .userData;

    final fbEvent = await db.ref("/Requests/${_userData['username']}").once();
    if (fbEvent.snapshot.exists) {
      Map<dynamic, dynamic> value =
          Map<dynamic, dynamic>.from(fbEvent.snapshot.value as Map);

      value.forEach((key, val) {
        _requestList.add(UserModel.fromSnapshot(value: val));
      });

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          color: Colors.white,
          child: SafeArea(
            child: Column(
              children: <Widget>[
                ChatHeader(title: "Requests"),
                Expanded(
                    flex: 1,
                    child: Container(
                      color: Color(0xFFf9fdfe),
                      child: ListView(
                        children: _requestList
                            .map((item) => UserListCard(
                                acceptRequest: (id) {
                                  _requestList.removeWhere(
                                      (element) => element.userId == id);

                                  setState(() {});
                                },
                                requestCard: true,
                                name: item.name,
                                description: item.description,
                                imageUrl: item.image,
                                remoteUserid: item.userId,
                                requested: item.requested))
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
