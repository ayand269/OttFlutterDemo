import 'package:ott_demo/src/Redux/Action/action.dart';
import 'package:ott_demo/src/Redux/AllStates/UserState.dart';

UserState userReducer(UserState prevState, dynamic action) {
  if (action is UserLogin) {
    return UserState.copyWith(
        prev: prevState, userData: action.userData, userLogin: true);
  } else if (action is UserLogout) {
    return UserState.initial();
  }

  return prevState;
}
