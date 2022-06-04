import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';

class Register_Screan extends StatelessWidget{
var nameController =TextEditingController();
var emailController =TextEditingController();
var passwordController =TextEditingController();
var phoneController =TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Register'.toUpperCase() ,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.black
                  ),
                ),
                Text(
                  'Register now to browse our hot offers' ,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
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
                defultButton(text: 'register', function: (){})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
