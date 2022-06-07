import 'package:shop_app/models/registerModel.dart';

abstract class RegisterStates{}

class RegisterintialState extends RegisterStates{}

class RegisterLodingState extends RegisterStates{}
class RegisterSuccsesState extends RegisterStates{
  Register_Model register_model;
  RegisterSuccsesState(this.register_model);
}
class RegisterErrortate extends RegisterStates{
  final String Error;
  RegisterErrortate(this.Error);
}
class ShopChangePasswordVisibiltyState extends RegisterStates{}
