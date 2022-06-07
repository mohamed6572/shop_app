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
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => BuildFavoritesItem(cubit.favoritesModel?.data?.data[index].product,context)   ,
            separatorBuilder: (context , index)=> myDivider(),
            itemCount: cubit.favoritesModel?.data?.data.length??0);
      },
    );
  }
  Widget BuildFavoritesItem(Product? model,context)=>Padding(
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
                            )))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
