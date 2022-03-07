import 'package:ott_demo/src/Redux/AllStates/UserState.dart';

class AppState {
  UserState userState = UserState.initial();

  AppState(this.userState);

  AppState.copyWith({required AppState prev, UserState? userState}) {
    this.userState = userState ?? prev.userState;
  }

  AppState.initial() {
    userState = UserState.initial();
  }
}
