import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';

class Cateogries_Screan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => BuildItem(cubit.categories_model?.data?.data[index])   ,
            separatorBuilder: (context , index)=> myDivider(),
            itemCount: cubit.categories_model?.data?.data.length??0);
      },
    );
  }
  Widget BuildItem(DataModel? model)=> Padding(
    padding: EdgeInsets.all(20),
    child: Row(
      children: [
        Image(image: NetworkImage('${model?.image}'),
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 20,),
        Text('${model?.name}',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
        Spacer(), Icon(Icons.arrow_forward_ios)],
    ),
  );
}
