import 'package:flutter/material.dart';
import 'package:shop_app/modules/Register/register.dart';
import 'package:shop_app/shared/components/components.dart';

class Login_Screan extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'password must not be empty';
                        }
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  defultButton(text: 'Login', function: () {}),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Dont\'t have an account?'),
                      defultTextButtton(text: 'register now', function: (){
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
    );
  }
}
