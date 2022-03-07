import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ott_demo/src/components/Header/AuthHeader.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool loading = false;
  String _username = '';
  String _name = '';
  String _email = '';
  String _pass = '';
  String _cPass = '';
  FirebaseDatabase db = FirebaseDatabase.instance;

  void registerFun() async {
    setState(() {
      loading = true;
    });
    if (_username != '' || _name != '' || _email != '' || _pass != '') {
      if (_pass == _cPass) {
        DatabaseReference dbRef = db.ref("/users/$_username");
        DatabaseEvent fbEvent = await dbRef.once();

        if (!fbEvent.snapshot.exists) {
          await dbRef.set({
            "name": _name,
            "username": _username,
            "email": _email,
            "pass": _pass
          });
          Fluttertoast.showToast(msg: "Register Successfully !!!");
        } else {
          Fluttertoast.showToast(msg: "Username already exists !!!");
        }
      } else {
        Fluttertoast.showToast(msg: "Confirm password not matched !!!");
      }
    } else {
      Fluttertoast.showToast(msg: "All field required !!!");
    }

    setState(() {
      loading = false;
      _name = '';
      _username = '';
      _email = '';
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
                    child: SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 130,
                              alignment: Alignment.center,
                              child: Text(
                                "Register Here",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              child: TextFormField(
                                decoration:
                                    InputDecoration(label: Text("Name")),
                                onChanged: (val) {
                                  setState(() {
                                    _name = val;
                                  });
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                              child: TextFormField(
                                decoration:
                                    InputDecoration(label: Text("Email")),
                                onChanged: (val) {
                                  setState(() {
                                    _email = val;
                                  });
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              child: TextFormField(
                                decoration:
                                    InputDecoration(label: Text("Username")),
                                onChanged: (val) {
                                  setState(() {
                                    _username = val;
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
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              child: TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                    label: Text("Confirm Password")),
                                onChanged: (value) {
                                  setState(() {
                                    _cPass = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Already have an account?"),
                                InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text("Sign In",
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
                                registerFun();
                                // setState(() {
                                //   loading = true;
                                // });
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
                                              indicatorType:
                                                  Indicator.ballPulse,
                                              colors: [
                                                Colors.white,
                                              ])),
                                      Visibility(
                                          visible: !loading,
                                          child: Text(
                                            "Register",
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
