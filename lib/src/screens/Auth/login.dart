import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ott_demo/src/Redux/Action/action.dart';
import 'package:ott_demo/src/Redux/Store/index.dart';
import 'package:ott_demo/src/Router/route.dart';
import 'package:ott_demo/src/Utils/Storage.dart';
import 'package:ott_demo/src/components/Header/AuthHeader.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseDatabase db = FirebaseDatabase.instance;
  bool loading = false;
  String _username = '';
  String _pass = '';

  void _loginFun() async {
    setState(() {
      loading = true;
    });

    if (_username != '' || _pass != '') {
      DatabaseReference dbRef = db.ref("/users/$_username");
      DatabaseEvent fbEvent = await dbRef.once();
      if (fbEvent.snapshot.exists) {
        Map<String, dynamic> fbData =
            Map<String, dynamic>.from(fbEvent.snapshot.value as Map);

        if (fbData['pass'] == _pass) {
          Fluttertoast.showToast(msg: "Login Success !!!");
          Storage().setItem(key: "auth", value: fbData);
          StoreProvider.of<AppState>(context).dispatch(UserLogin(fbData));
          Navigator.pushNamedAndRemoveUntil(
              context, MyRoutes.home, (route) => false);
        } else {
          Fluttertoast.showToast(msg: "Wrong password !!!");
        }
      } else {
        Fluttertoast.showToast(msg: "Wrong username !!!");
      }
    } else {
      Fluttertoast.showToast(msg: "Enter username and password !!!");
    }

    setState(() {
      loading = false;
      _username = '';
      _pass = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Color.fromRGBO(0, 0, 0, 0)),
        child: Container(
          color: Colors.white,
          child: SafeArea(
            bottom: false,
            child: Column(
              children: <Widget>[
                AuthHeader(),
                Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 200,
                            alignment: Alignment.center,
                            child: Text(
                              "Login Here",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            child: TextFormField(
                              decoration:
                                  InputDecoration(label: Text("Username")),
                              onChanged: (value) {
                                setState(() {
                                  _username = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            child: TextFormField(
                              obscureText: true,
                              decoration:
                                  InputDecoration(label: Text("Password")),
                              onChanged: (value) {
                                setState(() {
                                  _pass = value;
                                });
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Don't have an account?"),
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, MyRoutes.signup),
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text("Sign Up",
                                      style:
                                          TextStyle(color: Colors.lightBlue)),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () {
                              _loginFun();
                            },
                            child: Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Visibility(
                                        visible: loading,
                                        child: LoadingIndicator(
                                            indicatorType: Indicator.ballPulse,
                                            colors: [
                                              Colors.white,
                                            ])),
                                    Visibility(
                                        visible: !loading,
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        )),
                                  ],
                                )),
                          )
                        ],
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
