import 'package:shop_app/models/loginModel.dart';

abstract class LoginStates{}

class LoginintialState extends LoginStates{}

class LoginLodingState extends LoginStates{}
class LoginSuccsesState extends LoginStates{
  Login_Model login_model;
  LoginSuccsesState(this.login_model);
}
class LoginErrortate extends LoginStates{
  final String Error;
  LoginErrortate(this.Error);
}
class ShopChangePasswordVisibiltyState extends LoginStates{}
