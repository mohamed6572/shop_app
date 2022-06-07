import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_Layout.dart';
import 'package:shop_app/modules/Register/cubit/cubit.dart';
import 'package:shop_app/modules/Register/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constens.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

class Register_Screan extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is RegisterSuccsesState){
            if(state.register_model.status){
              ShowToast(text: state.register_model.message!, state: ToastState.SUCSSES);
              cash_helper.saveData(key: 'token', value: state.register_model.data?.token).then((value) {
                token = state.register_model.data?.token;
                navigateToAndFinish(context, Home_Layout());

              });
            }else{
              ShowToast(text: state.register_model.message!, state: ToastState.ERROR);
            }
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register'.toUpperCase(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(height: 30,),
                        defultFormField(
                            type: TextInputType.name,
                            controller: nameController,
                            label: 'name',
                            prefix: Icons.person,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'name must not be empty';
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        defultFormField(
                            type: TextInputType.emailAddress,
                            controller: emailController,
                            label: 'Email Address',
                            prefix: Icons.email,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email must not be empty';
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        defultFormField(
                            type: TextInputType.phone,
                            controller: phoneController,
                            label: 'phone ',
                            prefix: Icons.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'phone must not be empty';
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        defultFormField(
                            type: TextInputType.visiblePassword,
                            controller: passwordController,
                            label: 'password',
                            prefix: Icons.lock,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'password must not be empty';
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),

                        BuildCondition(
                          condition: state is! RegisterLodingState,
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator(),),
                          builder: (context) =>
                              defultButton(text: 'register',
                                  Background: defColor,
                                  function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                      email: emailController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      password: passwordController.text
                                  );
                                }
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
