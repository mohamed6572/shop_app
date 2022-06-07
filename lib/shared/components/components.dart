import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';


void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);

Widget defultTextButtton(
        {required String text, required void Function()? function}) =>
    TextButton(onPressed: function, child: Text(text.toUpperCase()));

Widget defultFormField({
  required TextInputType type,
  required TextEditingController controller,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isPassword = false,
  required String? Function(String? val)? validator,
  void Function(String val)? onChanged,
  VoidCallback? passwordShow,
  VoidCallback? onTap,
  void Function(String)? onSubmeted,
}) =>
    TextFormField(
      onTap: onTap,
      onFieldSubmitted: onSubmeted,
      onChanged: onChanged,
      obscureText: isPassword,
      validator: validator,
      keyboardType: type,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        border: OutlineInputBorder(),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: passwordShow,
              )
            : null,
      ),
    );

Widget defultButton({
  double width = double.infinity,
  Color Background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required String text,
  required VoidCallback function,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Background,
      ),
    );

void ShowToast({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      gravity:ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: chooseToastColor(state),
      fontSize: 16.0,
      textColor: Colors.white
    );

enum ToastState { SUCSSES, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  late Color color;
  switch (state) {
    case ToastState.SUCSSES:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget SignOut({required context}) =>
  defultTextButtton(text: 'SignOut', function: () {
    cash_helper.removeData(key: 'token').then((value) {
      navigateToAndFinish(context, Login_Screan());
    });
  });

Widget myDivider()=> Padding(
  padding: const EdgeInsets.symmetric(vertical: 10),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[400],
  ),
);

Widget BuildFavoritesItem( model,context,{bool isOldPrice =true})=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),

          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model?.image}'),
                width: 120,
                height: 120,
              ),
              if (model?.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 5, vertical: 2),
                  color: Colors.red,
                  child: Text(
                    'DISCOUNT ${model?.discount} %',
                    style: TextStyle(color: Colors.white, fontSize: 9),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(width: 20,),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model?.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, height: 1.3),
              ),
              Row(
                children: [
                  Text(
                    '${model?.price}',
                    style: TextStyle(fontSize: 12, color: defColor),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (model?.discount != 0)
                    Text(
                      '${model?.oldPrice}',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  if( AppCubit.get(context).carts[model?.id]!)
                    Icon(
                      Icons.shopping_cart,
                      size: 22,
                      color: Colors.amber,
                    ),
                  SizedBox(width: 5,),
                  IconButton(
                      onPressed: () {
                        AppCubit.get(context).ChangeFavourites(model?.id??0);
                        print(model?.id);

                      },
                      icon: CircleAvatar(
                          radius: 15,
                          backgroundColor: AppCubit.get(context).favorits[model?.id]! ? defColor: Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 16,
                            color: Colors.white,
                          ))),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  ),
);


