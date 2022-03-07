import 'package:flutter/material.dart';
import 'package:ott_demo/src/Redux/Reducer/index.dart';
import 'package:ott_demo/src/Redux/Store/index.dart';
import 'package:ott_demo/src/Router/route.dart';
import 'package:ott_demo/src/screens/Auth/Signup.dart';
import 'package:ott_demo/src/screens/Auth/login.dart';
import 'package:ott_demo/src/screens/Chats/ChatList.dart';
import 'package:ott_demo/src/screens/Chats/ChatTab.dart';
import 'package:ott_demo/src/screens/Chats/SingleChat.dart';
import 'package:ott_demo/src/screens/Home/index.dart';
import 'package:ott_demo/src/screens/Movies/SingleMovies.dart';
import 'package:ott_demo/src/screens/Search/Search.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Store<AppState> _store =
      Store<AppState>(appReducer, initialState: AppState.initial());

  runApp(App(
    store: _store,
  ));
}

class App extends StatelessWidget {
  final Store<AppState> store;

  const App({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => Home(),
          MyRoutes.home: (context) => Home(),
          MyRoutes.login: (context) => Login(),
          MyRoutes.signup: (context) => Signup(),
          MyRoutes.singleMovies: (context) => SingleMovies(),
          MyRoutes.search: (context) => Search(),
          MyRoutes.chatTab: (context) => ChatTab(),
          MyRoutes.singleChat: (context) => SingleChat()
        },
        // themeMode: ThemeMode.dark,
        // darkTheme: ThemeData(brightness: Brightness.dark),
      ),
    );
  }
}
