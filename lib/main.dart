import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/home_Layout.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/onBoarding/onBoarding.dart';
import 'package:shop_app/shared/Bloc_Observer.dart';
import 'package:shop_app/shared/components/constens.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes/themes.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      Dio_Helper.init();
     await cash_helper.init();
      bool? onBoard = cash_helper.getData(key: 'onboard');
       token = cash_helper.getData(key: 'token');
       print(token);
      Widget widget ;
      if(onBoard !=null){
        if(token !=null) widget = Home_Layout();
        else widget =  Login_Screan();
      }else{
        widget = onBoarding();
      }



      runApp(MyApp(start: widget,));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  Widget start ;
  MyApp({required this.start});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context) =>  AppCubit()..getHomeData()..getCategoriesData()..GetFavorites()..getProfile()..GetCarts()
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: start,
      ),
    );
  }
}
