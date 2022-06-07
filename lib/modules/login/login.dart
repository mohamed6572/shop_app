import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_Layout.dart';
import 'package:shop_app/modules/Register/register.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

class Login_Screan extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccsesState) {
            if (state.login_model.status) {
              ShowToast(
                  text: state.login_model.message!, state: ToastState.SUCSSES);
              cash_helper
                  .saveData(key: 'token', value: state.login_model.data?.token)
                  .then((value) {
                navigateToAndFinish(context, Home_Layout());
              });
            } else {
              ShowToast(
                  text: state.login_model.message!, state: ToastState.ERROR);
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'login now to browse our hot offers',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 30,
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
                              type: TextInputType.visiblePassword,
                              controller: passwordController,
                              label: 'password ',
                              prefix: Icons.lock,
                              suffix: cubit.sufix,
                              isPassword: cubit.ispass,
                              passwordShow: () {
                                cubit.changevisablepass();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'password must not be empty';
                                }
                              },
                              onSubmeted: (value) {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          BuildCondition(
                            condition: state is! LoginLodingState,
                            fallback: (context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            builder: (context) => defultButton(
                                text: 'Login',
                                Background: defColor,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Dont\'t have an account?'),
                              defultTextButtton(
                                  text: 'register now',
                                  function: () {
                                    navigateTo(context, Register_Screan());
                                  })
                            ],
                          )
                        ],
                      ),
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
