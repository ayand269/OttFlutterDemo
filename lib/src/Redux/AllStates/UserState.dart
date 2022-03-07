class UserState {
  Map<String, dynamic> userData = {};
  bool userLogin = false;

  UserState(this.userData, this.userLogin);

  UserState.copyWith(
      {required UserState prev,
      Map<String, dynamic>? userData,
      bool? userLogin}) {
    this.userData = userData ?? prev.userData;
    this.userLogin = userLogin ?? prev.userLogin;
  }

  UserState.initial() {
    userData = {};
    userLogin = false;
  }
}
