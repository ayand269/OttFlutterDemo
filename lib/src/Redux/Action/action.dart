abstract class Action {}

class UserLogin extends Action {
  Map<String, dynamic> userData;

  UserLogin(this.userData);
}

class UserLogout extends Action {}
