import 'package:ott_demo/src/Redux/Reducer/UserReducer.dart';
import 'package:ott_demo/src/Redux/Store/index.dart';

AppState appReducer(AppState prevState, action) =>
    AppState(userReducer(prevState.userState, action));
