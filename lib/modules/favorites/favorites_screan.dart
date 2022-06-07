import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class Favorites_Screan extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return BuildCondition(
          condition: state is! AppLodingGetFavoritesState,
          fallback: (context)=>Center(child: CircularProgressIndicator(),),
          builder:(context)=> ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => BuildFavoritesItem(cubit.favoritesModel?.data?.data[index].product,context)   ,
              separatorBuilder: (context , index)=> myDivider(),
              itemCount: cubit.favoritesModel?.data?.data.length??0),
        );
      },
    );
  }
}
