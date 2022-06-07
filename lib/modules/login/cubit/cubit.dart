import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/loginModel.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginintialState());

  static LoginCubit get(context) => BlocProvider.of(context);
 late Login_Model login_model;


  void userLogin({
  required String email,
  required String password,
}){
    emit(LoginLodingState());
    Dio_Helper.postData(url: LOGIN, data: {
      'email' : email,
      'password' : password,
    }).then((value) {
      print(value.data);
      login_model = Login_Model.fromJson(value.data);
      print('=>> ${login_model.data?.name}');

      emit(LoginSuccsesState(login_model));
    }).catchError((error){
      print('error when login is ${error.toString()}');
      emit(LoginErrortate(error.toString()));
    });
    
  }

  IconData sufix = Icons.visibility;
  bool ispass = false ;
  void changevisablepass(){
    ispass = !ispass;
    sufix = ispass ? Icons.visibility : Icons.visibility_off;
    emit(ShopChangePasswordVisibiltyState());
  }

}