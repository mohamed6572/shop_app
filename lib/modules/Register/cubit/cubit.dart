import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/registerModel.dart';
import 'package:shop_app/modules/Register/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterintialState());

 late Register_Model register_model;

  static RegisterCubit get(context) => BlocProvider.of(context);
  
  void userRegister({
    required String email,
    required String name,
    required String phone,
    required String password,
}){
    emit(RegisterLodingState());
    Dio_Helper.postData(url: Register, data: {
      'name' : name,
      'email' : email,
      'phone' : phone,
      'password' : password,
    }).then((value) {
      print(value.data);
      register_model = Register_Model.fromJson(value.data);
      print(register_model.data?.name);

      emit(RegisterSuccsesState(register_model));
    }).catchError((error){
      emit(RegisterErrortate(error.toString()));
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