import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ott_demo/src/Redux/AllStates/UserState.dart';
import 'package:ott_demo/src/Redux/Store/index.dart';
import 'package:ott_demo/src/components/Card/UserListCard.dart';
import 'package:ott_demo/src/components/Header/ChatHeader.dart';

class UserModel {
  final String name;
  final String userId;
  final bool requested;

  UserModel(
      {required this.name, required this.userId, required this.requested});

  UserModel.fromSnapshot({required Map<dynamic, dynamic> value})
      : this.name = value['name'],
        this.userId = value['username'],
        this.requested = value['requsted'] ?? false;
}

class AllUsers extends StatefulWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  FirebaseDatabase db = FirebaseDatabase.instance;

  List<UserModel> _allUsers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUsers();
  }

  void getAllUsers() async {
    Map<String, dynamic> _userData =
        StoreProvider.of<AppState>(context, listen: false)
            .state
            .userState
            .userData;
    final fbEvent = await db.ref("/users").once();

    Map<dynamic, dynamic> value =
        Map<dynamic, dynamic>.from(fbEvent.snapshot.value as Map);

    value.forEach((key, value) async {
      if (value['name'] != _userData['name']) {
        final fbRequestEvent = await db
            .ref("/Requests/${value['username']}/${_userData['username']}")
            .once();

        if (fbRequestEvent.snapshot.exists) {
          value['requsted'] = true;
        }
        _allUsers.add(UserModel.fromSnapshot(value: value));
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
            child: StoreConnector<AppState, UserState>(
              converter: (store) => store.state.userState,
              builder: (context, userState) => Column(
                children: <Widget>[
                  ChatHeader(title: "Users"),
                  Expanded(
                      flex: 1,
                      child: Container(
                        color: Color(0xFFf9fdfe),
                        child: ListView(
                          children: _allUsers
                              .map((item) => UserListCard(
                                    requestCard: false,
                                    requested: item.requested,
                                    remoteUserid: item.userId,
                                    name: item.name,
                                    description: "This is my description",
                                    imageUrl:
                                        "https://media1.popsugar-assets.com/files/thumbor/GGZaFGuz984xPxsLWYciThC031k/401x0:2401x2000/fit-in/2048xorig/filters:format_auto-!!-:strip_icc-!!-/2020/03/12/147/n/45101125/e797e3475e6af0ab153e86.45110527_/i/tom-holland-best-black--white-pictures.jpg",
                                  ))
                              .toList(),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
