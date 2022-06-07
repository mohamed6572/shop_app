import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../models/carts_model.dart';

class Carts_Screan extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state){
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Your Cart'),
          ),
          body:  BuildCondition(
            condition:  state is! AppLodingGetCartsState,
            fallback: (context)=> Center(child: CircularProgressIndicator(),),
            builder:(context)=> ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => BuildCartsItem(cubit.cartsModel?.data?.cart_items[index].product,context,index)   ,
              separatorBuilder: (context , index)=> myDivider(),
              itemCount: cubit.cartsModel?.data?.cart_items.length??0),
          ),


        );
      },
    );
  }
  Widget BuildCartsItem(  model,context,index)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 200,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,

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
                    SizedBox(height: 20,),
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
                        IconButton(
                            onPressed: () {
                              AppCubit.get(context).ChangeCarts(model?.id??0);

                              // print(model?.id);

                            },
                            icon: Icon(
                              Icons.delete,
                              size: 29,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 5,),
              Container(
                width: 40,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 1.5
                  )
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${AppCubit.get(context).cartsModel?.data?.cart_items[index].quantity}'),
                      Icon(Icons.arrow_drop_down_sharp,size: 18,)
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10,),
          defultButton(text: 'Check Out', function: (){})
        ],
      ),
    ),
  );

}
