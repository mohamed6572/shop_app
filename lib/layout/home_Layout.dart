import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

class Home_Layout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context,state){
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
          ),
          body: cubit.Screans[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeIndex(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(icon:Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon:Icon(Icons.apps),label: 'Cateogries'),
              BottomNavigationBarItem(icon:Icon(Icons.favorite),label: 'Favorites'),
              BottomNavigationBarItem(icon:Icon(Icons.settings),label: 'Settings'),
            ],
          ),
        
        );
      },
    );
  }
}
