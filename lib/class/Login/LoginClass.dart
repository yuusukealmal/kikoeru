class LoginUserClass {
  LoginUserClass({required this.loginUserDetail}) {
    loggedIn = loginUserDetail["loggedIn"];
    name = loginUserDetail["name"];
    group = loginUserDetail["group"];
    email = loginUserDetail["email"];
    recommenderUuid = loginUserDetail["recommenderUuid"];
  }

  final Map<String, dynamic> loginUserDetail;
  late final bool loggedIn;
  late final String name;
  late final String group;
  late final String? email;
  late final String recommenderUuid;
}

class LoginClass {
  LoginClass({required this.loginDetail}) {
    loginUserClass = LoginUserClass(loginUserDetail: loginDetail["user"]);
    token = loginDetail["token"];
  }

  final Map<String, dynamic> loginDetail;
  late final LoginUserClass loginUserClass;
  late final String token;
}
