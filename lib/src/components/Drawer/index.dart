import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ott_demo/src/Redux/Action/action.dart';
import 'package:ott_demo/src/Redux/AllStates/UserState.dart';
import 'package:ott_demo/src/Redux/Store/index.dart';
import 'package:ott_demo/src/Router/route.dart';
import 'package:ott_demo/src/Utils/Storage.dart';

class DrawerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: StoreConnector<AppState, UserState>(
          converter: (store) => store.state.userState,
          builder: (context, userState) => ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                  child: Container(
                      alignment: Alignment.center,
                      height: 110,
                      padding: EdgeInsets.only(left: 20),
                      child: !userState.userLogin
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(150, 50)),
                              onPressed: () =>
                                  Navigator.pushNamed(context, MyRoutes.login),
                              child: Text("Login"))
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.4),
                                            offset: Offset(0, 5),
                                            blurRadius: 10)
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      color: Color(0xFF424242)),
                                  child: Center(
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15))),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Image(
                                            image:
                                                AssetImage("assets/back.jpg"),
                                            fit: BoxFit.cover,
                                            height: 60,
                                            width: 60,
                                          ))),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      height: 75,
                                      margin: EdgeInsets.only(left: 12),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Hello 👋",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            userState.userData["name"],
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.black87,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ))),
              Divider(
                color: Colors.black,
                height: 30,
                indent: 15,
                endIndent: 15,
              ),
              ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                  selected: true),
              Visibility(
                visible: userState.userLogin,
                child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, MyRoutes.chatTab);
                    },
                    leading: Icon(Icons.chat),
                    title: Text("Chats"),
                    selected: false),
              ),
              Visibility(
                  visible: userState.userLogin,
                  child: ListTile(
                      onTap: () {
                        StoreProvider.of<AppState>(context)
                            .dispatch(UserLogout());
                        Storage().removeItem(key: "auth");
                      },
                      leading: Icon(Icons.logout),
                      title: Text("Logout"),
                      selected: false))
            ],
          ),
        ),
      ),
    );
  }
}
